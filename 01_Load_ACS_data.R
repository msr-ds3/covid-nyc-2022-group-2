# Load ACS data

library(tidycensus)
library(tidyverse)
library(dplyr)
library(tigris)
library(modelr)
library(sf)

options(tigris_use_cache = TRUE)
Sys.setenv(CENSUS_KEY='1bbcb0a1bcda959d1e5bb3e6b0a04aff304c477f')
readRenviron("~/.Renviron")
Sys.getenv("CENSUS_KEY")

varNames <- load_variables(2016, "acs5", cache = TRUE) 

ny_insure <- get_acs(
  geography = "zcta", 
  variables = c('B27010_033','B27010_050','B27010_018','B27010_034'),
  year = 2016,
  geometry = TRUE,
  output = "wide"
)

median_income <- get_acs(
  geography = "zip code tabulation area", 
  variables = "B19013_001",
  year = 2016,
  geometry = TRUE,
  output = "wide"
)

white <- get_acs(
  geography = "zip code tabulation area", 
  variables = c("B02001_002","B02001_001"),
  year = 2016,
  geometry = TRUE,
  output = "wide"
)

household <- get_acs(
  geography = "zip code tabulation area", 
  variables = c("B11016_005","B11016_006","B11016_007","B11016_008","B11016_013","B11016_014","B11016_015","B11016_016","B11016_001"),
  year = 2016,
  geometry = TRUE,
  output = "wide"
)

bus <- get_acs(
  geography = "zip code tabulation area", 
  variables = c("B08301_011","B08301_001"),
  year = 2016,
  geometry = TRUE,
  output = "wide"
)

elder <- get_acs(
  geography = "zip code tabulation area", 
  variables = c("B01001_001","B01001_020","B01001_021","B01001_022","B01001_023","B01001_024","B01001_025",
                "B01001_044","B01001_045","B01001_046","B01001_047","B01001_048","B01001_049"),
  year = 2016,
  geometry = TRUE,
  output = "wide"
)

save(ny_insure, median_income, household, bus, white, elder, file="acs_data.Rdata")

