require "net/http"
require "json"
require "uri"

class MovieFetcher
  CACHE_TTL = 10.minutes

  class << self
    def fetch(query)
      query = query.to_s.strip
      return [] if query.blank?

      Rails.logger.info("[MovieFetcher] Buscando filmes para: '#{query}'")

      cache_key = "movies:search:#{query.downcase.parameterize}"
      Rails.cache.fetch(cache_key, expires_in: CACHE_TTL) do
        response = search_movie(query)
        format_movies(response)
      end
    rescue => e
      Rails.logger.error("[MovieFetcher] Erro inesperado: #{e.class} - #{e.message}")
      []
    end

    private

    def search_movie(query)
      url = URI("#{ENV['MOVIE_URL']}search/movie?query=#{URI.encode_www_form_component(query)}&include_adult=false&language=pt-BR&page=1")
      response = request(url)
      JSON.parse(response.body)["results"] || []
    rescue => e
      Rails.logger.error("[MovieFetcher] Falha na busca: #{e.message}")
      []
    end

    def format_movies(movies)
      movies.map do |movie|
        cache_key = "movies:details:#{movie['id']}"
        Rails.cache.fetch(cache_key, expires_in: CACHE_TTL) do
          MovieFormatter.format_movie(movie)
        end
      end.compact
    end

    def request(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      req = Net::HTTP::Get.new(url)
      req["accept"] = "application/json"
      req["Authorization"] = "Bearer #{ENV['MOVIE_TOKEN']}"
      http.request(req)
    end
  end
end
