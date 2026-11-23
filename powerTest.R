
## Imagine we're just trying to find the mean of something
x <- rnorm(20, mean=1, sd=1)
m <- lm(x~1)
confint(m)
coef(m)
