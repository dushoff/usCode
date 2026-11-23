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

set.seed(1123)
evaluate <- function(ex){
	return(ex
		|> summarize(
			width = mean(high-low)
			, meanEst = mean(est)
			, pos = mean(est>0)
			, neg = mean(est<=0)
			, clearPos = mean(low>0)
			, clearNeg = mean(high<0)
			, clearEst = mean(est[low>0])
		)
	)
}

ex0 <- experiment(n=20, m=1, sig=5, reps=1000)
print(ex0
	|> filter(high<0)
)
evaluate(ex0)


