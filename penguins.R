library(readr)
library(dplyr)
## library(performance)
library(DHARMa)
library(ggplot2); theme_set(theme_bw(base_size=15))

okabe <- palette.colors(palette = "Okabe-Ito")[-1]   # drop black

options(
	ggplot2.discrete.colour   = okabe
	, ggplot2.discrete.fill     = okabe
	, ggplot2.continuous.colour = "viridis"
	, ggplot2.continuous.fill   = "viridis"
)

penguins <- read_csv("data/penguinData.Rout.csv")
summary(penguins)

print(penguins
	|> summarize(
		bill_depth_mm = mean(bill_depth_mm, na.rm=TRUE)
		, bill_length_mm = mean(bill_length_mm, na.rm=TRUE)
		, .by = species
	)
)

allPlot <- (
	ggplot(penguins)
	+ aes(bill_depth_mm, bill_length_mm, color=species)
	+ geom_point()

)

print(allPlot)

allMod <- lm(bill_length_mm ~ bill_depth_mm, data=penguins)
summary(allMod)
plot(allMod)

spMod <- lm(bill_length_mm ~ bill_depth_mm + species, data=penguins)
summary(spMod)
plot(spMod)

quit()

overall <- lm(body_mass_g ~ 1, data=penguins)
plot(overall)
plot(simulateResiduals(overall))
## check_model(overall)

spMod <- lm(body_mass_g ~ 1 + species, data=penguins)
plot(spMod)
plot(simulateResiduals(spMod))
## check_model(spMod)
