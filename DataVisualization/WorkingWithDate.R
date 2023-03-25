library (tidyverse)
library (lubridate)

#Working with date
date_df <- data.frame( 
  x = c (
    "2023-02-25",
    "2023-02-26",
    "2023-02-27",
    "2023-02-28",
    "2023-03-01"))

class(date_df$x)

# convert character to date ymd() or mdy() or myd() or... depend on input format

date_df %>%
  mutate(date_x = ymd(x),
         year = year(date_x),
         month = month(date_x),
         day = day(date_x),
         wday = wday(date_x))

date_df %>%
  mutate(date_x = ymd(x),
         year = year(date_x),
         month = month(date_x, label = TRUE), #ชื่อเดือน 3ตัว
         day = day(date_x),
         wday = wday(date_x, label = TRUE)) #ชื่อวัน 3ตั

date_df %>%
  mutate(date_x = ymd(x),
         year = year(date_x),
         month = month(date_x, label = TRUE, abbr = FALSE), #full name of month
         day = day(date_x),
         wday = wday(date_x, label = TRUE, abbr = FALSE), #full name of day
         week = week(date_x))
