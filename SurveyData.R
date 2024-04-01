library(tidyverse)
library(haven)
library(arrow)

path <-
  "C:/Users/abarn/OneDrive/Documentos/Stack Data Strategy/Data Scientist Exercise/Data/"

# Load survey data
survey_data <- read_sav(paste0(path, "SurveyData2019.sav"))

# Drop unused columns
survey_data <-
  survey_data %>%
  select(Constit_Code, Constit_Name, region, b01, b02, Age, education, y09)

# Rename columns
survey_data <-
  survey_data %>%
  rename(
    const_c = Constit_Code, const_n = Constit_Name, turnout = b01,
    party = b02, age = Age, educ = education, female = y09
  )

# Change column classes from class haven_labelled
survey_data <-
  survey_data %>% mutate_at(vars(const_c, const_n, region), as.factor)

survey_data <-
  survey_data %>% mutate_at(vars(age, educ, party, turnout, female), as.numeric)

# Replace negative values with NAs in age
survey_data$age <- ifelse(survey_data$age < 1, NA, survey_data$age)

# Recode dummies to 0s and 1s
survey_data$turnout <-
  recode(survey_data$turnout, "1" = 1, "2" = 0, .default = NA_real_)

survey_data$female <-
  recode(survey_data$female, "1" = 0, "2" = 1, .default = NA_real_)

# Create age and education bracket columns to match post-stratification frame
survey_data$age_bracket <-
  as.factor(cut(survey_data$age,
    breaks = c(18, 23, 28, 33, 38, 43, 48, 53, 58, 63, Inf),
    labels = 1:10, include.lowest = T
  ))

survey_data <-
  survey_data %>%
  mutate(educ_level = case_when(
    between(educ, 1, 6) ~ 5,
    educ %in% c(7, 9) ~ 4,
    educ %in% c(10, 13) ~ 2,
    educ %in% c(12, 14) ~ 1,
    educ == 16 ~ 3,
    educ == 0 ~ 0,
    educ == c(-1, -2, -999) ~ 7,
    TRUE ~ 6
  )) %>%
  mutate(educ_level = as.factor(educ_level))

# Replace non-party labels with NAs in party
survey_data$party <-
  ifelse(survey_data$party < 1 | survey_data$party > 10, NA, survey_data$party)

# party outcomes
survey_data$conservative <- ifelse(survey_data$party == 2, 1, 0)
survey_data$labour <- ifelse(survey_data$party == 1, 1, 0)
survey_data$liberal_dem <- ifelse(survey_data$party == 3, 1, 0)
survey_data$other <- case_when(
  survey_data$conservative == 0 &
    survey_data$labour == 0 &
    survey_data$liberal_dem == 0 ~ 1,
  is.na(survey_data$party) ~ NA,
  TRUE ~ 0
)

# write parquet
# write_parquet(survey_data, paste0(path, "survey_data_clean.parquet"))
