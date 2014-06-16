##SENSUM= group
##input_rasters=multiple rasters
##focus_map=output raster
##low_rejection_bound=number 0.01
##high_rejection_bound=number 0.99
##pooling_str=string loglinear
##resample_rasters=boolean True
##equal_weighting=boolean True
##weight_1=number 0.25
##weight_2=number 0.25
##weight_3=number 0.25
##weight_4=number 0.25


library(focusmapr)
library(raster)
library(rgdal)

n_layers = length(input_rasters)

if (n_layers<2 | n_layers>4) rp.messagebox('number of layers must be between 2 and 4', title = 'oops!')

inp_weights=c(weight_1,weight_2,weight_3,weight_4)

if (equal_weighting)
{
inp_weights[1:n_layers]=1/n_layers
}

layers=input_rasters

if (resample_rasters)
{layers=ResampleLayers(input_rasters)}

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

