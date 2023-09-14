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
        sos_com_nohospcopd12mo >= 1 ~ 3,
        TRUE ~ 2
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
  reframe(incsum = list(enframe(quantile(scb_dispincome,
    probs = c(0.33, 0.66),
    na.rm = TRUE
  ))), .by = shf_indexyear) %>%
  unnest(cols = c(incsum)) %>%
  pivot_wider(names_from = name, values_from = value)

rsdata <- left_join(
  rsdata,
  inc,
  by = "shf_indexyear"
) %>%
  mutate(
    scb_dispincome_cat = factor(
      case_when(
        scb_dispincome < `33%` ~ 1,
        scb_dispincome < `66%` ~ 2,
        scb_dispincome >= `66%` ~ 3
      ),
      levels = 1:3,
      labels = c("1st tertile within year", "2nd tertile within year", "3rd tertile within year")
    )
  ) %>%
  select(-`33%`, -`66%`)

# ntprobnp

nt <- rsdata %>%
  reframe(ntmed = list(enframe(quantile(shf_ntprobnp,
    probs = c(0.33, 0.66),
    na.rm = TRUE
  ))), .by = shf_ef_cat) %>%
  unnest(cols = c(ntmed)) %>%
  pivot_wider(names_from = name, values_from = value)

rsdata <- left_join(
  rsdata,
  nt,
  by = c("shf_ef_cat")
) %>%
  mutate(
    shf_ntprobnp_cat = factor(
      case_when(
        shf_ntprobnp < `33%` ~ 1,
        shf_ntprobnp < `66%` ~ 2,
        shf_ntprobnp >= `66%` ~ 3
      ),
      levels = 1:3,
      labels = c("1st tertile within EF", "2nd tertile within EF", "3rd tertile within EF")
    )
  ) %>%
  select(-`33%`, -`66%`)

## Create numeric variables needed for comp risk model
rsdata <- create_crvar(rsdata, "sos_com_copd")
rsdata <- create_crvar(rsdata, "sos_com_copd2")
