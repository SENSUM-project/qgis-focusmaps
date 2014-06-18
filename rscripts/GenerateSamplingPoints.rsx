##SENSUM=group
##density_layer=raster
##sampling_points=output vector
##scaling_coefficient=number 0.01
library(focusmapr)
library(spatstat)
rast=NormalizeLayer(density_layer)
mbox=bbox(rast)
mat=as.matrix(flip(rast,'y'))
ndens=as.im(mat*scaling_coefficient)
Z=rpoispp(ndens)
#rescale the points on the raster extent
x=Z$x*((mbox[1,2]-mbox[1,1])/ndens$xrange[2])+mbox[1,1]
y=(Z$y)*((mbox[2,2]-mbox[2,1])/ndens$yrange[2])+mbox[2,1]
out=SpatialPoints(cbind(x,y))
#re-set original projection
crs(out)=crs(density_layer)
sampling_points=SpatialPointsDataFrame(out,as.data.frame(out))
