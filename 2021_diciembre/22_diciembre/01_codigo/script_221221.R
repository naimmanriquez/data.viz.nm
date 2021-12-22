# Librerias ----
library(tidyverse)
library(ggplot2)
library(hrbrthemes)
library(ggtext)
library(extrafont)

# Notacion cientifica
options(scipen = 999)

# Fuentes
fonts() 

# Leer datos
exportacion <- read_excel("exportacion.xlsx")

# Gráfica

exportacion %>%
  ggplot(aes(x=fecha,
             y=tequila_litros)) +
  geom_line(size = 1) +
  geom_point(pch = 21, size = 3, fill = "red") +
  labs(title = "Exportación de tequila",
       subtitle = "2013-2020",
       x = "", y = "Volumen de exportación (en litros)",
       caption = "Fuente: Elaboración propia con datos del Sistema de Información Arancelaria.
       Checado el 22 de diciembre del 2021.
       http://www.economia-snci.gob.mx/" ) +
  theme_bw() +
  theme(legend.position = "bottom",
        text = element_text(family = "Corbel"),
        plot.title = element_text(family = "Corbel", face = "bold", hjust = 0.5, size = 15),
        plot.subtitle = element_text(family = "Corbel", hjust = 0.5, color = "gray50", size = 12),
        plot.caption = element_text(hjust = 1, size = 10, family = "Corbel"),
        axis.title = element_markdown(family = "Corbel", size = 10),
        legend.title = element_text(family = "Corbel", size = 10, face = "bold"),
        legend.text = element_text(family = "Corbel", size = 7),
        panel.grid.major = element_line(color = "gray90"),
        panel.grid.minor = element_line(color = "gray95"),
        axis.text = element_text(family = "Corbel", size = 10),
        axis.ticks = element_line(color = "brown"),
        panel.border = element_rect(size = 1))
