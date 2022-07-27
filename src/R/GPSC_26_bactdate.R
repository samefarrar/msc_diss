library(tidyverse)
library(data.table)
library(BactDating)

GPSC26 <- readRDS("~/msc_diss/result/gubbins_GPSC26.RDS")
GPSC26_dates <- readRDS("~/msc_diss/result/gubbins_GPSC26_dates.RDS")

res_gpsc26 <- bactdate(GPSC26, GPSC26_dates, nbIts = 1e5, showProgress = TRUE)

saveRDS(res_gpsc26, file = "~/msc_diss/result/bactdate_GPSC26.RDS")

pdf(file="~/msc_diss/result/GPSC_26_bactdate_trace.pdf")
plot(res_gpsc26, "trace")
dev.off()