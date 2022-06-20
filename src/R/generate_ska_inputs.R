library(tidyverse)
library(data.table)

#Import relevant dataset
clusters <- fread("~/msc_diss/result/complete_w-loc_w-ext_cluster_metadata.csv") %>% select(-c(V1))

#Select relevant 12F strains:
SKA_input_strains <- clusters %>% 
  select(c(id, GPSC)) %>%
  filter(GPSC %in% c(26,55,334)) %>%
  group_by(GPSC) %>% ungroup()

#Generate path to contig.fasta file for each id
SKA_input_strains <- SKA_input_strains %>% mutate(path = paste(
  "/rds/general/user/sef17/home/msc_diss/data/gen/assemblies/",
  id,
  "_spades/contigs.fasta", sep = ""))

SKA_input_strains <- SKA_input_strains %>% filter(file.exists(path))

#Seperate by ID
GPSC_26 <- SKA_input_strains %>% filter(GPSC == 26) %>% select(id, path)
GPSC_55 <- SKA_input_strains %>% filter(GPSC == 55) %>% select(id, path)
GPSC_334 <- SKA_input_strains %>% filter(GPSC == 334) %>% select(id, path)

#Save as .txt file for 
write.table(GPSC_26, file = "~/msc_diss/result/cluster_lists/GPSC_26.list", sep = "\t",quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(GPSC_55, file = "~/msc_diss/result/cluster_lists/GPSC_55.list", sep = "\t",quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(GPSC_334, file = "~/msc_diss/result/cluster_lists/GPSC_334.list", sep = "\t",quote = FALSE, row.names = FALSE, col.names = FALSE)
