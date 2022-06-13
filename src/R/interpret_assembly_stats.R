# Interpret assembly statistics, get number of FASTA files with various qualities.

# Import relevant libraries:
library(tidyverse)
library(data.table)
library(stringr)
library(ggplot2)

# Import the assembly_stats txt file into an R data frame
orig_assembly_stats <- fread("~/msc_diss/result/assembly_stats.txt")

# Use regex to rename the file name and path to the id
assembly_stats <- orig_assembly_stats %>% mutate(id = str_extract(dirname(filename), "(?<=/assemblies/)(.*)(?=_spades)"))
assembly_stats <- assembly_stats %>% select(c(id, total_length, number, mean_length, longest, shortest, N_count, Gaps, N50, N50n, N70, N70n, N90, N90n))

# Save as RDS (commented out so I'm not saving it over and over)
#saveRDS(assembly_stats, "~/msc_diss/result/assembly_stats.RDS")
#assembly_stats <- readRDS("~/msc_diss/result/assembly_stats.RDS")

# Return the list of ids that don't meet criteria of N count < 10,000 and total lengths between 1.9Mb and 2.5Mb.
removed_genomes <- assembly_stats %>% filter(N_count > 10000 | (total_length < 1900000 | total_length > 2500000))

# Generate histogram of N_counts and lengths
count_hist <- ggplot(assembly_stats, aes(x = N_count)) + geom_histogram(color = "black", fill = "white")
length_hist <- ggplot(assembly_stats, aes(x = total_length)) + geom_histogram(color = "red", fill = "white")

# Add mean line to histogram
count_hist + geom_vline(aes(xintercept=mean(N_count)), color = "blue", linetype = "dashed", size = 1)
length_hist + geom_vline(aes(xintercept=mean(total_length)), color = "blue", linetype = "dashed", size = 1)

removed_genomes
