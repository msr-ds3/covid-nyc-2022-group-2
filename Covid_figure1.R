library(tidyverse)
library(tidycensus)
library(dplyr)
library(tigris)
options(tigris_use_cache = TRUE)
#zcta1 <- zctas(cb = TRUE, counties = c("Bronx","Kings","New York","Queens","Richmond"))
zcta <- read_csv("zcta.csv")
#counties <- county_subdivisions("New York", c("Bronx","Kings","New York","Queens","Richmond"), "NY")

Sys.setenv(CENSUS_KEY='1bbcb0a1bcda959d1e5bb3e6b0a04aff304c477f')
# Reload .Renviron
readRenviron("~/.Renviron")
# Check to see that the expected key is output in your R console
Sys.getenv("CENSUS_KEY")

#ny_insure <- get_acs(
#  geography = "zip code tabulation area", 
#  variables = "B27010_001",
#  #state = "NY", 
#  #county = c("Bronx","Kings","New York","Queens","Richmond"),
#  year = 2020,
#  geometry = TRUE
#)

#ny2 <- ny_insure

#ny_insure <- inner_join(ny_insure, zcta, by = "GEOID")

#plot(ny_insure["estimate"],color="")


####################

varNames <- load_variables(2016, "acs5", cache = TRUE) 
zcta <- zcta %>% transform(MODZCTA = as.factor(MODZCTA))%>% rename(GEOID=MODZCTA) %>% select(GEOID)

#####################

ny_insure <- get_acs(
  geography = "zip code tabulation area", 
  variables = c("B27010_033","B27010_050","B27010_018",'B27010_034'),
  #state = "NY", 
  #county = c("Bronx","Kings","New York","Queens","Richmond"),
  year = 2020,
  geometry = TRUE,
  output = "wide"
)
ny_insure <- inner_join(ny_insure, zcta, by = "GEOID")
ny_insure <- ny_insure %>% mutate(proportion=(B27010_033E+B27010_050E)/(B27010_018E+B27010_034E))

ggplot(ny_insure, aes(fill = proportion)) +
  ggtitle("Proportion of 18-64 year olds who are uninsured") +
  geom_sf(aes(geometry = geometry)) +
  scale_fill_distiller(palette = "YlOrRd", direction = 1) +
  theme(legend.position="bottom")

######################

median_income <- get_acs(
  geography = "zip code tabulation area", 
  variables = "B19013_001",
  #state = "NY", 
  #county = c("Bronx","Kings","New York","Queens","Richmond"),
  year = 2020,
  geometry = TRUE,
  output = "wide"
)
median_income <- inner_join(median_income, zcta, by = "GEOID")
median_income <- median_income %>% mutate(totalincome=(B19013_001E)/1000000)

ggplot(median_income, aes(fill = totalincome)) + 
  ggtitle("Median income (in millions, 2016$)") + 
  geom_sf(aes(geometry = geometry)) +
  scale_fill_distiller(palette = "YlGn", direction = 1) + 
  theme(legend.position="bottom")

############################

white <- get_acs(
  geography = "zip code tabulation area", 
  variables = c("B02001_002","B02001_001"),
  #state = "NY", 
  #county = c("Bronx","Kings","New York","Queens","Richmond"),
  year = 2020,
  geometry = TRUE,
  output = "wide"
)
white <- inner_join(white, zcta, by = "GEOID")
white <- white %>% mutate(proportion=(B02001_002E)/(B02001_001E))

ggplot(white, aes(fill = proportion)) +
  ggtitle("Proportion self-identifying as White") +
  geom_sf(aes(geometry = geometry)) +
  scale_fill_distiller(palette = "Purples", direction = 1) +
  theme(legend.position="bottom")

#############################

household <- get_acs(
  geography = "zip code tabulation area", 
  variables = c("B11016_005","B11016_006","B11016_007","B11016_008","B11016_013","B11016_014","B11016_015","B11016_016","B11016_001"),
  #state = "NY", 
  #county = c("Bronx","Kings","New York","Queens","Richmond"),
  year = 2020,
  geometry = TRUE,
  output = "wide"
)
household <- inner_join(household, zcta, by = "GEOID")
household <- household %>% mutate(proportion=
                                (B11016_005E+B11016_006E+B11016_007E+B11016_008E+
                                  B11016_013E+B11016_014E+B11016_015E+B11016_016E)
                                  /(B11016_001E))

ggplot(household, aes(fill = proportion)) +
  ggtitle("Proportion in households of 4 or more") +
  geom_sf(aes(geometry = geometry)) +
  scale_fill_distiller(palette = "OrRd", direction = 1) +
  theme(legend.position="bottom")
