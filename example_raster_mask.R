# A little about my objective : I wanted a raster for climate variables (19 in total) masked by distributions of walnut tree species. I also buffered the species distributions to give a little room for error.

#Load libraries 
library(raster)
library(sf)

# load bioclim files for 2 different US regions
setwd('~/Dropbox/M/Rhagoletis/SDM')

#make a list of the files to read in
file12<-list.files(path='wc0.5', pattern='_12.bil', full.names=T)
file13<-list.files(path='wc0.5', pattern='_13.bil', full.names=T)

#read in files and stack into raster stack
f12<-stack(file12) # one for each bioclim variable, stack into single object
f13<-stack(file13)

# you can also plot each one if not too big
plot(f12)

# load in species distribution data shape files for each species
cal<-st_read('shp_files/juglcali/juglcali.shp')
hin<-st_read('shp_files/juglhind/juglhind.shp')
nig<-st_read('shp_files/juglnigr/juglnigr.shp')
maj<-st_read('shp_files/juglmajo/juglmajo.shp')
micr<-st_read('shp_files/juglmicr/juglmicr.shp')

# buffer the distributions by .5 map units (not km.)
nig<-st_buffer(nig,.5)
maj<-st_buffer(maj,.5)
micr<-st_buffer(micr,.5)
cal<-st_buffer(cal,.5)
hin<-st_buffer(hin,.5)

# mask bioclim variables by species distribution shape files and then merge
temp<-mask(f12,nig)
temp2<-mask(f12, maj)
t3<-mask(f12, micr)
t4<-mask(f12, cal)
t5<-mask(f12, hin)

M<-merge(temp, temp2) # can only merge 2 at a time so had to do many merge
M2<-merge(M, t3)
M3<-merge(M2, t4)
M4<-merge(M3, t5)

# repeat for region 13
t.13<-mask(f13,nig)
temp2<-mask(f13, maj)
t3<-mask(f13, micr)
t4<-mask(f13, cal)
t5<-mask(f13, hin)

M.13<-merge(t.13, temp2)
M2.13<-merge(M.13, t3)
M3.13<-merge(M2.13, t4)
M4.13<-merge(M3.13, t5)

# merge tiles
bioBuff<-merge(M4, M4.13) 

# bioBuff object is the full region masked by species distribution that can be used in analysis
