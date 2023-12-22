library(raster)
library(leaflet)
library(sp)
library(sf)

dem  <- raster('thesis/dem_original.tif')
valtellina  <- read_sf('thesis/valtellina_aoi.shp')

plot(dem)
masked <- mask(x = dem, mask = valtellina)
plot(masked)