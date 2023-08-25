# Project specific packages, functions and settings -----------------------

source(here::here("setup/setup.R"))

# Load data ---------------------------------------------------------------

load(here(datapath, "data/v410/rsdata410.RData"))
# rsdata410 <- rsdata410 %>% # remove this
#  sample_n(3000) # remove this

# Munge data --------------------------------------------------------------

source(here("munge/01-vars.R"))
source(here("munge/02-pop-selection.R"))
source(here("munge/03-pdr-medication.R"))
source(here("munge/04-npr-comorb-outcome.R"))
source(here("munge/05-fix-vars.R"))
source(here("munge/06-mi.R"))
source(here("munge/07-crr-mi-vars.R"))

# Cache/save data ---------------------------------------------------------

save(
  file = here("data/clean-data/data.RData"),
  list = c(
    "rsdata",
    "imprsdata",
    "metalm",
    "metaout",
    "metavars",
    "flow",
    "modvars",
    "tabvars", 
    "stratavars"
  )
)
