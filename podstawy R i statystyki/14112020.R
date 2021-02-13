library(tidyverse)

load("data/wybory.rda")

# zad1

obw_gomunice <- dane_czyste %>%
  filter(dane_czyste$kod_teryt == 101204)

length(unique(obw_gomunice$powiat))

#zad2

obw_65_rowne_wieksze <- dane_czyste %>%
  filter(wojewodztwo=="świętokrzyskie" & frekwencja >= 65)

#zad3

obw_kujpom <- dane_czyste %>% 
  filter(wojewodztwo == "kujawsko-pomorskie" & frekwencja > 40 & (percent_glosow_waznych < 80 | andrzej_sebastian_duda > 70))
         
#mutate

dane_czyste <- dane_czyste %>% 
  mutate(procent_glosow=percent_glosow_niewaznych+percent_glosow_waznych)

czy_jest_100 <- dane_czyste %>% 
  filter(procent_glosow == 100)

dane_roznica <- dane_czyste %>% 
  mutate(andrzej_vs_chadkowski = abs(andrzej_sebastian_duda - rafal_kazimierz_trzaskowski)) %>% 
  filter(andrzej_vs_chadkowski != 100) %>% 
  select(typ_obwodu, siedziba, andrzej_sebastian_duda, rafal_kazimierz_trzaskowski, andrzej_vs_chadkowski) %>% 
  top_n(10, andrzej_vs_chadkowski) %>% 
  arrange(desc(andrzej_vs_chadkowski))

# summarise i summarize
dane_czyste %>% 
  summarise(srednia_ad=mean(andrzej_sebastian_duda, na.rm = T),
            srednia_rt=mean(rafal_kazimierz_trzaskowski, na.rm = T)
  )

dane_czyste %>% 
  summarise(srednia=mean(frekwencja),
            mediana=median(frekwencja),
            odchylenie_std=sd(frekwencja))

#grupowanie

frekwencja_woj <- dane_czyste %>% 
  group_by(wojewodztwo, powiat) %>% 
  summarise(mean(frekwencja))

frekwencja2 <- dane_czyste %>% 
  mutate(frekwencja_przedzialy = cut(x = frekwencja, breaks = c(0, 25, 50, 75, 100), include.lowest = T)) %>% 
  group_by(frekwencja_przedzialy) %>% 
  summarise(liczebnosc = n(),
            srednia=mean(percent_glosow_waznych))

#zliczanie

dane_czyste %>% 
  count(typ_obszaru)

#zadanie

licz_i_sr <- dane_czyste %>% 
  group_by(typ_gminy) %>% 
  summarise(srednia = mean(frekwencja), liczebnosc = n())

#zadanie
srednia_gmina_woj <- dane_czyste %>% 
  group_by(typ_gminy, wojewodztwo) %>% 
  summarise(srednia=mean(frekwencja))

srednia_gm_woj_wide <- srednia_gmina_woj %>% 
  pivot_wider(names_from = typ_gminy, values_from = srednia) %>% 
  janitor::clean_names(.)
