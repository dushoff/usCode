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

autopipeR = defined
R.Rout: R.R

######################################################################

## CRIB!!

%.R: 
	$(CP) ../usLectures/$*.R .

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

-include makestuff/git.mk
-include makestuff/visual.mk
