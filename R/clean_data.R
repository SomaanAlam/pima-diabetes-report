# clean_data.R
# Load and clean the Pima Indians Diabetes dataset.
#
# Source: National Institute of Diabetes and Digestive and Kidney Diseases,
# via the UCI Machine Learning Repository / Kaggle. Women aged 21+ of Pima
# Indian heritage, Phoenix, Arizona.
#
# The raw file has no header row, so column names are supplied here.
# In five columns a value of 0 is physiologically impossible (e.g. a living
# person cannot have a blood pressure of 0). These zeros are missing-value
# codes, so they are converted to NA rather than treated as real measurements.

library(dplyr)

pima_columns <- c(
  "pregnancies",     # number of times pregnant
  "glucose",         # plasma glucose, 2h oral glucose tolerance test (mg/dL)
  "blood_pressure",  # diastolic blood pressure (mm Hg)
  "skin_thickness",  # triceps skin-fold thickness (mm)
  "insulin",         # 2-hour serum insulin (mu U/ml)
  "bmi",             # body mass index (kg/m^2)
  "pedigree",        # diabetes pedigree function (family-history score)
  "age",             # age in years
  "outcome"          # 1 = diabetes, 0 = no diabetes
)

# Columns where zero really means "not recorded"
zero_is_missing <- c("glucose", "blood_pressure", "skin_thickness",
                     "insulin", "bmi")

load_raw_pima <- function(path) {
  read.csv(path, header = FALSE, col.names = pima_columns)
}

clean_pima <- function(raw) {
  raw |>
    mutate(across(all_of(zero_is_missing), \(x) na_if(x, 0))) |>
    mutate(
      diabetes = factor(outcome, levels = c(0, 1),
                        labels = c("No diabetes", "Diabetes")),
      age_group = cut(age, breaks = c(20, 29, 39, 49, Inf),
                      labels = c("21-29", "30-39", "40-49", "50+")),
      bmi_group = cut(bmi, breaks = c(0, 24.9, 29.9, Inf),
                      labels = c("Healthy weight (<25)",
                                 "Overweight (25-29.9)",
                                 "Obese (30+)"))
    )
}
