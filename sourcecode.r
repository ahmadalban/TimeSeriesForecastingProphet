#menginstall library
library(tidyverse)
library(data.table)
library(bbplot)


#praproses data
covid <- read.csv("~/Downloads/covid_19_clean_complete.csv")

covid$Date <- as.Date(covid$Date, format = "%m/%d/%y")


summary_all <- covid %>% group_by(Date) %>% summarize(Confirmed=sum(Confirmed), Deaths=sum(Deaths), Recovered=sum(Recovered))

summary <- summary_all %>% arrange(desc(Date))

head(summary, 1)

temp <- covid
temp_subset <- subset(covid, Country.Region == "China" | Country.Region == "Indonesia")
temp_subset2 <- subset(covid, Country.Region == "Indonesia")
temp_subset3 <- subset(covid, Country.Region == "China")

temp_clean <- temp_subset3 %>% group_by(Date,Country.Region) %>% summarize(Confirmed=sum(Confirmed), passive=sum(Recovered+Deaths))

temp_clean2 <- temp_subset2 %>% group_by(Date,Country.Region) %>% summarize(Confirmed=sum(Confirmed), passive=sum(Recovered+Deaths))


#menvisualisasi data confirm
temp_conf <- temp_subset %>% group_by(Date,Country.Region) %>% summarize(Confirmed=sum(Confirmed))

temp_conf

plot_conf <- ggplot(temp_conf, aes(x=Date, y=Confirmed, color=Country.Region)) +
  geom_line() +
  labs(x = "", 
       y = "Confirm Case", 
       title = "Confirmed Cases", 
       subtitle = "Around the World") +
  bbc_style()

plot_conf

#menvisualisasi data kematian
temp_death <- temp_subset %>% group_by(Date,Country.Region) %>% summarize(Deaths=sum(Deaths))

temp_death

plot_death <- ggplot(temp_death, aes(x=Date, y=Deaths, color=Country.Region)) +
  geom_line() +
  labs(x = "", 
       y = "Death Case", 
       title = "Death Cases", 
       subtitle = "Around the World") +
  bbc_style()
temp_death

plot_death

#menvisualisasi data sembuh
temp_rec <- temp_subset %>% group_by(Date,Country.Region) %>% summarize(Recovered=sum(Recovered))

temp_rec

plot_rec <- ggplot(temp_rec, aes(x=Date, y=Recovered, color=Country.Region)) +
  geom_line() +
  labs(x = "", 
       y = "Recovered Case", 
       title = "Recovered Cases", 
       subtitle = "Around the World") +
  bbc_style()

plot_rec

#Death ratio
temp_death_conf <- temp_subset %>% group_by(Date, Country.Region) %>% summarize(Deaths=sum(Deaths),Confirmed=sum(Confirmed))

temp_death_rate <- temp_death_conf %>% mutate(DEATHRATE = 100*(Deaths / Confirmed))

plot_death_rate <- ggplot(temp_death_rate, aes(x=Date, y=DEATHRATE, color=Country.Region)) +
  geom_line() +
  labs(x = "", 
       y = "Rate", 
       title = "COVID-19 Death Rate", 
       subtitle = "Around the World") +
  bbc_style()

plot_death_rate

#Recovery Ratio
temp_rec_conf <- temp_subset %>% group_by(Date, Country.Region) %>% summarize(Recovered=sum(Recovered),Confirmed=sum(Confirmed))

temp_rec_rate <- temp_rec_conf %>% mutate(RECRATE = 100*(Recovered / Confirmed))

plot_rec_rate <- ggplot(temp_rec_rate, aes(x=Date, y=RECRATE, color=Country.Region)) +
  geom_line() +
  labs(x = "", 
       y = "Rate", 
       title = "COVID-19 Recovery Rate", 
       subtitle = "Around the World") +
  bbc_style()

plot_rec_rate


#grafik Cina
temp_clean$Date
temp_clean$Confirmed
temp_clean$passive
hasilakhir <- temp_clean$Confirmed-temp_clean$passive
plot(temp_clean$Date, hasilakhir, ylab="Active case", xlab="Date", main="Grafik Kasus Aktif di Cina", type="l")


#grafik Indo
temp_clean2$Date
temp_clean2$Confirmed
temp_clean2$passive
hasilakhir2 <- temp_clean2$Confirmed-temp_clean2$passive
plot(temp_clean2$Date, hasilakhir2, ylab="Active case", xlab="Date", main="Grafik Kasus Aktif di Indonesia", type="l")

#install library prophet untuk machine learning
library(prophet)

#active case indo
temp_prophet <- temp_clean %>% group_by(Date) %>%  summarize(hasil=sum(Confirmed-passive))
temp_prophet <- temp_prophet %>% rename(ds = Date, y = hasil)

temp_prophet


m <- prophet(temp_prophet)
m2 <- prophet(temp_prophet)

future <- make_future_dataframe(m, periods = 120)
tail(future)

forecast <- predict(m2, future)

forecasted_conf <- forecast %>%
  arrange(desc(ds)) %>%
  slice(1) %>%
  pull(yhat) %>%
  round()

forecasted_conf

forecast_p <- plot(m, forecast) + 
  labs(x = "", 
       y = "confirmed case", 
       title = "Active Case", 
       subtitle = "To Next Month") + bbc_style()

forecast_p


#project confirm indo
temp_prophet <- temp_clean %>% group_by(Date) %>%  summarize(hasil=sum(Confirmed-passive))
temp_prophet <- temp_prophet %>% rename(ds = Date, y = hasil)

temp_prophet


m <- prophet(temp_prophet)
m2 <- prophet(temp_prophet)

future <- make_future_dataframe(m, periods = 90)
tail(future)

forecast <- predict(m2, future)

forecasted_conf <- forecast %>%
  arrange(desc(ds)) %>%
  slice(1) %>%
  pull(yhat) %>%
  round()

forecasted_conf

forecast_p <- plot(m, forecast) + 
  labs(x = "", 
       y = "confirmed case", 
       title = "Project Confirmed", 
       subtitle = "To Next Month") + bbc_style()

forecast_p


#active case China
temp_prophet <- temp_clean2 %>% group_by(Date) %>%  summarize(hasil=sum(Confirmed-passive))
temp_prophet <- temp_prophet %>% rename(ds = Date, y = hasil)

temp_prophet


m <- prophet(temp_prophet)
m2 <- prophet(temp_prophet)

future <- make_future_dataframe(m, periods = 120)
tail(future)

forecast <- predict(m2, future)

forecasted_conf <- forecast %>%
  arrange(desc(ds)) %>%
  slice(1) %>%
  pull(yhat) %>%
  round()

forecasted_conf

forecast_p <- plot(m, forecast) + 
  labs(x = "", 
       y = "confirmed case", 
       title = "Active Case", 
       subtitle = "To Next Month") + bbc_style()

forecast_p


#project confirm China
temp_prophet <- temp_clean2 %>% group_by(Date) %>%  summarize(hasil=sum(Confirmed-passive))
temp_prophet <- temp_prophet %>% rename(ds = Date, y = hasil)

temp_prophet


m <- prophet(temp_prophet)
m2 <- prophet(temp_prophet)

future <- make_future_dataframe(m, periods = 90)
tail(future)

forecast <- predict(m2, future)

forecasted_conf <- forecast %>%
  arrange(desc(ds)) %>%
  slice(1) %>%
  pull(yhat) %>%
  round()

forecasted_conf

forecast_p <- plot(m, forecast) + 
  labs(x = "", 
       y = "confirmed case", 
       title = "Project Confirmed", 
       subtitle = "To Next Month") + bbc_style()

forecast_p