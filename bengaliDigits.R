library(readxl)
library(janitor)
library(dplyr)
library(tidyr)
library(broom)
library(performance)

dat <- (
	read_excel("data/bengaliDigits.xlsx")
	|> clean_names()
)

lengths <- (dat
	|> select(sex, r2d_mm, r4d_mm, l2d_mm, l4d_mm)
	|> mutate(rdiff=r4d_mm-r2d_mm)
	|> mutate(twoDiff=r2d_mm-l2d_mm)
)

summary(lengths)

fingerModel <- lm(rdiff~1, data=lengths)
tidy(fingerModel)
## check_model(fingerModel)

## Rename and try the twoDiff model
handModel <- lm(rdiff~1, data=lengths)
tidy(handModel)
## check_model(handModel)

longRight <- (lengths
	|> mutate(id=as.character(1:nrow(lengths)))
	|> select(id, sex, r2d_mm, r4d_mm)
	|> pivot_longer(-c(id, sex), names_to="finger", values_to="length")
)

summary(longRight)

wrongFingerModel <- lm(length~finger, data=longRight)
summary(wrongFingerModel)
