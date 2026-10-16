library(shellpipes)
library(performance)
library(effects)

dat <- rdsRead()

summary(dat)

oneSamp <- lm(Beak.Width ~ 1, data=dat)
check_model(oneSamp, show_ci=TRUE)

groups <- lm(Beak.Width ~ shortname, data=dat)
check_model(groups, show_ci=TRUE)

plot(allEffects(groups))

## csvSave(dat)
