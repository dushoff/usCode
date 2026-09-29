library(readr)
library(dplyr)

penguins <- read_csv("data/penguinData.Rout.csv")

print(penguins
   |> summarize(
		bill_depth_mm = mean(bill_depth_mm, na.rm=TRUE)
		, bill_length_mm = mean(bill_length_mm, na.rm=TRUE)
		, .by = species
	)
)
