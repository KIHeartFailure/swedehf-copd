# default is to use tidyverse functions
select <- dplyr::select
rename <- dplyr::rename
filter <- dplyr::filter
mutate <- dplyr::mutate
complete <- tidyr::complete

# used for calculation of ci
global_z05 <- qnorm(1 - 0.025)

datapath <- "C:/Users/Lina/STATISTIK/Projects/20210525_shfdb4/dm/"
datadate <- "20220908"
