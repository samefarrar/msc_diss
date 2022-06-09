library(tidyverse)
library(data.table)

not_all_na <- function(x) any(!is.na(x))

# Import relevant csvs for combination.

## Import list of ids and cluster membership csv
cluster_membership <- fread("result/all_geo_vis/all_geo_vis_microreact_clusters.csv")
cluster_membership <- cluster_membership %>% select(c(id, Cluster_Cluster__autocolour))

# Import GPS epidata with longitude and latitude
GPS_12F_long_lat <- fread("ref/12F_epidata_long_lat.csv")

# Import HSA epidata
HSA_epidata <- fread("ref/12F_for_NickC_MSc_with_Sample_info.csv")
names(HSA_epidata) <- make.unique(names(HSA_epidata))
HSA_epidata <- HSA_epidata %>% select(where(not_all_na))

# Test Merge
test1 <- merge(cluster_membership, GPS_12F_long_lat, by.x = "id", by.y = "Lane.Id", all.x = TRUE)
test2 <- merge(cluster_membership, HSA_epidata, by.x = "id", by.y = "ngsid", all.x = TRUE)

HSA_epidata <- HSA_epidata %>% mutate(combid = paste(ngsid, "_", molis_short, sep = ""))
