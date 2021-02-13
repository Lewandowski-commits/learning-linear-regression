library("tidyverse")
library("readxl")

dane <- read_xlsx(path = "data/wybory2020.xlsx")

summary(dane)

mean(dane$Frekwencja)
mean(dane$`% głosów nieważnych`, na.rm = T)

dane_czyste <- janitor::clean_names(dane)

mean(dane_czyste$percent_glosow_niewaznych, na.rm = T)

save(dane_czyste, file = "data/wybory.rda")

