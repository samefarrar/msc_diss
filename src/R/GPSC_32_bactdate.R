library(tidyverse)
library(data.table)
library(BactDating)

GPSC32 <- readRDS("~/msc_diss/result/gubbins_GPSC32.RDS")
GPSC32_dates <- readRDS("~/msc_diss/result/gubbins_GPSC32_dates.RDS")

res_gpsc32 <- bactdate(GPSC32, GPSC32_dates, nbIts = 1e5, showProgress = TRUE)
saveRDS(res_gpsc32, file = "~/msc_diss/result/bactdate_GPSC32.RDS")

pdf(file="~/msc_diss/result/GPSC_32_bactdate_trace.pdf")
plot(res_gpsc32, "trace")
dev.off()