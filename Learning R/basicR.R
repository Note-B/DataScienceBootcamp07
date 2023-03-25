## create variable
income <- 50000
expense <-30000
saving <- income-expense

## remove variable
rm(saving)

## compare value
1+1 == 2
2*2 <= 4
5 >= 10
5-2 != 3 # not equal
10 < 2
10 > 2

## Compare text/ character
"Hello" == "hello"

## Data types

## 1.numeric
age <- 32
print(age)
class(age)

## 2.character
my_name <- "Note"
my_university <- 'Assumption University'
print (my_name)
print (my_university)
class (my_name); class (my_university)

## 3.logical
result <- 1+1 == 2
print (result)
class (result)

## 4.factor
animals <- c("Dog", "Cat", "Cat", "Hippo")
print(animals)
class(animals)

animals <- factor (animals)
print(animals)
class (animals)


## 5.date/time
time_now <- Sys.time()
class (time_now)



## convert data type

## main functions
## as.numeric()
## as.character()
## as.logical()

x <- 100
class(x)

char_x <- as.character(x)
class(char_x)
num_x <-as.numeric (char_x)
class(num_x)

## Data structure
## 1. Vector
## 2. Matrix
## 3. List
## 4. DataFrame

##------------------------------------------
##Vector
1:10
16:25
seq(from =1, to = 100, by =5)


## function c
friend <- c("David", "Marry", "Anna", "John", "william")
age <- c(30, 31, 25, 29, 32)
is_male <- c(TRUE, FALSE, FALSE, TRUE, TRUE)



## Matrix
x<-1:25
print(x)
length(x)
dim(x) <- c(5,5)
print(x)


m1 <- matrix(1:15, ncol=5)
m2 <- matrix(1:6, ncol=3, nrow=2, byrow=T)

#---- element wise computation
m2 +100
m2 *4


## List
my_name <- "Note"
my_friend <- c("wan", "Ink", "Sue")
m1 <- matrix (1:25, ncol=5)
R_is_cool <- TRUE

my_list <- list (item1 = my_name,
                 item2 = my_friend,
                 item3 = m1,
                 item4 = R_is_cool)

my_list$item2
my_list$item4


## Data Frame

friend <- c("David", "Marry", "Anna", "John", "william")
age <- c(30, 31, 25, 29, 32)
location <- c("New York", "London", "London", "Tokyo", "Manchester")
movie_lover <- c(T,T,F,T,T)

## Method1
df <- data.frame(friend,
           age,
           location,
           movie_lover)

View(df)

## Method2 (create data frame from list)
my_list <- list(friend = friend,
                age = age,
                location = location,
                movie = movie_lover)

data.frame(my_list)




