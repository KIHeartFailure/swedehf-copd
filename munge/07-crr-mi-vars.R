# Creating variables for competing risk analysis in imputed dataset ------------

# keep org imp
imp.org <- imprsdata

# Convert to Long
long <- mice::complete(imprsdata, action = "long", include = TRUE)

## Create numeric variables needed for comp risk model
# sos_com_copd, sos_com_copd2 created in fix-vars (no missing data)

for (i in seq_along(modvars)) {
  long <- create_crvar(long, modvars[i])
}

# Convert back to Mids
imput.short <- as.mids(long)
imprsdata <- imput.short
