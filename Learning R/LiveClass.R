y <- c(1:6)
dim(y) <- c(3,2) 

my_playlist <- list (
  fav_movie = c("The Dark Knight", "Marvel"),
  fav_song = "OMG",
  fav_artist = "Newjeans"
)

customer01 <- list(
  name = "toy",
  location = "BKK",
  age = 34,
  movie = c("John Wick", "Dark Knight")
  
)

customer02 <- list(
  name = "John",
  lname = "Wikc",
  age = 42,
  movie = "John Wick 4",
  fav_weapon = "A Pencil"
  
)

customer_db <-list(
  toy = customer01,
  john = customer02
)


friends <- c("toy", "jisoo", "lisa", "rose", "jenny")
ages <- c(34, 25, 26, 27, 28)
movie_lover <- c (F, F, T, F, T)

# สร้างdataframe แบบมีชื่อ colume
df <- data.frame (id = 1:5,
            frind=friends,
            age=ages,
            movie_lover=movie_lover)
 View(df)
 
ages <- c(30, 25, 22, NA, 25)
is.na(ages) 
sum (is.na(ages))

write.csv(df, "friends.csv", row.names = FALSE)
df <- read.csv("friends.csv")


#----------- function
# add_two_nums ()
add_two_nums <- function (x, y){
  return (x+y)
}
# power
power <- function(base, pow=0) {base^pow}

# รับiput จาก user
greeting_bot <- function(){
  username = readline("What is your name: ")
  print (paste("Hello!", username))
}

#------------ control flow
score <- 65

if (score >= 80) {
  print("Passed")
} else {
  print("Failed")
}

score <- 60
if (score >= 90) {
  print ("Passed")
} else if (score >= 50) {
  print ("Ok")
} else {
  print ("Enroll again")
}

# ifelse
ifelse(score >= 80, "Passed", "Failed")


#While loop
count <- 0

while (count < 5) {
  print("Hi!😁")
  count <- count+1
}

new_chatbot <- function () {
  print ("Instruction type 'exit' to exit the program")
  while (TRUE) {
    text = readline ("What's your name? ")
    if (text == "exit") {
      print("Thank you for using our chatbot.")
      break
    } else {
      print(paste ("Hello! ", text))
    }
  }
}


# for loop

(number <- 1:5)

for (val in number) {
  print (val**2)
}

# regular expression
state.name

start_with_A <- grep("^A", state.name)
state.name[start_with_A]

end_with_s <- grep("s$", state.name)
state.name[end_with_s]

contain_new <- grep("new", state.name, ignore.case = TRUE)
state.name[contain_new]


#------------- HW


#HW1: Chatbot 

chat_bot <- function () {
  
  questions <- c("What's your name? ", 
                 "How old are you? ", 
                 "Where are you from? ", 
                 "What is your favorite color? ",
                 "What is your hobby? ")
  answers <- c(NA, NA, NA, NA, NA)
  
  df <- data.frame (questions, answers)

  print ("Instruction: enter 'q' to exit")
  
  counter <- 1
  while (counter <= length(df$question)) {
    input = readline (df$questions[[counter]])
    if (input=="q") {
      break
    } else {
      print(input)
      df$answers[counter] <- input
    }
    counter <- counter +1
  }
  
  print (paste("Hello ", df$answers[[1]], 
               " from ", df$answers[[3]],
               ". You are ", df$answers[[2]],
               ", ", df$answers[[4]], " is your favorite color",
               ", and your hobby is ", df$answers[[5]]
        )
  )
}


#HW2: Game Pao Ying Chub

play_game <- function() {
  user_score <- 0
  computer_score <- 0
  total_game <- 1
  valid_input <- c("1", "2", "3")
  
  while (TRUE) {
    print (paste("Round ", total_game))
    options <- c("1:hammer", "2:scissor", "3:paper")
    print (options)
    
    user_choice = readline("Enter the number (1-3) or 'q' for exit: ")
    
    ## validate input
    if (user_choice == "q") {
      break
    }else if (!(user_choice %in% valid_input)){
      print ("Input only number of 1, 2, or 3 !!!")
      next
    }
    
    ## computer random
    computer_choice <- sample (c(1:3),1)
    
    ## decision
    delta <- abs(as.numeric(user_choice)-as.numeric(computer_choice))
    #print (delta)
    
    if (delta==0) {
      print ("We are tie!")
    } else if (delta==1) { #winner is min
      if (user_choice < computer_choice) {
        print ("You win")
        user_score <- user_score +1
      } else {
        print ("Computer win")
        computer_score <- computer_score +1
      }
      
    } else if (delta==2) { #winner is max
      if (user_choice > computer_choice) {
        print ("You win")
        user_score <- user_score +1
      } else {
        print ("Computer win")
        computer_score <- computer_score +1
      }
    } else {
      print ("Please input number between 1-3")
      next
    }
    
    print (paste("Your is ", options[as.numeric(user_choice)], "vs. Computer is ", options[computer_choice]))
    total_game <- total_game +1
    print ("--------------------------------------------------------------")
  }
  
  ##----- result summary -----
  print ("================================================================")
  if (user_score > computer_score)
    result_text <- paste ("Winner is you!")
  else if (user_score < computer_score)
    result_text <- paste ("Winner is computer!")
  else
    result_text <- paste ("No winner we are tie!")
  print (paste (result_text, "Score of user is ", user_score, "VS. computer is ", computer_score ))
  print ("================================================================")
}

