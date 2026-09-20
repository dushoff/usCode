## Behind-the-scenes for data prep
library(shellpipes)
library(janitor)

csvSave(
	csvRead() |> clean_names()
)
