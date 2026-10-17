library(shellpipes)

library(dplyr)

set.seed(241)
groupSize <- 10
tLevels= c("cold", "warm")
tTemp = c(10, 20)
am = c(
	cold=8, warm=11
)
as = 1.1

nr <- groupSize*length(tLevels)

af <- tibble(
	id = sprintf("x%0*d", nchar(nr), 1:nr)
	, treat = rep(tLevels, each=groupSize)
	, temp = rep(tTemp, each=groupSize)
	, activity = rnorm(n=nr, mean=am[treat], sd=as)
)

csvSave(af)
