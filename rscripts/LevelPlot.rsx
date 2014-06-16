##[Own Scripts] = group
##layer = raster
##showplots
library(rasterVis)
myPal <- terrain.colors(20)
levelplot(layer,col.regions=myPal,contour=T)