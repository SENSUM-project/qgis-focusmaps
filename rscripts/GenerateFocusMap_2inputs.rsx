##SENSUM= group
##input_raster1=rasters
##input_raster2=rasters
##focus_map=output raster
##low_rejection_bound=number 0.01
##high_rejection_bound=number 0.99
##pooling_str=string loglinear
##resample_rasters=boolean True
##equal_weighting=boolean True
##weight_1=number 0.25
##weight_2=number 0.25


library(focusmapr)
library(raster)
library(rgdal)

inp_weights=c(weight_1,weight_2)

if (equal_weighting)
{
inp_weights[1:2]=0.5
}

layers=c(input_raster1,input_raster2)

if (resample_rasters)
{layers=ResampleLayers(layers)}

rej_bds <- c(low_rejection_bound,high_rejection_bound)

str <- pooling_str
if (str !='linear' & str != 'loglinear'){
rp.messagebox('you must enter "linear" or "loglinear"', title = 'oops!')
} else {
norm_layers<-lapply(layers,FUN=function(x) NormalizeLayer(x,rej=rej_bds))
if (str =='loglinear')
{ focus_map=FocusMap(norm_layers,pooling="loglinear",weigths=inp_weights) }
else
{focus_map=FocusMap(norm_layers,pooling="linear",weigths=inp_weights) }
}
