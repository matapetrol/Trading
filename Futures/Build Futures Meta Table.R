library(tidyverse)
options(stringsAsFactors = F)
futsymbols=read.csv('C:/UA/Logs/Futures.Symbols.log',header = F)[,1]
futmeta=read.csv('https://apps.csidata.com/factsheets.php?type=commodity&format=csv')%>%
  rename_all(tolower)%>%
  select(symbol=symbolua,exchangesymbol,name,exchange,fullpointvalue,currency,contractsize,units,minimumtick)%>%
  filter(symbol %in% futsymbols)%>%
  mutate(multiplier=if_else(grepl('cents',units),0.01,1))




fxmeta=read.csv('https://apps.csidata.com/factsheets.php?type=commodity&format=csv&exchangeid=FOREX')%>%
  rename_all(tolower)

csi=read.csv('https://apps.csidata.com/factsheets.php?type=commodity&format=csv')

names(csi)
library(tidyverse)
csi%>%
  filter(IsActive==1)%>%
  filter(!is.na(Currency) & Currency!='')%>%
  filter(Currency%in%c('USD','AUD','EUR','BRL','GBP','JPY','CHF','NZD','HKD','KRW','MYR'))%>%
  group_by(Exchange,Currency)%>%
  summarize(N=n())%>%
  filter(N>3)%>%
  pivot_wider(names_from = Currency,values_from = N,values_fill = 0)%>%
  writexl::write_xlsx('D:/CSI.xlsx')

View(
csi%>%
  filter(IsActive==1)%>%
  filter(Currency%in%c('USD','AUD','EUR','BRL','GBP','JPY','CHF','NZD','HKD','KRW','MYR','CNY'))%>%
  filter(Exchange %in% c('ASX','CBT','CFE','CLEAR',
                         'CME','COMEX','EEX','EUREX',
                         'EURONEXT-PARIS','HKEX','ICE-EU',
                         'ICE-EU-FIN','ICE-US','KRX','LME',
                         'NYMEX','NZX','OSE','SGX',
                         'DCE','ZCE','SHFE','CFFEX'))%>%
  filter(LastTotalVolume>50)%>%
  group_by(ExchangeSymbol)%>%
    filter(LastTotalVolume==max(LastTotalVolume))%>%
  ungroup()%>%
  rename_all(tolower)%>%
  select(symbol=symbolua,exchangesymbol,name,exchange,fullpointvalue,currency,contractsize,units,minimumtick,lasttotalvolume)
)
