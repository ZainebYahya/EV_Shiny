#Data Preprocessing
# Load libraries
library(shinyHeatmaply)
library(plotly)
library(MASS)
library(heatmaply)
library(tidyverse)
library(Hmisc)
library(funModeling)
library(plyr)
library(readr)
library(GGally)
library(mlbench)
library(ggcorrplot)
library(plotly)
library(reactable)
library(sparkline)
library(ggplot2)
library(dplyr)
library(ggExtra)



df <- read.csv(file = "EV.csv")


# Exploratory data analysis
#
#View(df)
# describe(df)
# profiling_num(df)
# freq(df)
# plot_num(df)
#glimpse(df)





#Cleaning up the data


df <- df %>%
  select(
    -GPS_AVG_VELOCITY,
    -START_ALTITUDE,
    -END_ALTITUDE,
    -DISTANCE_GPS,
    -TEMPERATURE,
    -HEADLAMP_ON_PCT,
    -TRIP_ID,
    -VEHICLE_ID,
    -START_BAT_EST,
    -END_ODO_EST,
    -END_BAT_EST,
    -UNACCOUNTED_KM,
    -CALENDAR_KEY,
    -AC_ON_PCT
  )


df <- df %>% drop_na()
names(df) <- tolower(names(df))
#######################################

df <- df %>%
  mutate(., battery_charg = (df$end_bat_actual - df$start_bat_actual))

first_range <- df %>%
  filter(fullcharge_efficiency >= 0 & fullcharge_efficiency <= 10000)

efficiency <- df %>%
  filter(fullcharge_efficiency >= 0 & fullcharge_efficiency <= 10000)

#####################################################



#compare efficiency with battery_charg

p <- efficiency %>%
  ggplot(aes(x = fullcharge_efficiency, y = battery_charg)) +
  geom_point(color = "#69b3a2",
             size = 2,
             alpha = 0.01) +
  theme(legend.position = "none")
ggExtra::ggMarginal(p, type = "histogram")

#compare efficiency with charging_occurrences
p <- efficiency %>%
  ggplot(aes(x = fullcharge_efficiency, y = charging_occurrences)) +
  geom_point(color = "#69b3a2",
             size = 2,
             alpha = 0.01) +
  theme(legend.position = "none")
ggExtra::ggMarginal(p, type = "histogram")



#compare efficiency with fullcharge_amount
p <- efficiency %>%
  ggplot(aes(x = fullcharge_efficiency, y = fullcharge_amount)) +
  geom_point(color = "#69b3a2",
             size = 2,
             alpha = 0.01) +
  theme(legend.position = "none")
ggExtra::ggMarginal(p, type = "histogram")

glimpse(df)
###############################################
df_map <- df %>% 
  select(-accessories, -end_date, -start_date,-recenddate,-recstartdate,
         -charge_end, -connect_end,-charge_start,-connect_start,-charge_type
         ,-tripend_locn,-tripstart_locn,-tel_tripstart)
glimpse(df_map)



# creat heatmap
df_map <- as.matrix(df)
plot_ly(
  x = colnames(df_map),
  y = rownames(df_map),
  z = "heat.colors",
  scale = "column",
  type = "heatmap"
) %>%
  layout(margin = list(l = 120))



#####################################


##correlation of efficincy variables

cordf <- df %>%
  select(fullcharge_amount,
         battery_charg,
         fullcharge_efficiency,
         charging_occurrences)

corr_df = cordf[, c(1, 2, 3, 4)]
corr = round(cor(corr_df), 1)


ggcorrplot(
  corr,
  hc.order = TRUE,
  type = "lower",
  lab = TRUE,
  lab_size = 3,
  method = "circle",
  colors = c("blue", "white", "red"),
  outline.color = "gray",
  show.legend = TRUE,
  show.diag = FALSE,
  title = "Correlogram of efficincy variables"
)


####test the correlation between fullcharge_efficiency, charging_occurrences

cor(first_range$fullcharge_efficiency,
    first_range$charging_occurrences)
# 0.1138597

cor.test(first_range$fullcharge_efficiency,
         first_range$charging_occurrences)


# Pearson's product-moment correlation
#
# data:  first_range$fullcharge_efficiency and first_range$charging_occurrences
# t = 5.6215, df = 2406, p-value =
# 2.112e-08
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  0.07425265 0.15310804
# sample estimates:
#       cor
# 0.1138597 