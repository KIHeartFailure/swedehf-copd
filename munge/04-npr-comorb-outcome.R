load(file = paste0(datapath, "/data/", datadate, "/patregrsdata.RData"))

rsdata <- create_sosvar(
  sosdata = patregrsdata %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  noof = TRUE,
  type = "com",
  stoptime = -365.25,
  name = "nohospcopd12mo",
  diakod = " J4[0-4]",
  valsclass = "num",
  warnings = FALSE,
  meta_reg = "NPR (in-patient)"
)

rsdata <- create_sosvar(
  sosdata = patregrsdata %>% filter(sos_source == "sv"),
  cohortdata = rsdata,
  patid = lopnr,
  indexdate = shf_indexdtm,
  sosdate = INDATUM,
  diavar = HDIA,
  type = "out",
  stoptime = 365 * 5,
  name = "counthosphf",
  diakod = " I110| I130| I132| I255| I420| I423| I425| I426| I427| I428| I429| I43| I50| J81| K761| R570",
  noof = TRUE,
  censdate = censdtm,
  valsclass = "num",
  warnings = FALSE
)

rm(patregrsdata)
gc()

metaout <- metaout %>%
  mutate(
    Code = str_replace_all(Code, ",", ", "),
    Position = str_replace_all(Position, "DIA_all", "All positions")
  )
