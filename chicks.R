## R literally has built-in data sets!!
## Using a “base” (pre ggplot) plot, because it comes with the data set
summary(chickwts)
boxplot(weight ~ feed
	, data = chickwts, main = "Comparing chicken feeds"
	, varwidth = TRUE, ylab = "Weight at six weeks (gm)"
)


