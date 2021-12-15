## O presente codigo tem como utilidade a leitura de dados da pandemia referentes
## a cidade de Sorocaba. Os dados são referentes a população dividida por grupo
## etário e sexo, quantidade e porcentagens de pessoas com 1 e 2 doses da vacina.

basedosdados::set_billing_id(secret_project_id)

# Lendo banco de dados da vacina

dados_vacina <- basedosdados::bdplyr("basedosdados-dev.br_ms_vacinacao_covid19.microdados") |>
  dplyr::filter(sigla_uf == "SP",
                id_municipio_estabelecimento == "3552205") |>
  dplyr::select(data_aplicacao_vacina,
                idade_paciente,
                sexo_paciente,
                dose_vacina) |>
  basedosdados::bd_collect() |>
  dplyr::rename(sexo="sexo_paciente") |>
  dplyr::filter(dose_vacina!="Reforço",
                sexo!="I") |>
  dplyr::mutate(dose_vacina=ifelse(stringr::str_detect(dose_vacina, "1"), 1, 2)) |>
  dplyr::mutate(grupo_idade = dplyr::case_when(
    idade_paciente <=4 ~ "0-4 anos",
    idade_paciente >=5 & idade_paciente <=9 ~ "5-9 anos",
    idade_paciente >=10 & idade_paciente <=14 ~ "10-14 anos",
    idade_paciente >=15 & idade_paciente <=19 ~ "15-19 anos",
    idade_paciente >=20 & idade_paciente <=24 ~ "20-24 anos",
    idade_paciente >=25 & idade_paciente <=29 ~ "25-29 anos",
    idade_paciente >=30 & idade_paciente <=34 ~ "30-34 anos",
    idade_paciente >=35 & idade_paciente <=39 ~ "35-39 anos",
    idade_paciente >=40 & idade_paciente <=44 ~ "40-44 anos",
    idade_paciente >=45 & idade_paciente <=49 ~ "45-49 anos",
    idade_paciente >=50 & idade_paciente <=54 ~ "50-54 anos",
    idade_paciente >=55 & idade_paciente <=59 ~ "55-59 anos",
    idade_paciente >=60 & idade_paciente <=64 ~ "60-64 anos",
    idade_paciente >=65 & idade_paciente <=69 ~ "65-69 anos",
    idade_paciente >=70 & idade_paciente <=74 ~ "70-74 anos",
    idade_paciente >=75 & idade_paciente <=79 ~ "75-79 anos",
    idade_paciente >=80 ~ "80_mais"
  )) |>
  dplyr::select(grupo_idade, sexo, dose_vacina) |>
  dplyr::group_by(grupo_idade, sexo, dose_vacina) |>
  dplyr::summarise(n = dplyr::n())

dados_vacina |> readr::write_rds("docs/data/dados_vacina.rds")

# Lendo banco de dados da população

populacao_scb <- basedosdados::bdplyr("basedosdados-dev.br_ms_populacao.municipio") |>
  dplyr::filter(id_municipio=="3552205",
                ano==2020) |>
  dplyr::select(sexo,
                grupo_idade,
                populacao) |>
  basedosdados::bd_collect() |>
  dplyr::mutate(sexo = dplyr::recode(sexo,
                                     "masculino" = "M",
                                     "feminino" = "F"))

populacao_scb |> readr::write_rds("docs/data/populacao_scb.rds")

# Juntando dois bancos num só

vacina_scb <- dados_vacina |>
  dplyr::left_join(populacao_scb, by=c("grupo_idade","sexo")) |>
  dplyr::mutate(n_grafico = ifelse(sexo == "M", n*(-1), n),
                populacao_grafico = ifelse(sexo == "M", populacao*(-1), populacao),
                porc = round((n/populacao)*100, digits = 1))

vacina_scb$grupo_idade <- factor(vacina_scb$grupo_idade,
                                 levels = c( "0-4 anos",
                                             "5-9 anos",
                                             "10-14 anos",
                                             "15-19 anos",
                                             "20-24 anos",
                                             "25-29 anos",
                                             "30-34 anos",
                                             "35-39 anos",
                                             "40-44 anos",
                                             "45-49 anos",
                                             "50-54 anos",
                                             "55-59 anos",
                                             "60-64 anos",
                                             "65-69 anos",
                                             "70-74 anos",
                                             "75-79 anos",
                                             "80_mais"))

vacina_scb |> readr::write_rds("docs/data/vacina_scb")
