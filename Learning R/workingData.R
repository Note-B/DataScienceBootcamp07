library(readr)

## file with white-space to separate column
student <- read_table("student.txt")
#View(student)

## file in CSV format
student_csv <- read_csv("student.csv")
#View(student_csv)

library (readxl)
## file in xlsx format
#student_xlsx <- read_excel("students.xlsx", sheet=1)
#student_xlsx <- read_excel("students.xlsx", sheet="Economics")
#student_xlsx <- read_excel("students.xlsx", sheet=3)


# loop sheet into list
result <- list()
for (i in 1:3){
  result[[i]] <- read_excel("students.xlsx", sheet=i)
}

# read from google sheet
library (googlesheets4)
url <- "https://docs.google.com/spreadsheets/d/1OH6beyAFHYhxRYOWOiEWffiS1E20-Uve1nAxvZ8ZKFs"
gs4_deauth()
df <- read_sheet(url, sheet="student")
View(df)


# read from JSON
library(jsonlite)
fromJSON("blackpink.json")
bp <- data.frame(fromJSON("blackpink.json"))
View(bp)


#bind_rows == SQL_UNION_ALL
library (readxl)
## file in xlsx format
econ <- read_excel("students.xlsx", sheet=1)
business <- read_excel("students.xlsx", sheet=2)
data <- read_excel("students.xlsx", sheet=3)

bind_rows(econ, business, data)

#bind_cols ไม่เทียบเท่ากับ join
df1 <- data.frame (
  id=1:5,
  name=c("john","Marry","Anna","David","Lisa")
)
df2 <- data.frame (
  id=1:5,
  city= c(rep("BKK",3), rep("LONDON",2)),
  country = c(rep("TH",3), rep("UK",2))
)
bind_cols (df1, df2)
left_join (df1, df2, by="id")

#SQL
library(sqldf)
library(readr)

school <- read_csv("school.csv")

sqldf("select * from school;")

sqldf("select avg(student), sum(student) from school;")

sqldf("select school_id, school_name, country from school;")

sql_query <- "select * from school where country = 'USA';"
usa_school <- sqldf(sql_query)


#SQLlite
library(RSQLite)
# connect to SQLite database (.db file)
# 1. open connection
conn <- dbConnect(SQLite(), "chinook.db")

# 2. get data
dbListTables(conn)
dbListFields(conn, "customers")

df <- dbGetQuery(conn, "select * from customers where country = 'USA'")
df2 <- dbGetQuery(conn, "select * from customers where country = 'United Kingdom'")

# 3. close connection
dbDisconnect(conn)

# save data frame
save.image(file="data.RData")
load (file="data.RData")
# หรือแค่ data frame อันเดียว
saveRDS (business, file = "business.rds")
readRDS ("business.rds")
