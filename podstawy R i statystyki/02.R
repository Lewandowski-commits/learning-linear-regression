library(tidyverse)



load(file = "data/wybory.rda")

iris

frekwencja80 <- dane_czyste %>% 
  filter(frekwencja >= 80)

dane_czyste %>% 
  filter(frekwencja >= 80) %>% 
  count()

count(frekwencja80)

frekwencja80 

obw_poznan <- dane_czyste %>% 
  filter(gmina == "m. Poznań" & frekwencja > 60)

obw_poznan <- dane_czyste %>% 
  filter(gmina == "m. Poznań" | frekwencja > 60)

obw_poznan2 <- dane_czyste %>% 
  filter(powiat %in% c("Poznań", "Warszawa", "Kraków", "Wrocaw"))

obw_poznan3 <- dane_czyste %>% 
  filter(!powiat %in% c("Poznań", "Warszawa", "Kraków", "Wrocaw"))

is.na(NA)

dane_bez_braków <- dane_czyste %>% 
  filter(!is.na(percent_glosow_waznych))

dane_cc <- complete.cases(dane_czyste)

#wybor kolumn

dane_kolumny <- dane_czyste %>% 
  select(-w_tym_z_powodu_postawienia_znaku_x_obok_nazwiska_dwoch_lub_wiekszej_liczby_kandydatow, 
         -w_tym_z_powodu_niepostawienia_znaku_x_obok_nazwiska_zadnego_kandydata, 
         -w_tym_z_powodu_postawienia_znaku_x_wylacznie_obok_skreslonego_nazwiska_kandydata)

dane_kolumny <- dane_czyste %>% 
  select(symbol_kontrolny:percent_glosow_niewaznych, percent_glosow_waznych:rafal_kazimierz_trzaskowski)
