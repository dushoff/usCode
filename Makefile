## This is usCode
## R scripts for McMaster Bio3SA

current: target
-include target.mk
Ignore = target.mk

vim_session:
	bash -ic "vmt README.md"

## -include makestuff/perl.def

######################################################################

Sources += $(wildcard *.md)

######################################################################

Sources += $(wildcard *.R)

## R lecture

autopipeR = defined
R.Rout: R.R
R.final.Rout: R.final.R

######################################################################

## Data manipulation
## Downloads/ is a mirror, for things I get from elsewhere
## data/ is logically a cache for things I want to share
## post data/ things on Avenue and let them download and put into the right place

Ignore += data/
mirrors += Downloads/

data/%.csv: %.csv | data
	$(copy)
data:
	$(mkdir)

######################################################################

## https://figshare.com/articles/dataset/Portal_Project_Teaching_Database/1314459
## data/rodentData.Rout.csv:
## rodentData.Rout: rodentData.R | data

rodents.Rout: rodents.R data/rodentData.Rout.csv

## complete_old from ratdat is a smaller set of rodent data
## Downloads/oldRodents.csv

######################################################################

## Riparian data from Dudley lab
## data/riparianData.Rout.csv: riparianData.Rout ;
Downloads/riparianData.csv:
riparianData.Rout: riparianData.R Downloads/riparianData.csv

riparian.Rout: riparian.R data/riparianData.Rout.csv

######################################################################

## Smoking example

## Downloads/fev.csv: 
## Originally from http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/FEV.csv

fevData.Rout: 

## HERE: Add banana data also, ask them about data??
######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/00.stamp
makestuff/%.stamp: | makestuff
	- $(RM) makestuff/*.stamp
	cd makestuff && $(MAKE) pull
	touch $@
makestuff:
	git clone --depth 1 $(msrepo)/makestuff

-include makestuff/os.mk

-include makestuff/pipeR.mk
-include makestuff/mirror.mk

-include makestuff/git.mk
-include makestuff/visual.mk
