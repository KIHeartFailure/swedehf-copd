load(file = paste0(datapath, "/data/", datadate, "/lmswedehf.RData"))

# Select ATC codes --------------------------------------------------------

lmsel <- lmswedehf %>%
  mutate(atcneed = stringr::str_detect(ATC, "^R0")) %>%
  filter(
    ANTAL >= 0,
    atcneed
  )

rm(lmswedehf)
gc()

lmsel <- left_join(
  rsdata %>%
    select(lopnr, shf_indexdtm),
  lmsel,
  by = "lopnr"
) %>%
  mutate(diff = as.numeric(EDATUM - shf_indexdtm)) %>%
  filter(diff >= -30.5 * 5, diff <= 14) %>%
  select(lopnr, shf_indexdtm, EDATUM, ATC)

rsdata <- create_medvar(
  atc = "^(R03CC04|R03CC02|R03CC03|R03AC13)", medname = "rabas",
  cohortdata = rsdata,
  meddata = lmsel,
  id = "lopnr",
  valsclass = "fac",
  indexdate = shf_indexdtm
)

rsdata <- create_medvar(
  atc = "^(R03CC04|R03CC02|R03CC11)", medname = "sabas",
  cohortdata = rsdata,
  meddata = lmsel,
  id = "lopnr",
  valsclass = "fac",
  indexdate = shf_indexdtm
)

rsdata <- create_medvar(
  atc = "^(R03BB01|R03BB04|R03BB05|R03BB07)", medname = "samas",
  cohortdata = rsdata,
  meddata = lmsel,
  id = "lopnr",
  valsclass = "fac",
  indexdate = shf_indexdtm
)

rsdata <- create_medvar(
  atc = "^(R03AC13|R03CC12|R03CC63|R03AC13|R03AK06|R03AL03)", medname = "labas",
  cohortdata = rsdata,
  meddata = lmsel,
  id = "lopnr",
  valsclass = "fac",
  indexdate = shf_indexdtm
)

rsdata <- create_medvar(
  atc = "^(R03AC18|R03AC19)", medname = "ulabas",
  cohortdata = rsdata,
  meddata = lmsel,
  id = "lopnr",
  valsclass = "fac",
  indexdate = shf_indexdtm
)

rsdata <- create_medvar(
  atc = "^(R03BB05|R03BB06|R03BB04|R03BB07)", medname = "lamas",
  cohortdata = rsdata,
  meddata = lmsel,
  id = "lopnr",
  valsclass = "fac",
  indexdate = shf_indexdtm
)

rsdata <- create_medvar(
  atc = "^(R03BB04|R03BB54)", medname = "ulamas",
  cohortdata = rsdata,
  meddata = lmsel,
  id = "lopnr",
  valsclass = "fac",
  indexdate = shf_indexdtm
)

rsdata <- create_medvar(
  atc = "^(R03BA01|R03BA08|R03BA05|R01AD04|R03BA02)", medname = "inhaledglucocorticoids",
  cohortdata = rsdata,
  meddata = lmsel,
  id = "lopnr",
  valsclass = "fac",
  indexdate = shf_indexdtm
)

rsdata <- create_medvar(
  atc = "^(R03DA04|R03DC03)", medname = "copd_others",
  cohortdata = rsdata,
  meddata = lmsel,
  id = "lopnr",
  valsclass = "fac",
  indexdate = shf_indexdtm
)

rsdata <- create_medvar(
  atc = "^(R03CC04|R03CC02|R03CC03|R03AC13|R03CC11|R03BB01|R03BB04|R03BB05|R03BB07|R03AC13|R03CC12|R03CC63|R03AC13|R03AK06|R03AL03|R03AC18|R03AC19|R03BB06|R03BB54|R03BA01|R03BA08|R03BA05|R01AD04|R03BA02|R03DA04|R03DC03)",
  medname = "copd_all",
  cohortdata = rsdata,
  meddata = lmsel,
  id = "lopnr",
  valsclass = "fac",
  indexdate = shf_indexdtm
)

rm(lmsel)
gc()

metalm <- metalm %>%
  mutate(ATC = str_replace_all(ATC, ",", ", ")) %>%
  select(-Register)
