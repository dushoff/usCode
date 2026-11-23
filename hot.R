library(dplyr)

sim <- function(n, m, sig){
	x <- rnorm(n, mean=m, sd=sig)
	fit <- lm(x~1)
	ci <- confint(fit)
	return(tibble(low=ci[[1]], est=coef(fit)[[1]], high=ci[[2]]))
}

experiment <- function(n, m, sig, reps){
	return(replicate(reps, sim(n, m, sig), simplify=FALSE) |> bind_rows())
}

evaluate <- function(ex){
	return(ex
		|> summarize(
			widthCI = mean(high-low)
			, meanEst = mean(est)
			, 
		)
	)
}

## powerStudy function should take different sample sizes, and make a graph

set.seed(1123)
ex0 <- experiment(n=200, m=67, sig=5, reps=1000)
print(ex0 |> evaluate())

