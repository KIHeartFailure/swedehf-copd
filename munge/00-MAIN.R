# Project specific packages, functions and settings -----------------------

source(here::here("setup/setup.R"))

# Load data ---------------------------------------------------------------

load(here(datapath, "data/v410/rsdata410.RData"))
load(here(datapath, "data/v410/meta_statreport.RData"))

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
    "stratavars",
    "outvars",
    "ccimeta",
    "deathmeta",
    "outcommeta"
  )
)


# create workbook to write tables to Excel
wb <- openxlsx::createWorkbook()
openxlsx::addWorksheet(wb, sheet = "Information")
openxlsx::writeData(wb, sheet = "Information", x = "Tables in xlsx format for tables in Statistical report: Loop Diuretic Therapy as a Prognostic Enrichment Factor for Clinical Trials in Patients with Heart Failure with mrEF and pEF", rowNames = FALSE, keepNA = FALSE)
openxlsx::saveWorkbook(wb,
  file = here::here("output/tabs/tables.xlsx"),
  overwrite = TRUE
)
