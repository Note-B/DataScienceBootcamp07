## Essential ML Part1
# caret = Classification And REgression Tree

library ("caret") 
library ("tidyverse")

# train test split
# 1. split data
# 2. train
# 3. score
# 4. evaluate

glimpse (mtcars)


train_test_split <- function (data, trainRatio=0.7) {
  set.seed(07)
  (n <- nrow(data)) #ใส่วงเล็บด้สนนอกคือการประกาศตัวแปรแล้วปรินซ์ค่าออกมาเลย
  id <- sample (1:n, size = trainRatio*n)
  train_data <- data[id,]
  test_data <- data[-id,]
  return (list (train=train_data, test=test_data))
}

# split data 80%:20%
set.seed(07)
splitData <- train_test_split(mtcars, 0.8)
train_data <- splitData$train
test_data <- splitData$test


# train model
model <- lm(mpg ~ hp + wt + am, data = train_data)

# score model
mpg_pred <- predict(model, newdata = test_data)

# evaluate model
# MAE, MSE, RMSE

mae_metric <- function (actual, prediction) {
  # mean absolute error - treats every data point the same
  abs_error <- abs(actual-prediction)
  mean(abs_error)
}

mse_metric <- function (actual, prediction) {
  # mean squared error - treats large error point with more weight (ถ้าค่าผิดเยอะจะถูกทำโทษากกว่า)
  sq_error <- (actual-prediction)**2
  mean(sq_error)
}

rmse_metric <- function (actual, prediction) {
  # root mean squared error - Sqrt to set back to normal unit (การทำให้มันกลับมาอยุ่ที่ unit เดิม)
  sq_error <- (actual-prediction)**2
  sqrt(mean(sq_error))
}

actual = test_data$mpg
prediction = mpg_pred
paste("Mean absolute value", mae_metric(actual, prediction))
paste("Mean sqaure value", mse_metric(actual, prediction))
paste("Root mean sqaure value", mae_metric(actual, prediction))



####### CARET library interface ช่วยในการสร้าง model ได้หลายๆ model โดยใช้ code เดิมๆ
library (caret)

# 1. split data
sData <- train_test_split(mtcars,0.7)
train_data <- sData[[1]]
test_data <- sData[[2]]

# 2. train model
# mpg = f(hp, wt, am)

#train control
ctrl <- trainControl(
  method = "CV", # "boot"- bootstrap, "LOOCV" - leave one out CV, "CV"- K_FOLD (golden standard)
  number = 5,
  #verboseIter = TRUE
)

lm_model <- train(mpg ~ hp + wt + am,
               data = train_data,
               method = "lm", # algorithm, "rf" - random forest, "knn" - knn
               trControl = ctrl) # optional parameter to control training 

rf_model <- train(mpg ~ hp + wt + am,
                  data = train_data,
                  method = "rf", # algorithm, "rf" - random forest, "knn" - knn
                  trControl = ctrl) # optional parameter to control training

knn_model <- train(mpg ~ hp + wt + am,
                  data = train_data,
                  method = "knn", # algorithm, "rf" - random forest, "knn" - knn
                  trControl = ctrl) # optional parameter to control training 
lm_model
rf_model
knn_model

# 3. score model
p <- predict(lm_model, newdata = test_data)

# 4. evaluate model
actual = test_data$mpg
prediction = p
paste("Mean absolute value (test)", mae_metric(actual, prediction))
paste("Mean sqaure value (test)", mse_metric(actual, prediction))
paste("Root mean sqaure value (test)", mae_metric(actual, prediction))

# 5. save model
saveRDS(model, "linear_regresssion_v1.RDS")


### Load and run from save model
(new_cars <- data.frame (
  hp = c (150, 200, 250),
  wt = c (1.25, 2.2, 2.5),
  am = c (0,1,1)
))

model <- readRDS ("linear_regresssion_v1.RDS")
new_cars$mpg_p <- predict(model, newdata = new_cars)
new_cars

