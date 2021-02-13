library(tidyverse)
library(readxl)

pracownicy <- read_xlsx("data/pracownicy.xlsx")

summary(pracownicy)

library(summarytools)

view(dfSummary(pracownicy))

freq(pracownicy$plec)
view(descr(pracownicy$bwynagrodzenie))
