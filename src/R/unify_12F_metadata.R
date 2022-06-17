library(tidyverse)
library(data.table)
library(ggmap)
library(stringr)

not_all_na <- function(x) any(!is.na(x))

# Import relevant csvs for combination.
UKHSA_PHE_samples <- fread("~/msc_diss/ref/UKHSA PHE samples.csv")
  # UKHSA_GPS_samples <- fread("~/msc_diss/ref/UKHSA gps samples.csv")
  # I think these are the same
NickC_MSc_samples <- fread("~/msc_diss/ref/12F_for_NickC_MSc_with_Sample_info.csv")
GPS_12F_epidata <- read_csv("~/msc_diss/ref/12F_from_GPS_epidata.csv")

# !12F GPS!

  # Clean up the GPS 12F epidata, for some reason some IDs are called USA
GPS_12F_epidata <- GPS_12F_epidata %>% filter(In.Silico.Serotype != "TRUE", In.Silico.Serotype != "FALSE")

  # Select relevant variables
GPS_12F_epidata <- GPS_12F_epidata %>% select(c(Lane.Id, In.Silico.Serotype, Country, Region, Col.Month, Col.Year, Clinical.Manifest, Source, Strain, Vaccine.Month, Vaccine.Year, Vaccine.Period, Area, Syndrome, Origin, Location, LocationCount, CarriageSite))
names(GPS_12F_epidata) <- c("id", "serotype", "country", "region", "colMonth", "colYear", "clinical", "source", "strain", "vaccineMonth", "vaccineYear", "vaccinePeriod", "area", "syndrome", "origin", "location", "locationCount", "carriageSite")

# !HSA 12F samples!
  # Remove columns where all values are NA from NickC MSc Samples
names(NickC_MSc_samples) <- make.unique(names(NickC_MSc_samples))
NickC_MSc_samples <- NickC_MSc_samples %>% select(where(not_all_na))
  # Generate id column
HSA_epidata <- NickC_MSc_samples
HSA_epidata <- HSA_epidata %>% mutate(id = str_extract(fastq1_path, "(?<=\\/)\\d*_H\\d*(?=-\\*.streptococcus)"))
HSA_epidata <- HSA_epidata %>% select(id, everything())

  # Select relevant variables:
HSA_epidata <- HSA_epidata %>% select(c(id, Age, `Sample type`, Sterile, collection_date, YEAR, reception_date, run_date, mixed_with, final_serotype))
names(HSA_epidata) <- c("id", "age", "source", "sterile", "collectionDate", "YEAR", "receptionDate", "runDate", "mixedWith", "serotype")
HSA_epidata <- HSA_epidata %>% mutate(id1 = paste(id, "1", sep="-"), id2 = paste(id, "2", sep="-"))

# Get cluster membership and IDs from microreact output
clusters <- fread("~/msc_diss/result/vis_query_ref/vis_query_ref_microreact_clusters.csv")

# Merge GPS_12F_epidata to clusters
clusters <- merge(clusters, GPS_12F_epidata, by.x = "id", by.y = "id", all.x = TRUE)

# Merge UKHSA_PHE samples to clusters
UKHSA_PHE_samples <- UKHSA_PHE_samples %>% mutate(ID = as.character(ID))
clusters <- merge(clusters, UKHSA_PHE_samples, by.x = "id", by.y = "ID", all.x = TRUE)

HSA_epidata_id1 <- HSA_epidata %>% select(-c(id, id2))
HSA_epidata_id2 <- HSA_epidata %>% select(-c(id, id1))
# Merge NickC_MSc_samples
clusters <- merge(clusters, HSA_epidata_id1, by.x = "id", by.y = "id1", all.x = TRUE)
clusters <- merge(clusters, HSA_epidata_id2, by.x = "id", by.y = "id2", all.x = TRUE)


# Merge serotype dataset
clusters <- clusters %>% mutate(merged_sero = case_when(
  !is.na(serotype.x) ~ serotype.x,
  !is.na(Serotype__autocolor) ~ Serotype__autocolor,
  !is.na(serotype.y) ~ serotype.y,
  !is.na(serotype) ~ serotype,
  TRUE ~ NA_character_,
))

clusters <- clusters %>% select(-c(serotype.x, serotype.y, Serotype__autocolor, serotype))
clusters <- clusters %>% select(id, Cluster_Cluster__autocolour, merged_sero, everything())

# Merge location data
clusters <- clusters %>% mutate(merged_location = case_when(
  !is.na(country) & !is.na(region) ~ paste(region, country, sep = ", "),
  !is.na(country) & !is.na(location) ~ paste(location, country, sep = ", "),
  !is.na(Country) ~ Country,
  !is.na(sterile.x) | !is.na(sterile.y) ~ "United Kingdom",
  TRUE ~ NA_character_
  ))

clusters <- clusters %>% select(-c(country, region, location, Country, area))
clusters <- clusters %>% select(-c(Area__autocolor, Region__autocolor, Country__autocolor))
clusters <- clusters %>% select(id, Cluster_Cluster__autocolour, merged_sero, merged_location, everything())

