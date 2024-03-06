# Read metadata for variables ---------------------------------------------

metavars <- read.xlsx(here(datapath, "metadata/meta_variables.xlsx"))

# Variables for baseline tables -----------------------------------------------

tabvars <- c(
  # demo
  "shf_indexyear_cat",
  "shf_sex",
  "shf_age",
  "shf_age_cat",

  # organizational
  "shf_location",
  "shf_followuphfunit",
  "shf_followuplocation_cat",

  # clinical factors and lab measurements
  "shf_ef_cat",
  "shf_durationhf",
  "shf_nyha",
  "shf_nyha_cat",
  "shf_killip",
  "shf_bmi",
  "shf_bmi_cat",
  "shf_bpsys",
  "shf_bpdia",
  "shf_map",
  "shf_map_cat",
  "shf_heartrate",
  "shf_heartrate_cat",
  "shf_gfrckdepi",
  "shf_gfrckdepi_cat",
  "shf_potassium",
  "shf_potassium_cat",
  "shf_hb",
  "shf_ntprobnp",
  "shf_ntprobnp_cat",

  # treatments
  "shf_rasiarni",
  "shf_mra",
  "shf_digoxin",
  "shf_diuretic",
  "shf_nitrate",
  "shf_asaantiplatelet",
  "shf_anticoagulantia",
  "shf_statin",
  "shf_bbl",
  "shf_device_cat",
  "shf_sglt2",
  "sos_lm_rabas",
  "sos_lm_sabas",
  "sos_lm_samas",
  "sos_lm_labas",
  "sos_lm_ulabas",
  "sos_lm_lamas",
  "sos_lm_ulamas",
  "sos_lm_inhaledglucocorticoids",
  "sos_lm_copd_others",
  "sos_lm_copd_all",

  # comorbs
  "shf_smoke",
  "shf_sos_com_diabetes",
  "shf_sos_com_hypertension",
  "shf_sos_com_ihd",
  "sos_com_pad",
  "sos_com_stroke",
  "shf_sos_com_af",
  "shf_anemia",
  "sos_com_valvular",
  "sos_com_liver",
  "sos_com_cancer3y",
  "sos_com_renal",
  "sos_com_sleepapnea",
  "sos_com_depression",
  "sos_com_charlsonci",
  "sos_com_charlsonci_cat",

  # socec
  "scb_famtype",
  "scb_child",
  "scb_education",
  "scb_dispincome_cat",
  "shf_qol",
  "shf_qol_cat"
)

# Variables for models (imputation, log, cox reg) ----------------------------

tabvars_not_in_mod <- c(
  "shf_age",
  "shf_nyha",
  "shf_killip",
  "shf_bpsys",
  "shf_bpdia",
  "shf_map",
  "shf_heartrate",
  "shf_gfrckdepi",
  "shf_hb",
  "shf_ntprobnp",
  "shf_potassium",
  "shf_bmi",
  "sos_com_renal",
  "sos_com_charlsonci",
  "sos_com_charlsonci_cat",
  "shf_sglt2",
  "shf_qol",
  "shf_qol_cat",
  "sos_lm_rabas",
  "sos_lm_sabas",
  "sos_lm_samas",
  "sos_lm_labas",
  "sos_lm_ulabas",
  "sos_lm_lamas",
  "sos_lm_ulamas",
  "sos_lm_inhaledglucocorticoids",
  "sos_lm_copd_others",
  "sos_lm_copd_all"
)

modvars <- tabvars[!(tabvars %in% tabvars_not_in_mod)]
stratavars <- c("shf_location", "shf_age_cat")

outvars <- tibble(
  var = c("sos_out_deathcvhosphf", "sos_out_deathcv", "sos_out_hosphf", "sos_out_nohosphf", "sos_out_death", "sos_out_deathnoncv"),
  time = c("sos_outtime_hosphf", "sos_outtime_death", "sos_outtime_hosphf", "sos_outtime_death", "sos_outtime_death", "sos_outtime_death"),
  name = c("CVD/First HFH", "CVD", "First HFH", "Total HFH", "All-cause mortality", "Non-CVD"),
  composite = c(1, 0, 0, 0, 0, 0),
  rep = c(0, 0, 0, 1, 0, 0),
  primary = c(1, 0, 0, 0, 0, 0),
  order = c(1, 2, 3, 4, 5, 6)
) %>%
  arrange(order)
