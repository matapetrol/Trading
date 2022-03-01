library(tidyverse)
options(stringsAsFactors = F)
futsymbols=read.csv('C:/UA/Logs/Futures.Symbols.log',header = F)[,1]
futmeta=read.csv('https://apps.csidata.com/factsheets.php?type=commodity&format=csv')%>%
  rename_all(tolower)%>%
  select(symbol=symbolua,name,exchange,fullpointvalue,currency,contractsize,units,minimumtick)%>%
  filter(symbol %in% futsymbols)%>%
  mutate(multiplier=if_else(grepl('cents',units),0.01,1))


fxmeta=read.csv('https://apps.csidata.com/factsheets.php?type=commodity&format=csv&exchangeid=FOREX')%>%
  rename_all(tolower)
