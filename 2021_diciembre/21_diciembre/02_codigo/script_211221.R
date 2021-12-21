## Visualizacion de datos
# 20/diciembre/2021

# Remover notacion cientifica
options(scipen = 999)

# library
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(cowplot)
library(ggthemes)

## Datos
mascotas <- read_excel("mascotas.xlsx")

# Fuentes

library(extrafont)
font_import()
loadfonts(device="win", quiet = TRUE)
fonts() 

# Grafico

mascotas=mascotas[order(mascotas$pctaje),]
mascotas$edo=factor(mascotas$edo,levels=mascotas$edo)

mascotas %>%
  ggplot(aes(x= pctaje, y= edo, fill = pctaje)) +
  geom_col(width = 0.7, position = "dodge") +
  scale_fill_gradient(low = "#EEDD82", high = "#8B814C")+ #color de las columnas
  labs(title = "Porcentaje de hogares que declaran tener algún tipo de mascota",  #Título principal
       caption = "Fuente: Encuesta Nacional de Bienestar Aurreportado, 2021",
       x = "Porcentaje",
       y = "Estado",
       fill = "Porcentaje") +
  theme_minimal() +
  theme(text=element_text(size=9,  family="Gadugi"))



