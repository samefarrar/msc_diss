library(data.table)
library(tidyverse)

#Import both the visualise cluster assignment and the external cluster assignments.
vis_clusters <- fread("~/msc_diss/result/vis_query_ref/vis_query_ref_microreact_clusters.csv")
ext_clusters <- fread("~/msc_diss/result/all_assign/all_assign_external_clusters.csv")

#Merge the two databases 
clusters <- merge(vis_clusters, ext_clusters, by.x = "id", by.y = "sample")

#Verify that there are no assignments from one to the other that are not reciprocal
  #I.E all GPSC 26s are 20, and all assigned 20 are 26s
clusters %>% filter(GPSC %in% c(26,55,334) | Cluster_Cluster__autocolour %in% c(20, 70, 273, 402)) %>% 
  count(Cluster_Cluster__autocolour, GPSC)

#Drop internal cluster definition
clusters <- cluster %>% select(c(id, GPSC))

#Export csv file
write.csv(clusters, file = "~/msc_diss/result/gpsc_cluster_assignment.csv")