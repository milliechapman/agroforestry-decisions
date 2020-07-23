# examples with shape and raster files using a partial protected areas shape file and raster for mean annual temperature in the US

library(sf)
prot_areas <- st_read('usa_protected_areas_shp/usa_protected_areas.shp')

library(raster)
mean_temp11 <- raster('mean_ann_temp_shp/bio1_11.bil')
mean_temp12<- raster('mean_ann_temp_shp/bio1_12.bil')
mean_temp13<- raster('mean_ann_temp_shp/bio1_13.bil')

#merge into one file
mean_12_11<-merge(mean_temp11, mean_temp12)
mean_ann_temp<-merge(mean_12_11, mean_temp13)

# projection of shape file so that can do buffer in meeters
st_crs(prot_areas)

prj <- '+proj=aea +lat_1=29.5 +lat_2=45.5 \
    +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0    \
    +ellps=GRS80 +towgs84=0,0,0,0,0,0,0   \
    +units=m +no_defs'

prot_areas <- st_transform(prot_areas, crs = prj)

# buffer by 1 km
buffer_prot_area<- st_buffer(prot_areas, 1000)

# raster projection
crs(mean_temp12)
# doesnsn't have anything included but i know that it is lat long projection

# tranform back to lat long project so can get extraction
buffer_prot_area <- st_transform(buffer_prot_area, crs = 4326)

# only did 2 protected areas here as an example
sample_temp <-extract(mean_temp12, buffer_prot_area[5:6,], fun=mean)
rownames(sample_temp) <- buffer_prot_area$NAME[5:6] # name rows by protected area

#mask by extent of shape file 
crop(mean_temp13, st_bbox(buffer_prot_area)) # i think this might work?
st_bbox(buffer_prot_area)
mask(mean_temp13, extent = c(xmin, xmax, ymin, ymax)) # get extent from bbox

# can also crop!
crop(mean_temp13, st_bbox(buffer_prot_area)) # i think this might work?

# or go other way
st_crop(buffer_prot_area, extent(mean_ann_temp))

# group protected areas by state
state_prot_areas<-buffer_prot_area %>%
  group_by(SUB_LOC) %>%
  summarize(geometry=st_union(geometry))

# extracting temperature by state for and getting average
extract(mean_temp12, state_prot_areas, fun=mean, na.rm= T)


# sample plot code base R
plot(mean_temp12)
plot(buffer_prot_area[,"PARENT_ISO"], add=T)


# sample ggplot code
library(ggplot2)
library(maps)
ggplot(data=prot_areas) +
  geom_polygon(data=map_data("state"), 
               aes(x=long, y=lat, group=group), fill='white', col='black') +
  geom_sf(aes(fill = SUB_LOC)) +
  theme(legend.position = 'none')


# just FYI here is how I filtered the shape file to just get the US. I just downloaded the shp files from wdpa website. 
shp <- st_read('~/Downloads/WDPA_Jul2020-shapefile/WDPA_Jul2020-shapefile0/WDPA_Jul2020-shapefile-polygons.shp', stringsAsFactors=FALSE)

usa_pa <-shp %>%
  filter(PARENT_ISO=='USA')
st_write(usa_pa, 'usprotected/us_protected_areas.shp')