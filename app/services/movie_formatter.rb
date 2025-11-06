class MovieFormatter
  class << self
    def format_movie(movie)
      details = fetch_details(movie["id"])

      {
        title: details["title"],
        overview: details["overview"],
        poster_url: poster(details["poster_path"]),
        similar: extract_similars(details),
        cast: extract_cast(details)
      }
    rescue => e
      Rails.logger.error("[MovieFormatter] Erro ao formatar filme #{movie['id']}: #{e.message}")
      nil
    end

    private

    def fetch_details(id)
      url = URI("#{ENV['MOVIE_URL']}movie/#{id}?append_to_response=credits,similar&language=pt-BR")
      JSON.parse(MovieFetcher.send(:request, url).body)
    end

    def extract_similars(details)
      (details.dig("similar", "results") || []).first(3).map do |s|
        { title: s["title"], poster_url: poster(s["poster_path"]) }
      end
    end

    def extract_cast(details)
      (details.dig("credits", "cast") || []).first(3).map do |actor|
        {
          name: actor["name"],
          profile_url: poster(actor["profile_path"]),
          known_for: person_movies(actor["id"])
        }
      end
    end

    def person_movies(person_id)
      url = URI("#{ENV['MOVIE_URL']}person/#{person_id}/movie_credits?language=pt-BR")
      data = JSON.parse(MovieFetcher.send(:request, url).body)
      (data["cast"] || []).first(3).map { |m| m["title"] }
    rescue
      []
    end

    def poster(path)
      path ? "#{ENV['IMAGE_URL']}#{path}" : nil
    end
  end
end
