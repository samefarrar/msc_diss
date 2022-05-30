#Import libraries

library(tidyverse)
library(data.table)
library(countrycode)
library(ggmap)

# Import data on samples csv document
orig_csv <- read_csv("~/msc_diss/ref/12F_from_GPS_epidata.csv")

#Function: takes region and country information and formats it to "region, country" for google maps API
collateloc <- function(Region, Country) {
  return(case_when(
    is.na(Region) ~ Country,
    TRUE ~ paste(Region, Country, sep = ", ")
  ))
}

# Get all locations in list, re-code locations to "region, country" for google maps.
locations <- orig_csv %>% select(Country, Region)
locations <- locations %>% filter(!is.na(Country))
locations_grouped <- locations %>% mutate(location = collateloc(Region, Country))

# Generates a dataframe of distinct locations
region <- as.data.frame(locations_grouped$location)
names(region) <- c("location")
region_distinct <- region[!is.na(location)]
region_distinct <- unique(region)
region_distinct <- as.data.frame(region_distinct)

# Export list of unique locations to csv
long_lat <- mutate_geocode(region_distinct, location)
write_csv2(long_lat, file = "location_long_lat.csv")

# Import CSV from GPS epidata
epidata_12F <- read.csv("~/msc_diss/ref/12F_from_GPS_epidata.csv")

# Mutate only the isolates with location data such that they have latitude and longitude information
epidata12F_COUNTRYdata <- epidata_12F %>% filter(!is.na(Country) & Country != "") %>% mutate(collated_loc = collateloc(Region, Country))
epidata12F_COUNTRYdata <- mutate_geocode(epidata12F_COUNTRYdata, collated_loc)

# Add NA columns to isolates with no location data so they can be merged
epidata12F_noCountrydata <- epidata_12F %>% filter(!(!is.na(Country) & Country != ""))
epidata12F_noCountrydata <- epidata12F_noCountrydata %>% mutate(collated_loc = NA,
                                                                lon = NA,
                                                                lat = NA)

# Merge the two dataframes and export as one with longitude and latitude information
epidata_12F <- rbind(epidata12F_COUNTRYdata, epidata12F_noCountrydata)
write_csv2(epidata_12F, file = "12F_epidata_long_lat.csv")

