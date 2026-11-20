
I am interested in the effects of smoking on lung capacity in children.

Statistically, I am going to look at a linear model and a single parameter associated with the currentSmoker variable.

I'm interested in proportional change: by what percent do smokers have a lower or higher lung capacity compared to non-smokers (with CIs).

We can do this either by fitting a model on the log scale, or by fitting a model on the linear scale, and comparing the estimated effect (in L) to the mean lung capacity (also in L). 

I feel like thinking about proportions on a log scale is very natural, and it fits my intuition for this particular problem. So I'm planning to try the log scale, and only if I run into warning signs will I consider the linear scale. I will make a final decision before I look at any estimates of my main parameter.

We think that age, sex and height are all confounders, so we're going to control for all of them. We are thinking maybe of a curved response to each of them, and maybe interactions with sex. Maybe not try interactions between the continuous variables for this small project.
