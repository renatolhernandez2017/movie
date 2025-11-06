require "rails_helper"
require "webmock/rspec"

RSpec.describe MovieFetcher do
  before do
    Rails.cache.clear

    stub_request(:get, %r{search/movie})
      .to_return(
        status: 200,
        body: {
          results: [
            { "id" => 1, "title" => "Homem Aranha", "poster_path" => "/poster.jpg" }
          ]
        }.to_json,
        headers: { "Content-Type" => "application/json" }
      )

    stub_request(:get, %r{/movie/1})
      .to_return(
        status: 200,
        body: {
          "id" => 1,
          "title" => "Homem Aranha",
          "overview" => "Peter Parker luta contra o crime.",
          "poster_path" => "/poster.jpg",
          "similar" => {
            "results" => [
              { "title" => "Venom", "poster_path" => "/venom.jpg" }
            ]
          },
          "credits" => {
            "cast" => [
              { "id" => 100, "name" => "Tobey Maguire", "profile_path" => "/tobey.jpg" }
            ]
          }
        }.to_json,
        headers: { "Content-Type" => "application/json" }
      )

    stub_request(:get, %r{/person/100/movie_credits})
      .to_return(
        status: 200,
        body: {
          "cast" => [
            { "title" => "Homem Aranha" },
            { "title" => "O Grande Gatsby" }
          ]
        }.to_json,
        headers: { "Content-Type" => "application/json" }
      )
  end

  it "retorna filmes formatados corretamente e usa cache" do
    first_call = MovieFetcher.fetch("Homem Aranha")

    expect(first_call).to be_an(Array)
    expect(first_call.first[:title]).to eq("Homem Aranha")
    expect(first_call.first[:cast].first[:name]).to eq("Tobey Maguire")

    # cache evita novas requisições HTTP
    expect(WebMock).to have_requested(:get, %r{search/movie}).once
  end

  it "retorna lista vazia em caso de erro" do
    stub_request(:get, %r{search/movie}).to_raise(StandardError.new("Falha de rede"))
    expect(MovieFetcher.fetch("Homem Aranha")).to eq([])
  end
end
