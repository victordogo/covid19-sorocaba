## O presente codigo tem como utilidade a leitura de dados da pandemia referentes
## a cidade de Sorocaba. Os dados são: novos casos diarios e acumulados, novas
## mortes diarias e acumuladas, bem como data e populacao estimada.

## Dados relativos a vacinacao nao serao encontrados neste banco de dados.

covid <- readr::read_csv("https://data.brasil.io/dataset/covid19/caso_full.csv.gz") |>
  dplyr::select(
    city, date, estimated_population, last_available_confirmed,
    last_available_deaths, new_confirmed, new_deaths
  )

covid_sorocaba <- covid |>
  dplyr::filter(city=="Sorocaba")

covid_sorocaba |> readr::write_rds("docs/data/covid_sorocaba.rds")
