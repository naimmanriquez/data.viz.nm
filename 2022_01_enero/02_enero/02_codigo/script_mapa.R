# Capas shp
## https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=889463807469


# Abrimos las paqueterías con un sólo comando:
library(pacman)

p_load(ineq, haven, readr, readxl, ggplot2, shiny, tidyverse, expss, 
       DescTools, lmtest, MASS, knitr,gmodels, foreign, RColorBrewer)


##############
#Paqueterías para mapear
library(sf)
#install.packages("ggspatial")
library("ggspatial")
library("colorspace")
#hcl_palettes(plot = TRUE)

##############
#Abrir capas para mapas
##############

##############
#AGEBs
ageb_shp <- st_read("05a.shp")

#Crear variable para filtrar por municipios de interés
ageb_shp$mun <- substr(ageb_shp$CVEGEO, 3, 5)

#Filtrar 
ageb_saltillo <- ageb_shp %>%    
  filter (mun == "030")

## Mapa Saltillo
plot(ageb_saltillo)

## Datos censo
RESAGEB20 <- read_excel("RESAGEBURB_05.xlsx")

# Filtrar por municipio
ageb_datos <- RESAGEB20 %>%    
  filter (MUN == "030")

ageb_urbanas <- ageb_datos %>% 
  filter (NOM_LOC == "Total AGEB urbana")

ageb_urbanas <- rename(ageb_urbanas, CVE_AGEB = AGEB)

# Union de bases

bd_final <- left_join(ageb_saltillo, ageb_urbanas)

bd_final <- bd_final %>%
  mutate_at("POBTOT", ~as.numeric(.)) 

mapa <- ggplot(bd_final) +
  geom_sf(aes(fill = POBTOT)) +
  ggtitle("Población total") +
  scale_fill_gradientn(colors=brewer.pal(name="Oranges", n=6)) + theme_void()

mapa

mapa_final <- mapa + 
  scale_fill_gradientn(colours = rev(rainbow(7)),
                       breaks = c(1000, 3000, 5000))

mapa_final

## mas opciones
pal <- brewer.pal(7, "OrRd") # we select 7 colors from the palette
class(pal)

plot(bd_final["POBTOT"], 
     main = "Poblacion por AGEB en Saltillo (Coahuila), México",
     cex.main=1.1,
     breaks = "quantile", nbreaks = 7,
     pal = pal)


# mas con leaflet
# https://rstudio.github.io/leaflet/
# Leaflet es una librería utilizada para la publicación de mapas en la web.
# Providers 
# https://leaflet-extras.github.io/leaflet-providers/preview/

library(leaflet) 

# reproject
saltillo_leaflet <- st_transform(bd_final, 4326)

leaflet(saltillo_leaflet) %>%
  addPolygons()

pal_fun <- colorQuantile("YlOrRd", NULL, n = 5)

p_popup <- paste0("<strong>Poblacion: </strong>", bd_final$POBTOT)

leaflet(saltillo_leaflet) %>%
  addPolygons(
    stroke = FALSE, # remove polygon borders
    fillColor = ~pal_fun(POBTOT), # set fill color with function from above and value
    fillOpacity = 0.8, smoothFactor = 0.5, # make it nicer
    popup = p_popup)  # add popup

leaflet(saltillo_leaflet) %>%
  addPolygons(
    stroke = FALSE, 
    fillColor = ~pal_fun(POBTOT),
    fillOpacity = 0.8, smoothFactor = 0.5,
    popup = p_popup) %>%
  addTiles()

