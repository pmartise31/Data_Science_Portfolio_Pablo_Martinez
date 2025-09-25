
library(pROC)
library(ggplot2)
library(caret)

# switch project to DSProject
# input data
path <- "Cleaned_Data.csv"
cleaned_data <- read.csv(path)

# Part 1 Original Logit Model

# copy the data set
bankdata1 <- cleaned_data

# transfer string -> factor
# Female -> 1
# Male -> 2
bankdata1$Gender <- factor(bankdata1$Gender)
bankdata1$Branch <- factor(bankdata1$Branch)

# check the class of every variable
str(bankdata1)

# fit the logit model (standard)
logit_model <- glm(Left ~ Gender + Age + Score + Tenure + Salary + Balance + Products_in_Use + Branch, 
                   data = bankdata1, 
                   family = binomial)

# check the results of the model
summary(logit_model)

# use the model to predict (by adding additional cols)
bankdata1$Predicted_Prob <- predict(logit_model, type = "response")
bankdata1$Predicted_Class_05 <- ifelse(bankdata1$Predicted_Prob > 0.5, 1, 0) # set the threshold 0.5

# check the confusion matrix
table(bankdata1$Left) # this is the original number of left and remained customers

confusion_05 <- confusionMatrix(factor(bankdata1$Predicted_Class_05),
                                factor(bankdata1$Left),
                                positive = "1")
confusion_05

# accuracy: 0.7936
# recall: 0.1262

# Part 2 Weighted Logit Model

# copy the data set
bankdata2 <- cleaned_data

# transfer string -> factor
# Female -> 1
# Male -> 2
bankdata2$Gender <- factor(bankdata2$Gender)
bankdata2$Branch <- factor(bankdata2$Branch)

# check the class of every variable
str(bankdata2)

# Class Weight Normalization
# Total weight = 2
samples_per_cls <- table(bankdata2$Left)
power <- 1
weights_for_samples <- 1 / (samples_per_cls ^ power)
weights_for_samples <- weights_for_samples / sum(weights_for_samples) * length(samples_per_cls)
bankdata2$weights <- ifelse(bankdata2$Left == 0, weights_for_samples[1], weights_for_samples[2])

# weighted logit model
logit_model_weight <- glm(Left ~ Gender + Age + Score + Tenure + Salary + Balance + Products_in_Use + Branch, 
                          data = bankdata2, 
                          family = binomial(link = "logit"), 
                          weights = weights)

summary(logit_model_weight)

# check the confusion matrix
bankdata2$Predicted_Prob <- predict(logit_model_weight, type = "response")
bankdata2$Predicted_Class <- ifelse(bankdata2$Predicted_Prob > 0.5, 1, 0)

confusion_05_weight <- confusionMatrix(factor(bankdata2$Predicted_Class),
                                factor(bankdata2$Left),
                                positive = "1")
confusion_05_weight

# accuracy: 0.7118
# recall: 0.6745

# print ROC plot and AUC (both standard and weighted)
roc_1 <- roc(bankdata1$Left, bankdata1$Predicted_Prob)
plot(roc_1, main = "ROC curve for Standard Logit Regression")

auc_value_1 <- auc(roc_1)
auc_value_1

roc_2 <- roc(bankdata2$Left, bankdata2$Predicted_Prob)
plot(roc_2, main = "ROC curve for Weighted Logit Regression")

auc_value_2 <- auc(roc_2)
auc_value_2




