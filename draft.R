library(terra)
library(sf)
library(sp)
library(raster)
library(ggmap)
library(tidyr)
      
valtellina <- read_sf(dsn = "./data/vector", layer = "valtellina")

#Get Coordinates Extent
v <- vect(valtellina)
utm <- terra::project(v, "+proj=utm +zone=32")
ext(utm) |> round()
geo <- terra::project(v, "+proj=longlat")
ext(geo) |> round(1)
as.points(ext(utm), crs=crs(utm)) |> project("+proj=longlat") |> crds()

#Get Area
st_area(valtellina)

#Get Base Map
register_google(key = #Key)
basemap <- get_map(location = c(lon = 10.7, lat = 46.64179),
                         color = "color", source = "google", 
                         maptype = "satellite", zoom = 12)
crs(valtellina)
valtellina <- st_transform(valtellina, crs = "+proj=merc")

valtellina$geometry

ggmap(basemap)

+
  geom_sf(data = valtellina)+
  coord_sf(crs = st_crs(32632))

map_df <- as.data.frame(mapImageData3,xy=TRUE)

ggplot(data = valtellina_transformed) +
  geom_sf()+
  coord_sf(expand=FALSE)+
  labs(x='Longitude',y='Latitude',
       title="Study Area",
       subtitle='Valtellina Valley, Italy',
       caption='Source: Zindi') +
  cowplot::theme_cowplot()+
  theme(panel.grid.major = element_line(color = gray(.5),
                                        linetype = 'dashed',
                                        linewidth = 0.1),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill=NA,color = 'black'),
        panel.ontop = TRUE,
        axis.title.x = element_text(size = 12), 
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10))