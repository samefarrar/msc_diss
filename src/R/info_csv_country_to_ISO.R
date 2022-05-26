library(tidyverse)
library(data.table)
library(countrycode)
library(ggmap)

# Import data on samples csv document
orig_csv <- read_csv("~/msc_diss/ref/12F_from_GPS_epidata.csv")

# Re-code country and region to ISO codes for microreact mapping.
locations <- orig_csv %>% select(Country, Region)
locations <- locations %>% filter(!is.na(Country))
locations_grouped <- locations %>% mutate(location = collateloc(Region, Country))

collateloc <- function(Region, Country) {
  return(case_when(
    is.na(Region) ~ Country,
    TRUE ~ paste(Region, Country, sep = ", ")
  ))
}

collateloc(locations$Region, locations$Country)

country_codes <- countrycode(orig_csv$Country, origin = 'country.name', destination = 'iso3c')
country_codes <- as.data.frame(country_codes)

region <- as.data.frame(locations_grouped$location)
names(region) <- c("location")
region_distinct <- region[!is.na(location)]
region_distinct <- unique(region)
region_distinct <- as.data.frame(region_distinct)

long_lat <- mutate_geocode(region_distinct, location)
write_csv2(long_lat, file = "location_long_lat.csv")

epidata_12F <- read.csv("~/msc_diss/ref/12F_from_GPS_epidata.csv")

epidata12F_COUNTRYdata <- epidata_12F %>% filter(!is.na(Country) & Country != "") %>% mutate(collated_loc = collateloc(Region, Country))

epidata12F_COUNTRYdata <- mutate_geocode(epidata12F_COUNTRYdata, collated_loc)
