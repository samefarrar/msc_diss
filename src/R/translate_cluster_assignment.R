library(data.table)
library(tidyverse)

#Import both the visualise cluster assignment and the external cluster assignments.
vis_clusters <- fread("~/msc_diss/result/vis_query_ref/vis_query_ref_microreact_clusters.csv")
ext_clusters <- fread("~/msc_diss/result/all_assign/all_assign_external_clusters.csv")
full_clusters <- fread("~/msc_diss/result/complete_w-loc_cluster_metadata.csv")

#Merge the two databases 
clusters <- merge(vis_clusters, ext_clusters, by.x = "id", by.y = "sample")
metadata_clusters <- merge(full_clusters, ext_clusters, by.x = "id", by.y = "sample")

#Verify that there are no assignments from one to the other that are not reciprocal
  #I.E all GPSC 26s are 20, and all assigned 20 are 26s
metadata_clusters %>% filter(!is.na(merged_sero) | merged_location != "") %>% count(Cluster_Cluster__autocolour, GPSC)

metadata_clusters %>% filter(!is.na(strain)) %>% count(strain, GPSC, Cluster_Cluster__autocolour)

clusters %>% filter(GPSC %in% c(26, 32, 55, 56, 334, 289, 575) | Cluster_Cluster__autocolour %in% c(20, 36,70,52,430,273,908)) %>% 
  count(Cluster_Cluster__autocolour, GPSC)

#Drop internal cluster definition
clusters <- cluster %>% select(c(id, GPSC))

#Export csv file
#write.csv(clusters, file = "~/msc_diss/result/gpsc_cluster_assignment.csv")

#Alter complete metadata file to external clustering
POPPUNK_vis_clusters <- fread("~/msc_diss/result/complete_w-loc_cluster_metadata.csv")
POPPUNK_vis_clusters <- merge(POPPUNK_vis_clusters, clusters, by.y = "id", by.x = "id", all.y = TRUE)

#Select only external clustering
POPPUNK_vis_clusters <- POPPUNK_vis_clusters %>% select(id, GPSC, everything())
POPPUNK_vis_clusters <- POPPUNK_vis_clusters %>% select(-c(Cluster_Cluster__autocolour.x, Cluster_Cluster__autocolour.y))

#write.csv(POPPUNK_vis_clusters, "~/msc_diss/result/complete_w-loc_w-ext_cluster_metadata.csv")