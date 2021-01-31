#Data Preprocessing

# Load libraries
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
 

df <- read.csv(file = "EV.csv")


# Exploratory data analysis
# 
View(df)
# describe(df)
# profiling_num(df)
# freq(df)
# plot_num(df)
# glimpse(df)





#Cleaning up the data


df<- df %>%
  select(
    - GPS_AVG_VELOCITY,
    - START_ALTITUDE,
    - END_ALTITUDE,
    - DISTANCE_GPS,
    - TEMPERATURE,
    - HEADLAMP_ON_PCT,
    - TRIP_ID,
    - VEHICLE_ID,
    - START_BAT_EST,
    - END_ODO_EST,
    - END_BAT_EST,
    - UNACCOUNTED_KM,
    - AC_ON_PCT)


df <-df %>% drop_na()
names(df) <- tolower(names(df))


df <- df %>%
  mutate(.,battery_charg = (df$end_bat_actual - df$start_bat_actual))

reactable(df,
          defaultPageSize = 5,
          bordered = TRUE,
          defaultColDef = colDef(footer = function(values) {
            if (!is.numeric(values)) return()
            sparkline(values, type = "box", width = 100, height = 30)
          })
)




full_charge <- df %>%
  filter(fullchargeflag == 1)
loads<- df %>% 
  select(accessories)  
loads<- unique(loads)



ggplotly(ggplot(df, aes(trip_distance,battery_charg))
         + geom_point(aes( colour=factor(accessories), size = no_passengers))
         )
      
         
