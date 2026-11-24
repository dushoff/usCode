
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
## Redo the study once
study(n=20, mh=67, sdh=5)
## Why do we get a slightly different answer?

## Do the fake study many times
## NB: I wrote simplify=TRUE here is what went wrong in class -- you rarely want R to automatically simplify
experiment <- function(n, mh, sdh, reps){
	return(
		replicate(reps, study(n, mh, sdh), simplify=FALSE)
		|> bind_rows()
	)
}

ex <- experiment(n=20, mh=67, sdh=5, reps=1000)

## Now make a function to evaluate the study
evaluate <- function(ex){
	return(ex
		|> summarize(
			widthCI = mean(high-low)
			, meanEst = mean(est)
		)
	)
}
print(ex
	|> evaluate()
)

## If we do this study, we expect to get CI width of about 4.6 in, which seems pretty high. How big a random sample would we need to get within an inch? Can you experiment?

## What is the distributions of CIs we might expect? What would be a good way to visualize that?
