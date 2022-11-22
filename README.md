# CsvReport

## Requisitos de sistema

- Docker

## Rodando a aplicação

- Inicie o container em modo desacoplado: `docker-compose up --build`
- Rode as seeds: `docker exec -it web mix run priv/repo/seeds.exs`
- A aplicação estará disponível em `localhost:4000`

### Rodando os tests

- Para rodar a suite completa de testes: `docker exec -it tests mix test`

### Gerando o arquivo CSV

- Endpoint: `POST /csv_report/:report_name`
- Opções de `report_name`: "DailyRegistrations" e "DailyRegistrationsByPartner"
- Caso deseje filtrar por range de data, o body da requisição deverá conter:
  `{`
      `"filters": {`
          `"start_date": "YYYY-MM-DD",`
          `"end_date": "YYYY-MM-DD"`
      `}`
  `}`

  É necessário tanto `start_date` quanto `end_date`, caso seja usado o filtro.