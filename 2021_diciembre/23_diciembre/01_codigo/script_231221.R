## Cargamos librerias 

library(pacman)
p_load(sjmisc, sjlabelled, tidyverse, dplyr, ggplot2)

## Carga de base de datos
## concentradohogar <- read_dta("concentradohogar.dta") # Por si lo cargan desde Stata

concentradohogar <- readRDS("concentradohogar.rds")

## Nombres de las variables
names(concentradohogar)

## Descriptivos
summary(concentradohogar$ing_cor)

# Nueva base filtrada quitando datos atipicos
hogares <- concentradohogar %>%
  filter(ing_cor %in% c(4000:900000))

summary(hogares$esparci)

# Nos quedamos solo con los que gastan mas de 100 pesos
esparcimiento <- hogares %>%
  filter(esparci %in% c(100:900000))


summary(esparcimiento$esparci)

# Cambiamos nombre a valores de NSE
esparcimiento$est_socio<- factor(esparcimiento$est_socio,label= c("Bajo", "Medio bajo", "Medio alto", "Alto"))



## Grafica

ggplot(esparcimiento, aes(x = ing_cor, 
                     y = esparci, 
                     color=est_socio, 
                     size = ing_cor)) +
  geom_point(alpha = .6) +
  labs(x = "Ingreso corriente trimestral",
       title = "Ingreso trimestral vs gasto en esparcimiento y NSE",
       subtitle = "Gasto en artículos y servicios de esparcimiento",
       caption = "Fuente: Encuesta Nacional de Ingresos y Gastos de los Hogares, 2020",
       y = "",
       color = "NSE",
       size = "Ingreso") +
theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 12),
        plot.subtitle = element_text(hjust = 0.5, size = 10))

