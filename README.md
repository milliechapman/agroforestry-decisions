# agroforestry-decisions

## Authors:

- Millie Chapman, @milliechapman
- Xorla Ocloo
- Lauren Hunt
- Katelyn Stenger
- Zoe Hastings

## Description:
While agroforestry is promoted as a promising climate mitigation opportunity, .....



## Analyses and Data
All data can be found in the `data` folder

All analyses are avaiilable in the `scripts` folder

### Common files

- `README.md` this file, a general overview of the repository in markdown format.  

### Infrastructure for Testing

- `.travis.yml`: A configuration file for automatically running [continuous integration](https://travis-ci.com) checks to verify reproducibility of all `.Rmd` notebooks in the repo.  If all `.Rmd` notebooks can render successfully, the "Build Status" badge above will be green (`build success`), otherwise it will be red (`build failure`).  
- `DESCRIPTION` a metadata file for the repository, based on the R package standard. It's main purpose here is as a place to list any additional R packages/libraries needed for any of the `.Rmd` files to run.
- `tests/render_rmds.R` an R script that is run to execute the above described tests, rendering all `.Rmd` notebooks. 
