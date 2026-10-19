library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))

act <- read_csv("data/mouseActivityData.Rout.csv")
summary(act)
