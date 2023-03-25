# control flow

# if

score <- 95

if (score >= 90){
  print("Passed")
} else {
  print("Failed")
}

score <- 60
if (score >= 90){
  print ("Passed")
} else if (score >= 50){
  print ("Ok")
} else {
  print ("Enroll again")
}

# ifelse
ifelse(score >= 80, "Passed", "Failed")


# for loop
friends <- c("Toy", "John", "Mary")
for (friend in friends){
  print ( paste("Hi!", friend) )
}

# vectorization
paste ("Hi!", friends) 

nums <- c(5, 10, 12, 20, 25)
(nums <- nums+2)


#While loop
count <- 0

while (count < 5) {
  print("Hi!")
  count <- count+1
}


# function
# input -> f() -> output

x <- c (10, 25, 50, 100)

sum (x)
mean (x)
sd(x)

#create function

greeting <- function(){
  print ("Hello World!")
}

greeting_name <- function(name ="Mary", age =25){
  print ( paste ("Hello!", name))
  print ( paste ("Age: ", age))
}

func <- function(){
  greeting()
  greeting_name("ABC")
}


# add_two_nums ()

add_two_nums <- function (x, y){
  return (x+y)
}

cube <- function (base, power=3){
  return (base ** power)
}

balls <- c("red", "yellow", "blue", "white", "red", "red", "blue", "red")

count_ball <- function (balls, color){
  sum (balls == color)
}




# loop over dataframe
# data()

nrow(USArrests)
ncol(USArrests)
head(USArrests)


cal_mean_by_col <- function (df){
  for (i in 1:ncol(df)){
    #print (names(df)[i])
    #print (mean(df[[i]]))
    print (paste (names(df)[i], ":", mean(df[[i]])))
  }
}


# apply function
apply(mtcars, MARGIN=2, mean) # Margin =2 คือการวิ่งตาม column
avg_by_row_mtcars <- apply(mtcars, MARGIN=1, mean) # by row



