#Resources for agroforestry team

## Sesync resources

Guides to the SESYNC resources for teams can be found on the [cyberhelp](cyberhelp.sesync.org) webpage. You should also get an intro to the resources as a part of the pursuit program. 

A few pages that would be particularly usefully to you all

- [Quick start guide](https://cyberhelp.sesync.org/quickstart/), especially the Rstudio server
- [Using the sesync cluster](https://cyberhelp.sesync.org/quickstart/Using-the-SESYNC-Cluster.html)
- You all will probably just use [rslurm package](http://cyberhelp.sesync.org/rslurm/) in the rstudio sesync server. It is already on the Rstudio server so would not need to install. 

## Spatial data

- You will want use a mix of the raster package and the sf package for your analysis. The documenation for these packages may be helpful--[raster](https://cran.r-project.org/web/packages/raster/raster.pdf) and [sf](https://cran.r-project.org/web/packages/sf/sf.pdf)
- If your raster files are very big and you do not want to merge all the tiles, you can use a "virtual raster" in the r package gdal using [gdalbuiltvrt](https://gdal.org/programs/gdalbuildvrt.html). This might be something to think about later once you are using the full dataset. 


