
# covid19-sorocaba

![](/docs/images/logo-proex-ufscar.png)

Este é o repositório do site "A COVID-19 em Sorocaba". Ele é o resultado do Projeto de Extensão  "Análise e Visualização dos Dados da Pandemia na Cidade de Sorocaba", sob fomento da ProEx - Pró Reitoria de Extensão da UFSCar - Universidade Federal de São Carlos.

Ele é realizado por Victor Alves Dogo Martins (aluno do DEs - Departamento de Estatística da UFSCar - Campus São Carlos), sob orientação da Profa. Dra. Andreza Aparecida Palma (vinculada ao DEc - Departamento de Economia da UFSCar - Campus Sorocaba). 

## Objetivo

O objetivo deste projeto é fornecer um *dashboard* conciso e de fácil compreensão com dados relativos à pandemia da COVID-19 na cidade de Sorocaba - SP. Estes dados, ao longo do tempo, consistem em casos confirmados, mortes confirmadas e em esforços da campanha de vacinação na cidade. Ele pode ser conferido em: (link).

## Recursos Técnicos

Todos os dados, gráficos e formatação do dashboard são construídos com auxílio da linguagem de programação estatística R:

* O dashboard é construído com o auxílio do pacote [`{flexdashboard}`](https://pkgs.rstudio.com/flexdashboard/);
* Os dados são tratados com auxílio dos pacotes do [tidyverse](https://www.tidyverse.org/);
* Os gráficos são produzidos, em suas versões estáticas, com auxílio do pacote [`{ggplot2}`](https://ggplot2.tidyverse.org/). Depois, são transformados em versões interativas com auxílio do pacote [`{plotly}`](https://plotly.com/r/);
* O site é publicado com auxílio do GitHub Pages;
* As bases de dados são retiradas dos sites brasil.io (no caso de dados relativos a casos e mortes) e basedosdados.org (no caso de dados da vacinação). Os dados em si não são criados por eles, mas eles constituem uma **importante parte deste trabalho** devido ao fato de disponibilizarem diversas bases ora bagunçadas e difíceis de trabalhar em formatos muito mais amigáveis e que agilizam o processo de análise;
* **Próximos passos:** o intuito futuro deste site é ser atualizado automaticamente através de ferramentas de integração contínua (como o GitHub Actions).


Todos os códigos utilizados podem ser vistos no repositório do site.

## Contato

Quaisquer dúvidas, críticas, elogios e sugestões podem ser encaminhadas por e-mail para victordogo@gmail.com .

