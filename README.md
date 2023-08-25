## Usage

```
# Setting up the project 
# Setting up renv (management of package dependencies)
renv::init() 
install.packages("ProjectTemplate")
## install.packages("Any other packages in global.dcf")
renv::snapshot()

# Setting up git (version control)

## Delete existing git folder .git

## Add to .gitignore in main directory:
## TODO
## OLD
## checks/
## data/
## docs/
## output/

## Create a new remote repository https://github.com/ for the project
## Set up a new git repository with a remote with Git Bash: 
### $ cd "path/my-new-project"
### $ git init
### $ git remote add origin https://github.com/username/my-new-project
### $ git push -u origin master
```

# Example README for project: 

# R code for the project XXX

The aim of this R code is to be transparent and document the data handling 
and statistical analyses performed for the project.

## Language 

English. 

## Data

The data consists of Swedish individual patient data and is not public, 
and therefore no data is stored in this repository. 

## Instructions

Since the data is not available the code can not be run as is. 

Workflow: 

1. Run munge/MAIN.R (loads data, munges and cache data)

2. Knit reports/Statistical_report_XX.Rmd

## Publication

... 
