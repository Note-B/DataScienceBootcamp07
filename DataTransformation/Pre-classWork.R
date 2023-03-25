library(readr)
library(dplyr)

imdb <- read_csv("imdb.csv")
View (imdb)

# review structure
glimpse(imdb)

# print head and tail of data
head(imdb,10)
tail(imdb,10)

# select column
select (imdb, MOVIE_NAME, RATING)
select (imdb, 1,5)

select (imdb, movie=MOVIE_NAME, release_year = YEAR)


#Pipe operator
imdb %>% 
  select( movie = MOVIE_NAME, release_year = YEAR) %>%
  head(10)

names(imdb) <- tolower(names(imdb))

#Filter data
names(imdb) <- tolower(names(imdb))
filter(imdb, score>= 9.0)

imdb %>%
  select (movie_name, year, score) %>%
  filter (score >= 9.0 & year >2000)

#filter string
imdb %>%
  select (movie_name, genre, rating) %>%
  filter(grepl("Drama", imdb$genre))

# mutate
imdb %>%
  mutate (score_group = if_else (score >=9, "High rating", "Low raing" ))

# arrange data
head (imdb)
imdb %>%
  arrange (desc(length))

# summarizes
imdb %>%
  filter(rating !="") %>%
  group_by(rating) %>%
  summarise(mean = mean(length),
            sum = sum(length),
            sd = sd(length),
            min = min(length),
            max = max(length),
            n = n())


# join data

favorite_film <- data.frame(id = c(5,10,25,30,98))

favorite_film %>%
  inner_join(imdb, by = c("id" = "no"))


# Export
fav_imdb <- favorite_film %>%
  inner_join(imdb, by = c("id" = "no"))

write_csv(fav_imdb, "fav_imdb.csv")
