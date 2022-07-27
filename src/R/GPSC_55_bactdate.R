library(tidyverse)
library(data.table)
library(BactDating)

GPSC55 <- readRDS("~/msc_diss/result/gubbins_GPSC55.RDS")
GPSC55_dates <- readRDS("~/msc_diss/result/gubbins_GPSC55_dates.RDS")

res_gpsc55 <- bactdate(GPSC55, GPSC55_dates, nbIts = 1e5, showProgress = TRUE)
saveRDS(res_gpsc55, file = "~/msc_diss/result/bactdate_GPSC55.RDS")

pdf(file="~/msc_diss/result/GPSC_55_bactdate_trace.pdf")
plot(res_gpsc55, "trace")
dev.off()