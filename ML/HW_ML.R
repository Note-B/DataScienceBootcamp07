## ML Homework
## Using House Price data to create model with 3-5 input parameter to predict price

library(readxl)
library(caret)
library(tidyverse)
library(janitor)


# Split data
split_data <- function (dataset, percentTrain) {
  set.seed(07)
  n <- nrow(dataset)
  id <- sample (1:n, size = n*percentTrain)
  return (list(train=dataset [id,], test=dataset[-id,]))
}

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

# Load data from excel
house_price_data <- read_xlsx("~/LearningWithR/ML/House Price India.xlsx")
house_price_data <- house_price_data %>%
  mutate (Date = as.Date(Date, origin = "1899-12-30")) %>%
  clean_names()

# split data into 70% : 30%
split_data <- split_data (house_price_data, 0.7)
training_data <- split_data$train
testing_data <- split_data$test

#train control
ctrl <- trainControl(
  method = "CV", # "boot"- bootstrap, "LOOCV" - leave one out CV, "CV"- K_FOLD (golden standard)
  number = 5,
)

lm_model <- train(price ~ living_area + grade_of_the_house + renovation_year +
                    postal_code + distance_from_the_airport,
                  data = training_data,
                  method = "lm",
                  trControl = ctrl)

knn_model <- train(price ~ living_area + grade_of_the_house + renovation_year + 
                     postal_code + distance_from_the_airport,
                   data = training_data,
                   method = "knn",
                   trControl = ctrl)

sub_train <- training_data[1:1000,] #reduce number of training data to avoid crash

rf_model <- train(price ~  living_area + grade_of_the_house + renovation_year + 
                    postal_code + distance_from_the_airport,
                  data = sub_train,
                  method = "rf",
                  trControl = ctrl)

# Evaluate model
lm_price <- predict(lm_model, newdata = testing_data)
knn_price <- predict(knn_model, newdata = testing_data)
rf_price <- predict(rf_model, newdata = testing_data)
actual <- testing_data$price

result_table <- data.frame(
  model = c("LM", "KNN", "RF"),
  model_r_sqrt = c(lm_model$results$Rsquared, max(knn_model$results$Rsquared), max(rf_model$results$Rsquared)),
  mae = c(mae_metric(actual, lm_price), mae_metric(actual, knn_price), mae_metric (actual, rf_price)),
  rmse = c(rmse_metric(actual, lm_price), rmse_metric(actual, knn_price), rmse_metric (actual, rf_price)),
  mse = c(mse_metric(actual, lm_price), mse_metric(actual, knn_price), mse_metric (actual, rf_price))
)

print("Summary ")
print(result_table, quote = FALSE, row.names = TRUE)

print("Conclusion: Model selection based on minimum RMSE is ")
print(result_table[which.min(result_table$rmse),], quote = FALSE, row.names = TRUE)



