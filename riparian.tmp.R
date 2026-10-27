## Put all packages at the top:
#### People know what they need
#### will get an error quickly if they don't have everything
library(readr)
library(dplyr)
## library(ggplot2); theme_set(theme_bw(base_size=15))
library(performance)

## Reads the file into a table, and puts it into the variable "dat"
dat <- read_csv("data/riparianData.Rout.csv")

linM <- (lm(
	conductivity ~ wet + plant_species
	, data=dat
))

logM <- (lm(
	log(conductivity) ~ wet + plant_species
	, data=dat
))

llM <- (lm(
	log(conductivity) ~ log(wet) + plant_species
	, data=dat
))

check_model(linM)
check_model(logM)
check_model(llM)
