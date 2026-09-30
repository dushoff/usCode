## Put all packages at the top:
#### People know what they need
#### will get an error quickly if they don't have everything
library(readr)
library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))

## Reads the file into a table, and puts it into the variable "dat"
dat <- read_csv("data/riparianData.Rout.csv")

## Why is this commented out?
summary(dat)
## summary(dat |> mutate_if(is.character, as.factor)) ## look at "factor view", maybe old-fashioned

## filter
## select
## We could also say conQuest <- (dat ... to store instead of examine
print(dat
	|> filter(conductivity > 500)
	|> select(transect_no, position, plant_species, conductivity)
)

## 53 positions measured > 10. What if want to know about NAs?
print(dat
	|> filter(position > 10)
	|> select(transect_no, position, plant_species, conductivity)
)

## A lot more than 53 _might be_ > 10
print(dat
	|> filter_out(position <= 10)
	|> select(transect_no, position, plant_species, conductivity)
)

## Check that it all seems to work
print(dat
	|> filter_out(position <= 10 | is.na(position))
	|> select(transect_no, position, plant_species, conductivity)
)

## mutate

## summarise

## summarise is careful with NAs, which is good because it produces tables you might work with
print(dat
	|> summarise(
		transect_no=mean(transect_no)
		, position=mean(position)
	)
)

meanBySpp <- (dat
	|> summarise(
		conductivity=mean(conductivity)
		, wet = mean(wet)
		, .by=plant_species
	)
) 

scatter <- (ggplot(dat)
	+ aes(conductivity, wet)
	+ geom_point()
)

print(scatter + aes(color=plant_species))
print(scatter + facet_wrap(~plant_species))

## Not necessary if you can find a global theme that you like
##print(scatter + facet_wrap(~plant_species) + theme_bw())

## print(scatter + geom_smooth())
## All log scales are basically the same (look at ratios instead of intervals)
## the 10 in log10 just refers to how labels are chosen
print(scatter + scale_x_log10())

print (ggplot(dat)
	+ aes(transect_no)
	+ geom_bar()
)

print (ggplot(dat)
	+ aes(position)
	+ geom_histogram()
)

conHist <- (ggplot(dat)
	+ aes(conductivity)
	+ geom_histogram()
)

print(conHist)
print(conHist + scale_x_log10())

print (ggplot(dat)
	+ aes(wet)
	+ geom_histogram()
)

print (ggplot(dat)
	+ aes(x=wet, y=plant_species)
	+ geom_boxplot()
)


print (ggplot(dat)
	+ aes(x=conductivity, y=plant_species)
	+ geom_boxplot()
)
