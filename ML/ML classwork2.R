#mlbench rpart randomForeset class glmnet

# load library
library(caret)
library(mlbench)
library(tidyverse)
library(MLmetrics)

# see available data
data()
data("BostonHousing")

# glimpse data
df <- BostonHousing
glimpse(df)


# Clustering => segmentation

subset_df <- df %>% 
  select(crim, rm, age, lstat, medv) %>%
  as_tibble()     # convert to tibble (enhanced dataframe) -> default show 10 record

# test different k (k=2-5)
result <- kmeans(x = subset_df, centers = 3)

# assign membership back to datafram column
subset_df$cluster <- result$cluster

subset_df %>% 
  group_by(cluster) %>%
  summarise(avg_mdv = mean(medv))

result$centers

#---------------- unsuperviser --------------
df <- as_tibble(df)
# 1. split data
set.seed(07)
n <- nrow(df)
id <- sample(1:n, size = 0.8*n)
train_data <- df[id,]
test_data <- df[-id,]

set.seed(07)


#------------ Linear regression ----------------
#2. train model
# medv = f(crim, rm, age)
lm_model <- train (medv ~ crim + rm + age,
                    data = train_data,
                    method = "lm",
                    preProcess = c("center", "scale"))

#----------- knn -------------------
#2. train model
#knn_model <- train (medv ~ crim + rm + age,
#                   data = train_data,
#                   method = "knn",
#                   preProcess = c("center", "scale"))


# define hyperparameter
ctrl <- trainControl(method = "cv", #changing default bootstrap resampling to k-fold
                     number=5,
                     verboseIter = TRUE)

# grid search *need to be datafram, column name need to be exactly match to column in model result
k_grid <- data.frame(k = c(3,5,7,9,11))


# change metric of model optimize for RMSE, Rsquared, etc?
knn_model <- train (medv ~ crim + rm + age,
                    data = train_data,
                    method = "knn",
                    metric = "Rsquared",
                    tuneGrid = k_grid, # define exact k
                    preProcess = c("center", "scale"),
                    trControl = ctrl)


# tune length, computer will define
knn_model <- train (medv ~ crim + rm + age,
                    data = train_data,
                    method = "knn",
                    metric = "Rsquared",
                    tuneLength = 5, #let computer define
                    preProcess = c("center", "scale"),
                    trControl = ctrl)

#3. score
p <- predict (knn_model, newdata = test_data)

#4. evaluate
RMSE(p , test_data$medv)


#-------------------- classification ---------------------

data("PimaIndiansDiabetes")
df <- as_tibble(PimaIndiansDiabetes)

contrasts(df$diabetes)

# re-arrange order of factor parameter to be 1st order for prediction
df$diabetes <- fct_relevel(df$diabetes, "pos")

contrasts(df$diabetes)

# subset data frame
#subset_df <- df %>%
#  select (glucose, insulin, age, diabetes)

#1. split data
set.seed(07)
n <- nrow(subset_df)
id <- sample(1:n, size = 0.8*n)
train_data <- subset_df[id,]
test_data <- subset_df[-id,]

#2. train model
set.seed(07)
ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE,
                     summaryFunction = prSummary, #changing train metric to be other (not accuracy)
                     classProbs = TRUE) # calculate probability of neg and pos

# binary result default metric will be accuracy
#(knn_model <- train (diabetes ~ .,
#                    data = train_data,
#                    method = "knn",
#                    metric = "Spec", #Recall-Sens, Spec, ROC
#                    trControl = ctrl))

# using MLmetric require additional library
(knn_model <- train (diabetes ~ .,
                     data = train_data,
                     method = "knn",
                     metric = "Accuracy", #PR AUC, F, Recall
                     trControl = ctrl))


#3. score
p <- predict(knn_model, newdata = test_data)

#4. evaluate
#table(test_data$diabetes, p, dnn=c("Actual","Prediction"))
#(acc = (73+34)/(73+20+27+34))

# define target of model between pos and neg
confusionMatrix(p, test_data$diabetes, 
                positive = "pos",
                mode = "prec_recall")

#---------------------- Logistic Regression --------------
set.seed(07)
ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE) 


# using MLmetric require additional library
(glm_model <- train (diabetes ~ .,
                     data = train_data,
                     method = "glm",
                     metric = "Accuracy",
                     trControl = ctrl))

#3. score
p <- predict(glm_model, newdata = test_data)

#4. evaluate
confusionMatrix(p, test_data$diabetes, 
                positive = "pos")

#--------------------- Decision tree ------------------
#library rpart
# using MLmetric require additional library
(rpart_model <- train (diabetes ~ .,
                     data = train_data,
                     method = "rpart",
                     metric = "Accuracy",
                     trControl = ctrl))
#3. score
p <- predict(rpart_model, newdata = test_data)

#4. evaluate
confusionMatrix(p, test_data$diabetes, 
                positive = "pos")

library(rpart.plot)
rpart.plot(rpart_model$finalModel)


#--------------------- Random forest -------------------
# Model accuracy the highest >- 78%
# no subset column



mtry_grid <- data.frame(mtry = 2:8)

(rf_model <- train (diabetes ~ .,
                       data = train_data,
                       method = "rf",
                       metric = "Accuracy",
                       tuneGrid = mtry_grid,
                       trControl = ctrl))

#3. score
p <- predict(rpart_model, newdata = test_data)

#4. evaluate
confusionMatrix(p, test_data$diabetes, 
                positive = "pos")


#----------------- Compare model
# compare models
list_models <- list(knn = knn_model,
                    logistic = glm_model,
                    decisionTree = rpart_model,
                    randomForest = rf_model)

result <- resamples(list_models)
summary(result)


# Reduce overfitting
#--------------------- Ridge / Lasso Regression ----------------
glmnet_grid <- expand.grid(alpha=0:1, #alpha 0=ridge, 1=lasso
                          lambda=c(0.1,0.2,0.3)) 

(glmnet_model <- train (diabetes ~ .,
                    data = train_data,
                    method = "glmnet",
                    metric = "Accuracy",
                    tuneGrid = glmnet_grid,
                    trControl = ctrl))





