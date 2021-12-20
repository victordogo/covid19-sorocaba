cores <- c("População estimada (Masculino)" = "#ffc3a4",
           "1ª Dose (M)" = "#EE5A45",
           "2ª Dose ou Única (M)" = "#790000",
           "População estimada (Feminino)" = "#7bd1cb",
           "1ª Dose (F)" = "#1E8F89",
           "2ª Dose ou Única (F)" = "#00322f")

teste <- vacina_scb |>
  ggplot2::ggplot(ggplot2::aes(x = grupo_idade, y=n_grafico))+
  ggplot2::geom_bar(data=vacina_scb[vacina_scb$sexo == "F",] |>
                      dplyr::distinct(populacao_grafico, .keep_all = TRUE),
                    ggplot2::aes(x = grupo_idade,
                                 y = populacao_grafico,
                                 fill = "População estimada (Feminino)"),
                    stat = "identity")+
  ggplot2::geom_bar(data=vacina_scb[vacina_scb$sexo == "M",] |>
                      dplyr::distinct(populacao_grafico, .keep_all = TRUE),
                    ggplot2::aes(x = grupo_idade,
                                 y = populacao_grafico,
                                 fill = "População estimada (Masculino)"),
                    stat = "identity")+
  ggplot2::geom_bar(data=vacina_scb[vacina_scb$sexo == "F",] |>
             dplyr::filter(dose_vacina == '1'),
             ggplot2::aes(fill = "1ª Dose (F)"),
             stat = "identity")+
  ggplot2::geom_bar(data=vacina_scb[vacina_scb$sexo == "M",] |>
                      dplyr::filter(dose_vacina == '1'),
                      ggplot2::aes(fill = "1ª Dose (M)"),
                      stat = "identity")+
  ggplot2::geom_bar(data=vacina_scb[vacina_scb$sexo == "F",] |>
                      dplyr::filter(dose_vacina == '2'),
                    ggplot2::aes(fill = "2ª Dose ou Única (F)"),
                    stat = "identity")+
  ggplot2::geom_bar(data=vacina_scb[vacina_scb$sexo == "M",] |>
                      dplyr::filter(dose_vacina == '2'),
                    ggplot2::aes(fill = "2ª Dose ou Única (M)"),
                    stat = "identity")+
  ggplot2::labs(x="Faixa Etária",y="Vacinados",
                title="Vacinação na cidade de Sorocaba")+
  ggplot2::scale_fill_manual(values = cores,
                             limits = c("População estimada (Masculino)",
                                        "1ª Dose (M)",
                                        "2ª Dose ou Única (M)",
                                        "2ª Dose ou Única (F)",
                                        "1ª Dose (F)",
                                        "População estimada (Feminino)"))+
  ggplot2::guides(fill=ggplot2::guide_legend(nrow=1,byrow=TRUE))+
  ggplot2::theme_minimal()+
  ggplot2::theme(
    plot.title = ggplot2::element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = ggplot2::element_text(hjust = 0.5),
    axis.text = ggplot2::element_text(size = 12),
    axis.title = ggplot2::element_text(size = 12, face = "bold"),
    plot.background = ggplot2::element_rect(fill = "white", color = "white")
  )+
  ggplot2::coord_flip()

teste |> plotly::ggplotly()
