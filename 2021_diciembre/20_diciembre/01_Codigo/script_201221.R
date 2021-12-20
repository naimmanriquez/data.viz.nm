## Visualizacion de datos
# 20/diciembre/2021

# Remover notacion cientifica
options(scipen = 999)

# Librerias
library(readxl)
library(tidyverse)
library(ggplot2)
library(hrbrthemes)
library(ggthemes)

# Leer datos
exportacion <- read_excel("exportacion.xlsx")

# Datos
head(exportacion)

## Grafica
ggplot(data = exportacion, aes(x = fecha, y = mezcal_litros))+
  geom_line()

# Grafica 2
exportacion %>%
  tail(10) %>%
  ggplot(aes(x=fecha, y=mezcal_litros)) +
  geom_line( color="grey") +
  geom_point(shape=21, color="black", fill="#69b3a2", size=3) +
  labs(x="Fecha", y="Volumen (miles de litros)",
     title="Exportación de mezcal por año",
     subtitle="Miles de litros",
     caption="Fuente: Elaboración propia con datos del SIAVI") + 
  scale_color_ipsum() +
  theme_ipsum_rc()



