## Logistic Regression Example
## Binary classification

happiness <- c(10, 8, 9, 7, 8, 5, 9, 6, 8, 7, 1, 1, 3, 1, 4, 5, 6, 3, 2, 0)
divorce <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

df <- data.frame(happiness, divorce)

## Fit Logistic Regression with Full dataset
full_model <- glm (divorce ~ happiness, data = df, family = "binomial")

summary(full_model)

## Predict and Evaluate model
df$prob_divorce <- predict(full_model, type="response")

# แปลงค่าprobaility ไปเป็นผล
df$pred_divorce <- ifelse(df$prob_divorce >= 0.5, 1, 0)

## confusion matrix
conMatrix <- table(df$pred_divorce, df$divorce, 
      dnn = c("Predicted", "Actual"))

## Model Evaluation

# Accuracy
cat("Accuracy:", Acc <- (conMatrix[1,1] + conMatrix[2,2])/sum(conMatrix))

# Precision
cat("Precision:", Prec <- (conMatrix[2,2])/sum(conMatrix[2,]))

#Recall
cat("Recall:", Rec <- (conMatrix[2,2])/sum(conMatrix[,2]))

#F1
cat("F1 score:", F1 <- 2 * (Prec * Rec) / (Prec + Rec))


##### Pre-class exercise #####
library(titanic)

head (titanic_train)

## Drop NA (missing value)
titanic_train <- na.omit(titanic_train)
nrow(titanic_train)

## Split data
set.seed(7)
n <- nrow(titanic_train)
id <- sample (1:n, size=n*0.7) #70% train, 30# test
train_data <- titanic_train[id,]
test_data <- titanic_train[-id,]

## Train model with logistic regression
tModel <- glm (Survived ~ Pclass + Sex + Age + SibSp + Parch, data = train_data, family = "binomial")
summary(tModel)

test_data$Prob <- predict(tModel, test_data, type="response")
test_data$Predict <- ifelse(test_data$Prob>=0.5, 1, 0)

## confusion matrix
tMatrix <- table(test_data$Predict, test_data$Survived, 
                   dnn = c("Predicted", "Actual"))

## Model Evaluation
# Accuracy
tAcc <- (tMatrix[1,1] + tMatrix[2,2])/sum(tMatrix)
# Precision
tPrec <- (tMatrix[2,2])/sum(tMatrix[2,])
#Recall
tRec <- (tMatrix[2,2])/sum(tMatrix[,2])
#F1
tF1 <- 2 * (tPrec * tRec) / (tPrec + tRec)

cat(sprintf("Model Accuracy is %0.1f%%.\nPrecision is %0.1f%%.\nRecall is %0.1f%%.\nF1 score is %0.1f%%.\n", 
            tAcc*100, tPrec*100, tRec*100, tF1*100))
























