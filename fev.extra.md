
## Scientific question

How does smoking affect lung capacity in this population of children? NOTE: This is an observational study, so we're not going to make strong causal conclusions.

## Main statistical question

In a linear model, what is the estimated effect of smoking status on lung capacity?

## Statistical approach

We want to measure change as a proportion of lung capacity. We could do this either by dividing the estimated effect by mean lung capacity, or by doing our study on the natural log scale. Values on this scale can be translated directly into ratios.

For this study, we will focus on proportions because it seems biologically reasonable. We can change this, though, if the model doesn't seem to fit well, and a model on another scale fits better (meaning in terms of diagnostic plots and statistics, _not_ results).

We want to control for age, height and sex, all of which seem like possible confounders, in the sense that they could influence both smoking status and exhalation. Even if some don't affect smoking status, it could still be useful to control for them to reduce variation.

## Explorations

How do we want to put age, height and sex into our linear model? We have plenty of parameters to spend, but we don't want to overfit.

We can do some explorations _without_ looking at the main predictor variable (smoking).

First, we looked at response to height alone, using polynomials of different degree.

We accidentally did this first without taking the log of lungCapacity
* The straight-line model had a clear curved pattern of residuals.
* The second-order model (poly with 2df) looked better.

We then took the log
* The straight-line model looked good on diagnostics and predictions, so we're going to keep it.
* We also looked at the quadratic model and didn't see any big differences.

Response to age
* Straight line model does not seem to fit well
* Quadratic is better but a bit wiggly
* Cubic also seems ok, after that we seem to be over-fitting
	* People often use splines instead of polynomials 
	* Can fit curves in detail with less wiggliness

Looking at this made us think maybe we can control better if we drop youngest children. We used quantile, and we decided to drop children <11 years old.

We decided to keep a linear poly for height, and a 2-degree (quadratic) poly for age. We definitely want to include sex, and let's try interactions between sex and both of our other predictors. For a simple project, let's skip the interactions between the quantitative predictors.

Check the full covariate model against diagnostics.
* Looks fine

## Final model

We chose `log(lungCapacity) ~ 1 + poly(age, 2)*sex + height*sex`

Check against diagnostics
* Looks fine

## Results

Estimate is -0.041 (about 4% less lung capacity for smokers) CI (-0.086, 0.004) (not a clear effect).
