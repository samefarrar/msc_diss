# R Script to Make Data Ready for Import into Microreact

library(tidyverse)
library(data.table)

clusters <- fread(file = "~/msc_diss/result/complete_w-loc_w-ext_cluster_metadata.csv")

clusters2 <- clusters %>% 
  filter(str_detect(GPSC,"^\\s*[0-9]*\\s*$"))

clusters2 <- clusters2 %>% mutate(GPSC = as.character(GPSC))

cluster2 <- clusters2 %>% select(-c(V1))

write.csv(cluster2, "~/msc_diss/result/metadata_final.csv")

