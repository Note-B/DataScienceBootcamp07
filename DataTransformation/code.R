library (tidyverse)
library (sqldf)
library (glue)

# Sql on R
sqldf ("select am, avg(mpg), sum(mpg) from mtcars group by am")

# glue
# string template
my_name <- "Toy"
my_age <- 34
glue ("Hello my name is {my_name}")

# tidayverse
# deplur => data transformation

glimpse (mtcars)

# select
select (mtcars, mpg, hp, wt)
select (mtcars, contains ("a"))
select (mtcars, starts_with ("a"))
select (mtcars, ends_with ("p"))
select (mtcars, 1:3)

# การใช้ pipe operator
mtcars %>% 
  select (mpg, hp, wt)

# filter
mtcars %>%
  select (mpg, hp, wt, am) %>%
  filter (mpg > 30 | am==1)
  
mtcars %>%
  rownames_to_column() %>%
  select (model = rowname, 
          milePerGallon = mpg,
          horsePower = hp,
          weight = wt) %>%
  head()


mtcars %>%
  rownames_to_column() %>%
  select (model = rowname, mpg, hp, wt) %>%
  filter (grepl("^M", model))


# arrange sort data
mtcars %>%
  select (model, mpg) %>%
  arrange (mpg)

# summarise
mtcars %>%
  summarise(avg_mpg = mean(mpg),
            n = n())

data("mtcars")
#load over dataframe

for (i in 1:ncol(mtcars)) {
  print (mean(mtcars[[i]]))
}

# 1 คือ row, 2 คือ column
apply (mtcars, 2, mean)


# join datafram
# inner, left, right, full

band_members
band_instruments

left_join (band_members, band_instruments, by= c("name" = "name"))

band_members %>%
  left_join (band_instruments, by="name")

##################################

library(nycflights13)

flights
glimpse(flights)

flights %>%
  filter(year==2013 & month ==9) %>%
  count(carrier) %>%
  arrange(-n) %>%
  head(5) %>%
  left_join(airlines, by="carrier")


################ Homework 1  #############
library(rvest)
library(tidyverse)

url <- "https://www.imdb.com/search/title/?groups=top_100&sort=user_rating%2Cdesc"

movie_name <- url %>%
  read_html() %>%
  html_nodes("h3.lister-item-header") %>%
  html_text2()


rating <- url %>%
  read_html() %>%
  html_nodes("div.ratings-imdb-rating") %>%
  html_text2() %>%
  as.numeric()

votes <- url %>%
  read_html() %>%
  html_nodes("p.sort-num_votes-visible") %>%
  html_text2()

totalvotes <- str_match (votes, "Votes: (.*?) |" )[,2]
totalgross <- str_match (votes, "Gross: (.+M)")[,2]
totaltops <- str_match (votes, "Top 250: (.+)" )[,2]

df <- data_frame(movie_name, rating, totalvotes, totalgross, totaltops)
View (df)


################ Homework 2  #############
library(rvest)
library(tidyverse)
food_url <-"https://www.eater.com/maps/best-restaurants-bangkok-thailand"

restaurant_name <- food_url %>%
  read_html() %>%
  html_nodes("h1") %>%
  html_text2()

# manual remove header, non-restaurant name, footer
restaurant_name <- restaurant_name[- c(1,54,79)]

restaurant_info <- food_url %>%
  read_html() %>%
  html_nodes("div.c-mapstack__info") %>%
  html_text2()

restaurant_addr <- str_split(restaurant_info, "\n", simplify = TRUE)[,1]
restaurant_tel <- str_split(restaurant_info, "\n", simplify = TRUE)[,2]
restaurant_tel <- str_replace(restaurant_tel, "Visit Website", "")

df2 <- data_frame(restaurant_name, restaurant_addr, restaurant_tel)

View(df2)




