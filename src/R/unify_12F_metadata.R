library(tidyverse)
library(data.table)

not_all_na <- function(x) any(!is.na(x))

# Import relevant csvs for combination.
UKHSA_PHE_samples <- fread("~/msc_diss/ref/UKHSA PHE samples.csv")
  # UKHSA_GPS_samples <- fread("~/msc_diss/ref/UKHSA gps samples.csv")
  # I think these are the same
NickC_MSc_samples <- fread("~/msc_diss/ref/12F_for_NickC_MSc_with_Sample_info.csv")
GPS_12F_epidata <- read_csv("~/msc_diss/ref/12F_from_GPS_epidata.csv")

# Clean up the GPS 12F epidata, for some reason some IDs are called USA
GPS_12F_epidata <- GPS_12F_epidata %>% filter(In.Silico.Serotype != "TRUE", In.Silico.Serotype != "FALSE")

# Remove columns where all values are NA from NickC MSc Samples
names(NickC_MSc_samples) <- make.unique(names(NickC_MSc_samples))
NickC_MSc_samples <- NickC_MSc_samples %>% select(where(not_all_na))

# Take example metadata from GPSC26 and use that to structure other csvs
example_dataset <- fread("~/msc_diss/ref/example_metadata.csv")

# Get cluster membership and IDs from microreact output

# Import HSA epidata
HSA_epidata <- fread("ref/12F_for_NickC_MSc_with_Sample_info.csv")
names(HSA_epidata) <- make.unique(names(HSA_epidata))
HSA_epidata <- HSA_epidata %>% select(where(not_all_na))

# Test Merge
test1 <- merge(cluster_membership, GPS_12F_long_lat, by.x = "id", by.y = "Lane.Id", all.x = TRUE)

HSA_epidata <- HSA_epidata %>% mutate(combid = paste(ngsid, "_", molis_short, sep = ""))