clusters <- clusters %>% mutate(merged_location = ifelse(merged_location == "England and Wales", "United Kingdom", merged_location))

# Merge collection date
clusters <- clusters %>% mutate(merged_col_date = case_when(
  !is.na(colMonth) & !is.na(colYear) ~ as.IDate(paste("15", colMonth, colYear, sep="-"), format = "%d-%B-%Y"),
  !is.na(collectionDate.x) ~ collectionDate.x,
  !is.na(collectionDate.y) ~ collectionDate.y,
  !is.na(Year) ~ as.IDate(paste("01-01", Year, sep = "-"), format = "%d-%B-%Y"),
  !is.na(YEAR.x) ~ as.IDate(paste("01-01", YEAR.x, sep = "-"), format = "%d-%B-%Y"),
  !is.na(YEAR.y) ~ as.IDate(paste("01-01", YEAR.y, sep = "-"), format = "%d-%B-%Y"),
  TRUE ~ as.IDate(NA)
))

clusters <- clusters %>% select(-c(colMonth, colYear, collectionDate.x, collectionDate.y, Year, YEAR.x, YEAR.y))
clusters <- clusters %>% select(id, Cluster_Cluster__autocolour, merged_sero, merged_location, merged_col_date, everything())

# Merge clinical syndrome/diagnosis
# syndrome, clinical are the same, so merge into one syndrome variable

clusters <- clusters %>% mutate(syndrome = case_when(
  !is.na(clinical) ~ clinical,
  !is.na(syndrome) ~ syndrome,
  TRUE ~ NA_character_
))

clusters <- clusters %>% select(-c(clinical))
clusters <- clusters %>% select(-c(`Clinical manifest`))
clusters <- clusters %>% select(id, Cluster_Cluster__autocolour, merged_sero, merged_location, merged_col_date, syndrome, everything())

# Merge isolate_sample_source from source.x
clusters <- clusters %>% mutate(isolate_sample_source = case_when(
  !is.na(source.x) ~ source.x,
  !is.na(source.y) ~ source.y,
  TRUE ~ NA_character_
))

clusters <- clusters %>% select(-c(source.x, source.y))
clusters <- clusters %>% select(id, Cluster_Cluster__autocolour, merged_sero, merged_location, merged_col_date, syndrome, isolate_sample_source, everything())

# Merge vaccine dates
clusters <- clusters %>% mutate(vaccine_date = case_when(
  !is.na(vaccineMonth) & !is.na(vaccineYear) ~ as.IDate(paste("15", vaccineMonth, vaccineYear, sep="-"), format = "%d-%B-%Y"),
  TRUE ~ as.IDate(NA)
))

clusters <- clusters %>% select(-c(vaccineMonth, vaccineYear))
clusters <- clusters %>% select(id, Cluster_Cluster__autocolour, merged_sero, merged_location, merged_col_date, syndrome, isolate_sample_source,
                                vaccine_date, everything())

clusters <- clusters %>% select(-c(locationCount))

# Merge strains
clusters <- clusters %>% mutate(strain = case_when(
  !is.na(strain) ~ as.integer(strain),
  !is.na(Strain__autocolor) ~ Strain__autocolor,
  TRUE ~ NA_integer_
))

clusters <- clusters %>% select(-c(Strain__autocolor))

# Merge age
clusters <- clusters %>% mutate(age = case_when(
  !is.na(age.x) ~ age.x,
  !is.na(age.y) ~ age.y
))

clusters <- clusters %>% select(-c(age.x, age.y))
clusters <- clusters %>% select(id, Cluster_Cluster__autocolour, merged_sero, merged_location, merged_col_date, syndrome, isolate_sample_source, vaccine_date,
                                age, source, everything())

# Remove sterile, receptionDate, runDate, mixedWith

clusters <- clusters %>% select(-c(sterile.x, sterile.y, receptionDate.x, receptionDate.y, runDate.x, runDate.y, mixedWith.x, mixedWith.y))

# Fix date format to a Month + Year Column
clusters <- clusters %>% mutate(colMonth = month(merged_col_date),
                                colYear = year(merged_col_date))

#Add latitude and longitude
clusters_long_lat <- clusters %>% mutate(merged_location = ifelse(is.na(merged_location), "", merged_location))
clusters_long_lat <- mutate_geocode(clusters_long_lat, merged_location)

# Make NAs blank in Month/Year + Long/Lat columns
clusters_long_lat <- clusters_long_lat %>% mutate(
  colMonth = ifelse(!is.na(colMonth), as.character(colMonth), ""),
  colYear = ifelse(!is.na(colYear), as.character(colYear), ""),
  lon = ifelse(!is.na(lon), as.character(lon), ""),
  lat = ifelse(!is.na(lat), as.character(lat), ""),
)

write_csv(clusters, "~/msc_diss/result/complete_cluster_metadata.csv")
write_csv(clusters_long_lat, "~/msc_diss/result/complete_w-loc_cluster_metadata.csv")
