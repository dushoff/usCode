library(shellpipes)

library(dplyr)

set.seed(243)
groupSize <- 10
tLevels= c("cold", "warm")
tTemp = c(10, 20)
am = c(
	cold=8, warm=11
)
as = 1.1

af <- tibble(
	id = as.character(1:(groupSize*length(tLevels)))
	, treat = rep(tLevels, each=groupSize)
	, temp = rep(tTemp, each=groupSize)
	, activity = rnorm(am[treat], as)
)

csvSave(af)
