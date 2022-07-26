library(tidyverse)
library(data.table)
library(BactDating)
library(lubridate)

setwd("~/msc_diss/result/ska_alignment/GPSC_26/")
GPSC_26 <- loadGubbins("gubbins_26")
setwd("~/msc_diss/result/ska_alignment/GPSC_32/")
GPSC_32 <- loadGubbins("gubbins_32")
setwd("~/msc_diss/result/ska_alignment/GPSC_55")
GPSC_55 <- loadGubbins("gubbins_55")

setwd("~/msc_diss/result/")

clusters_metadata <- fread(file = "~/msc_diss/result/complete_w-loc_w-ext_cluster_metadata.csv")
cluster_dates <- clusters_metadata %>% select(id, merged_col_date)

GPSC_26_dates <- tibble(GPSC_26$tip.label)
GPSC_26_dates <- merge(GPSC_26_dates, cluster_dates, by.x = "GPSC_26$tip.label", by.y = "id")
GPSC_26_dates <- GPSC_26_dates %>% mutate(merged_col_date = decimal_date(merged_col_date))

GPSC_32_dates <- tibble(GPSC_32$tip.label)
GPSC_32_dates <- merge(GPSC_32_dates, cluster_dates, by.x = "GPSC_32$tip.label", by.y = "id")
GPSC_32_dates <- GPSC_32_dates %>% mutate(merged_col_date = decimal_date(merged_col_date))

GPSC_55_dates <- tibble(GPSC_55$tip.label)
GPSC_55_dates <- merge(GPSC_55_dates, cluster_dates, by.x = "GPSC_55$tip.label", by.y = "id")
GPSC_55_dates <- GPSC_55_dates %>% mutate(merged_col_date = decimal_date(merged_col_date))

res = bactdate(GPSC_26, GPSC_26_dates$merged_col_date)
plot(res, 'trace')


