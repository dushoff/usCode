library(shellpipes)
library(dplyr)

(csvRead()
	|> transmute(
		age, height, sex
      , lungCapacity=fev
		, currentSmoker=(smoke=="current smoker")
	)
) |> csvSave()
