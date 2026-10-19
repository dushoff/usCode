## fev stands for forced exhalation volume, it's a measure of lung function
library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))

children <- read_csv("data/fevData.Rout.csv")

summary(children)

