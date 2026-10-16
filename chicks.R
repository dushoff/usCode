
summary(chickwts)
boxplot(weight ~ feed
	, data = chickwts, main = "Comparing chicken feeds"
	, varwidth = TRUE, ylab = "Weight at six weeks (gm)"
)


