
## Round numeric columns so that the 25th percentile has 4 sig figs
sigRound <- function(x, sf=4){
	q <- abs(quantile(x, 0.25, names=FALSE))
	if (q==0) return(x)
	round(x, sf - 1 - floor(log10(q)))
}

af <- af |> mutate(across(where(is.double), sigRound))


