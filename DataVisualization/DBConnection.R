library (tidyverse)
library (RSQLite) #DBI
library (RPostgreSQL)
library (lubridate)
library (janitor)

#Connect database
con <- dbConnect(SQLite(), "chinook.db")

#list table names
dbListTables(con)

#list fields in a table
dbListFields(con,"customers")

#write SQL queries
df <- dbGetQuery(con, "select * from customers limit 10")

df %>%
  select (FirstName, LastName)

#clean all column names -> "lower case" and "no white space space"
clean_df <- clean_names(df)

#write join syntax
df2 <- dbGetQuery(con, "select * from albums, artists
                  where albums.artistid = artists.artistid") %>%
        clean_names()

# write a table (send dataframe into database)
dbWriteTable(con, "cars", mtcars)
dbListTables(con)

dbGetQuery(con, "select * from cars limit 5;")

# drop table
dbRemoveTable(con, "cars")
dbListTables(con)

#Disconnect /close connection
dbDisconnect(con)


#------------------- PostgresQL---------------------
conP <- dbConnect(PostgreSQL(), 
                  host = "arjuna.db.elephantsql.com",
                  port = 5432,  # default of PostgreSQL https://www.elephantsql.com/
                  user ="wvyaddea",
                  pass = "9OFHTJ4NGaoxS0O3zXm4g2NkB_IEXWao",
                  dbname = "wvyaddea")
dbListTables(conP)

# write table mtcar dataframe first 5 rows
dbWriteTable(conP, "cars", mtcars %>% slice (1:5) )

# list table
dbListTables(conP)

#get query
dbGetQuery(conP, "select count(*) from cars")
dbGetQuery(conP, "select * from cars")

#disconnect
dbDisconnect(conP)

#--------------------- lubridate ---------------------
