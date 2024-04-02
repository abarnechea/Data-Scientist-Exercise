library(tidyverse)
library(haven)

path <-
  "C:/Users/abarn/OneDrive/Documentos/Stack Data Strategy/Data Scientist Exercise/Data/"

# Load census data including predictions
census_data <- read_csv(paste0(path, "census_data_predictions.csv"))

# Compute predicted number of voters in each cell
census_data$pred_count <- floor(census_data$count * census_data$turnout)

# Compute predicted vote share for other parties in each cell
census_data$spoil <-
  1 - (census_data$conservative + census_data$labour +
    census_data$liberal_dem + census_data$other)

# Replace negative probabilities with NAs in other
census_data$spoil <- ifelse(census_data$spoil < 0, 0, census_data$spoil)

# Reorder columns
census_data <-
  census_data %>% select(1:11, 13, 12)

# Compute predicted number of voters for each party in each cell
census_data <-
  census_data %>%
  mutate(
    conservative_vote = floor(conservative * pred_count),
    labour_vote = floor(labour * pred_count),
    ld_vote = floor(liberal_dem * pred_count),
    other_vote = floor(other * pred_count),
    spoil_vote = floor(spoil * pred_count)
  )

# write poststratification frame with estimates
# write_csv(census_data, paste0(path, "PoststratificationFrameWithEstimates.csv"))



