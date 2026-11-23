
library(dplyr)

## Imagine we're just trying to estimate the mean height of a population

set.seed(1123)
x <- rnorm(20, mean=67, sd=5) ## height in inches of Mac students
m <- lm(x~1)
confint(m)
coef(m)

## That was one experiment; what do we expect from a real experiment?
## Let's do the same experiment 1000 times or so?

## A function to do a fake study
study <- function(n, mh, sdh){
	x <- rnorm(n, mean=mh, sd=sdh) ## height in inches of Mac students
	m <- lm(x~1)
	ci <- confint(m)
	est <- coef(m)
	return(tibble(low=ci[[1]], est=est[[1]], high=ci[[2]]))
}
## Some sample code to do study once

## Do the fake study many times
experiment <- function(n, mh, sdh, reps){
	return(
		replicate(reps, study(n, mh, sdh), simplify=TRUE)
	)
}

experiment <- function(n, m, sig, reps){
	return(replicate(reps, study(n, m, sig), simplify=FALSE) |> bind_rows())
}

experiment(n=20, mh=67, sdh=5, reps=1000)
