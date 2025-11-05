# tmdb-mvp (Rails API)

## Requisitos
- Ruby 3.1+ (recomendado 3.2)
- Rails 7+
- Bundler
- (Opcional) Redis para cache em produção

## Setup local
1. Clone o repositório
2. `bundle install`
3. Copie `.env.example` para `.env` e adicione `TMDB_API_KEY=<sua_chave_tmdb>`
4. `rails db:create db:migrate` (aplicação em modo API mas mantive DB ready)
5. `rails s -p 3000`
6. Request de exemplo:

curl "http://localhost:3000/api/v1/movies/search?q=Homem%20Aranha"

