# TMDB MVP (Rails API)

## Visão geral
API simples para buscar filmes na base pública The Movie Database (TMDb) e retornar dados prontos para frontend.

---

## 🧱 Arquitetura

- **Rails 7.1.6** – Framework principal.
- **Ruby 3.3.1** – Linguagem principal.
- **Docker e Docker-compose.yaml** – Para executar o ambiente de Desenvolvimento
- **PostgreSQL** – Banco de dados relacional.

---

## Como rodar localmente

No terminal:
Clonar o projeto via https ou ssh

- HTTPS -> git clone https://github.com/renatolhernandez2017/movie.git
- SSH -> git clone git@github.com:renatolhernandez2017/movie.git

Acessar pasta:
- cd movie

Subir o projeto:
- docker-compose down
- docker-compose build
- docker-compose up

## Endpoint principal
- `GET /api/v1/movies/search?q=Homem Aranha`

## Exemplo
http://localhost:3000/api/v1/movies/search?q=Homem Aranha

### Exemplo de Resposta:
```json
{
  "query": "homem aranha",
  "results": [
    {
      "title": "Homem-Aranha",
      "overview": "Peter Parker é um jovem estudioso que vive com seus tios, Ben e May, desde que seus pais faleceram. Peter tem dificuldade em se relacionar com seus colegas, por ser tímido e por eles o considerarem um nerd. Até que, em uma demonstração científica, um acidente inesperado faz com que uma aranha modificada geneticamente pique Peter. A partir de então seu corpo é quimicamente alterado pela picada da aranha.",
      "poster_url": "https://image.tmdb.org/t/p/w500/2WIwz0qJpnVAiofTAhrmhbKxuvE.jpg",
      "similar": [
        {
          "title": "Behold the Raven",
          "poster_url": "https://image.tmdb.org/t/p/w500/me3aB9T0q6B0PvCcRYix33PL1Jy.jpg"
        },
        {
          "title": "Barbarella",
          "poster_url": "https://image.tmdb.org/t/p/w500/kOIVwpDSlLQxJzuBXQFvqdIEYjd.jpg"
        },
        {
          "title": "A.I.: Inteligência Artificial",
          "poster_url": "https://image.tmdb.org/t/p/w500/nd2GPbJZFnqYWGeKk9foPMWnvqa.jpg"
        }
      ],
      "cast": [
        {
          "name": "Tobey Maguire",
          "profile_url": "https://image.tmdb.org/t/p/w500/s6PwSvq6gC7PGEjIku69tPbvR8M.jpg",
          "known_for": [
            "O Segredo de Berlim",
            "Homem-Aranha 3",
            "Homem-Aranha 2"
          ]
        },
        {
          "name": "Willem Dafoe",
          "profile_url": "https://image.tmdb.org/t/p/w500/ui8e4sgZAwMPi3hzEO53jyBJF9B.jpg",
          "known_for": [
            "Procurando Nemo",
            "O Plano Perfeito",
            "A Vida Marinha com Steve Zissou"
          ]
        },
        {
          "name": "Kirsten Dunst",
          "profile_url": "https://image.tmdb.org/t/p/w500/5dI5s8Oq2Ook5PFzTWMW6DCXVjm.jpg",
          "known_for": [
            "Brilho Eterno de uma Mente sem Lembranças",
            "Homem-Aranha",
            "Homem-Aranha 3"
          ]
        }
      ]
    }
  ]
}
```

## Para rodar os testes
- docker-compose exec movie bundle exec rspec

## Link aplicação pública
https://movie-4fd98fb60329.herokuapp.com/api/v1/movies/search?q=Homem Aranha