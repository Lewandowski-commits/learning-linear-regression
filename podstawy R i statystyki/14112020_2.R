library(tidyverse)
load("data/gus.rdata")

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017)

przyrost_16_17r <- right_join(x = przyrost2016, y = przyrost2017, by = c())

przyrost_15_17 <- inner_join(x = przyrost2015, y = przyrost2017)

przyrost_15_16_17 <- full_join(x = przyrost2015, y = full_join(x = przyrost2016, y = przyrost2017))
                               
przyrost_15_16_17 <- full_join(x = przyrost2015, y = przyrost2016) %>% 
  full_join(x = ., y = przyrost2017)

#zadanie

bezrobocie$id_powiat <- strtoi(bezrobocie$id_powiat)
pod_10tys$pow <- strtoi(pod_10tys$pow)

dane_gus <- full_join(x = wyn, y = pod_10tys) %>% 
  full_join(x = ., y = bezrobocie, by=c("pow" = "id_powiat"))

#reprezentacja danych
dane_gus %>%
  summarise(srednia_bezr=mean(stopa_bezr),
            sreadnia_pod=mean(pod_10tys),
            srednia_wyn=mean(wynagrodzenie))
          
dane_gus_long <- dane_gus %>% 
  pivot_longer(stopa_bezr:wynagrodzenie)

dane_gus_long <- dane_gus %>% 
  pivot_longer(-pow)

dane_gus_long %>% 
  group_by(name) %>% 
  summarise(srednia=mean(value))

dane_gus_wide <- dane_gus_long %>% 
  pivot_wider()

#