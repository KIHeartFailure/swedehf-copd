# Cut outcomes to 5 years -------------------------------------------------

rsdata <- cut_surv(rsdata, sos_out_deathcvhosphf, sos_outtime_hosphf, at = 365 * 5, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_hosphf, sos_outtime_hosphf, at = 365 * 5, cuttime = TRUE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_deathcv, sos_outtime_death, at = 365 * 5, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_death, sos_outtime_death, at = 365 * 5, cuttime = FALSE, censval = "No")
rsdata <- cut_surv(rsdata, sos_out_deathnoncv, sos_outtime_death, at = 365 * 5, cuttime = TRUE, censval = "No")

rsdata <- rsdata %>%
  mutate(
    sos_com_copd2 = factor(
      case_when(
        sos_com_copd == "No" ~ 1,
        sos_com_nohospcopd12mo <= 1 ~ 2,
        TRUE ~ 3
      ),
      levels = 1:3,
      labels = c("No COPD", "COPD without hospitalization", "COPD >=1 hospitalization")
    ),
    shf_indexyear_cat = factor(case_when(
      shf_indexyear <= 2010 ~ "2005-2010",
      shf_indexyear <= 2015 ~ "2011-2015",
      shf_indexyear <= 2021 ~ "2016-2021"
    )),
    sos_out_deathcvhosphf_cr = create_crevent(sos_out_deathcvhosphf, sos_out_death, eventvalues = c("Yes", "Yes")),
    sos_out_deathcv_cr = create_crevent(sos_out_deathcv, sos_out_death, eventvalues = c("Yes", "Yes")),
    sos_out_hosphf_cr = create_crevent(sos_out_hosphf, sos_out_death, eventvalues = c("Yes", "Yes")),
    sos_out_deathnoncv_cr = create_crevent(sos_out_deathnoncv, sos_out_death, eventvalues = c("Yes", "Yes"))
  )

# income

inc <- rsdata %>%
  group_by(shf_indexyear) %>%
  summarise(incmed = quantile(scb_dispincome,
    probs = 0.5,
    na.rm = TRUE
  ), .groups = "drop_last")

rsdata <- left_join(
  rsdata,
  inc,
  by = "shf_indexyear"
) %>%
  mutate(
    scb_dispincome_cat = case_when(
      scb_dispincome < incmed ~ 1,
      scb_dispincome >= incmed ~ 2
    ),
    scb_dispincome_cat = factor(scb_dispincome_cat,
      levels = 1:2,
      labels = c("Below median within year", "Above median within year")
    )
  ) %>%
  select(-incmed)

# ntprobnp

ntprobnp <- rsdata %>%
  group_by(shf_ef_cat) %>%
  summarise(
    ntmed = quantile(shf_ntprobnp,
      probs = 0.5,
      na.rm = TRUE
    ),
    .groups = "drop_last"
  )

rsdata <- left_join(
  rsdata,
  ntprobnp,
  by = c("shf_ef_cat")
) %>%
  mutate(
    shf_ntprobnp_cat = case_when(
      shf_ntprobnp < ntmed ~ 1,
      shf_ntprobnp >= ntmed ~ 2
    ),
    shf_ntprobnp_cat = factor(shf_ntprobnp_cat,
      levels = 1:2,
      labels = c("Below median within EF", "Above median within EF")
    )
  ) %>%
  select(-ntmed)

## Create numeric variables needed for comp risk model
rsdata <- create_crvar(rsdata, "sos_com_copd")
rsdata <- create_crvar(rsdata, "sos_com_copd2")
