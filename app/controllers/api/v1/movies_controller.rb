module Api
  module V1
    class MoviesController < ApplicationController
      def search
        query = params[:q].to_s.strip

        if query.blank?
          return render json: { error: "Parâmetro q é obrigatório" }, status: :bad_request
        end

        Rails.logger.info("[MoviesController] Buscando filmes para: #{query}")

        begin
          results = MovieFetcher.fetch(query)
          render json: { query: query, results: results }, status: :ok
        rescue => e
          Rails.logger.error("[MoviesController] Erro: #{e.message}")
          render json: { error: "Erro ao buscar filmes" }, status: :service_unavailable
        end
      end
    end
  end
end
