load("C:/Users/Lina/STATISTIK/Projects/20210525_shfdb4/dm/data/rsdata_flow.RData")
flow <- flow[1:8, ]

flow <- rbind(c("General inclusion/exclusion criteria", ""), flow)

flow <- rbind(flow, c("Project specific inclusion/exclusion criteria", ""))

rsdata <- rsdata410 %>%
  filter(shf_indexdtm >= ymd("2005-11-01"))
flow <- rbind(flow, c("Remove posts with index date < 2005-11-01 (PDR from I July 2005)", nrow(rsdata)))

rsdata <- rsdata %>%
  filter(!is.na(shf_ef_cat))
flow <- rbind(flow, c("Remove posts with missing EF", nrow(rsdata)))

rsdata <- rsdata %>%
  group_by(lopnr) %>%
  arrange(shf_indexdtm) %>%
  slice(1) %>%
  ungroup()
flow <- rbind(flow, c("First post / patient", nrow(rsdata)))

colnames(flow) <- c("Criteria", "N")

rm(rsdata410)
gc()
