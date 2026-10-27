library(readr)
library(dplyr)
## library(performance)
## library(DHARMa)
library(ggplot2); theme_set(theme_bw(base_size=15))

penguins <- read_csv("data/penguinData.Rout.csv")
summary(penguins)

print(penguins
   |> summarize(
		bill_depth_mm = mean(bill_depth_mm, na.rm=TRUE)
		, bill_length_mm = mean(bill_length_mm, na.rm=TRUE)
		, .by = species
	)
)

ggplot(penguins
)

quit()

overall <- lm(body_mass_g ~ 1, data=penguins)
plot(overall)
plot(simulateResiduals(overall))
## check_model(overall)

spMod <- lm(body_mass_g ~ 1 + species, data=penguins)
plot(spMod)
plot(simulateResiduals(spMod))
## check_model(spMod)
