##SENSUM=group
##vec_layer = vector
##dens = output raster
##showplots
library(maptools)
library(spatstat)
library(raster)

vecpro1=proj4string(vec_layer)
p=as.ppp(vec_layer)
p1=density(p)
p1r=raster(p1$v,xmn=p1$xrange[1],xmx=p1$xrange[2],ymn=p1$yrange[1],ymx=p1$yrange[2],crs=CRS(vecpro1))
dens=flip(p1r,'y')
plot(dens)
