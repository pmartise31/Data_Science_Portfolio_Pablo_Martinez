# statistical analysis
# understand overall data behavior and compare differences between branches


# Load libraries ----
library(dplyr)
library(tidyr)


# Source the external R script ----
source("data_cleaning.R")


# Read data from Cleaned_data.csv ----
cleaned_data <- read.csv("Cleaned_data.csv")

# 
# # Encapsulate function of descriptive statistics ----
# # Descriptive statistics:
# # numerical: mean, median, sd, min and max
# # nominal: frequency and proportion
# 
# # Calculate numerical statistics
# calculate_numerical_stats <- function(data) {
#   numerical_stats <- data %>%
#     summarise(
#       across(
#         c(Age, Score, Tenure, Salary, Balance, Products_in_Use),
#            list(
#               Mean = ~ mean(.),
#               Median = ~ median(.),
#               SD = ~ sd(.),
#               Min = ~ min(.),
#               Max = ~ max(.)
#             ),
#             .names = "{col}_{.fn}")
#   )
# 
#   # Transpose the results
#   numerical_stats <- t(numerical_stats)
#   colnames(numerical_stats) <- "Value"
#   
#   return(numerical_stats)
# }
# 
# # Calculate nominal statistics
# calculate_nominal_stats <- function(data) {
#   # Determine using columns
#   cols <- c("Gender", "Left", "Branch")
# 
#   nominal_stats <- data %>%
#     summarise(
#       across(
#         all_of(cols),
#         list(
#               Freq = ~ list(table(.)),
#               Prop = ~ list(prop.table(table(.)))
#            ),
#         .names = "{col}_{.fn}")
#   )
#         
#   return(nominal_stats)
# }
# 
# 
# # Descriptive statstics of whole cleaned data and subbranches ----
# # Whole cleaned_data
# overall_numerical_stats <- calculate_numerical_stats(cleaned_data)
# print("overall numerical statistics of cleaned data:")
# print(overall_numerical_stats)
# 
# overall_nominal_stats <- calculate_nominal_stats(cleaned_data)
# print("overall nominal statistics of cleaned data:")
# print(overall_nominal_stats)
# 
# # Branch1
# cleaned_data_branch1 <- cleaned_data %>% filter(Branch == "Branch1")
# write.csv(cleaned_data_branch1, "Cleaned_Data_Branch1.csv")
# 
# branch1_numerical_stats <- calculate_numerical_stats(cleaned_data_branch1)
# print("numerical statistics of branch1 cleaned data:")
# print(branch1_numerical_stats)
# 
# branch1_nominal_stats <- calculate_nominal_stats(cleaned_data_branch1)
# print("nominal statistics of branch1 cleaned data:")
# print(branch1_nominal_stats)
# 
# 
# # Branch2
# cleaned_data_branch2 <- cleaned_data %>% filter(Branch == "Branch2")
# write.csv(cleaned_data_branch2, "Cleaned_Data_Branch2.csv")
# 
# branch2_numerical_stats <- calculate_numerical_stats(cleaned_data_branch2)
# print("numerical statistics of branch2 cleaned data:")
# print(branch2_numerical_stats)
# 
# branch2_nominal_stats <- calculate_nominal_stats(cleaned_data_branch2)
# print("nominal statistics of branch2 cleaned data:")
# print(branch2_nominal_stats)
# 
# # Branch3
# cleaned_data_branch3 <- cleaned_data %>% filter(Branch == "Branch3")
# write.csv(cleaned_data_branch3, "Cleaned_Data_Branch3.csv")
# 
# branch3_numerical_stats <- calculate_numerical_stats(cleaned_data_branch3)
# print("numerical statistics of branch3 cleaned data:")
# print(branch3_numerical_stats)
# 
# branch3_nominal_stats <- calculate_nominal_stats(cleaned_data_branch3)
# print("nominal statistics of branch3 cleaned data:")
# print(branch3_nominal_stats)


# Use Chi-square to find the relation between categorical data ----
set.seed(42)

## Gender and Left
gender_left_table <- table(cleaned_data$Gender, cleaned_data$Left)
gender_left_test <- chisq.test(gender_left_table)
cat("chi-square result of Gender and Left:\n")
print(gender_left_test)

## Branch and Left
branch_left_table <- table(cleaned_data$Branch, cleaned_data$Left)
branch_left_test <- chisq.test(branch_left_table)
cat("chi-square result of Branch and Left:\n")
print(branch_left_test)
# there is a significant correlation between gender and left,
# and between the branch and left

# Apply ANOVA for Score
anova_salary <- aov(Score ~ Left, data = cleaned_data)
summary(anova_salary)

# Apply ANOVA for Age
anova_salary <- aov(Age ~ Left, data = cleaned_data)
summary(anova_salary)

# Apply ANOVA for Tenure
anova_exp <- aov(Tenure ~ Left, data = cleaned_data)
summary(anova_exp)

# Apply ANOVA for Salary
anova_salary <- aov(Salary ~ Left, data = cleaned_data)
summary(anova_salary)

# Apply ANOVA for Balance 
anova_age <- aov(Balance ~ Left, data = cleaned_data)
summary(anova_age)





## Overall descriptive statistics ----

# View(cleaned_data_branch1)
# View(cleaned_data_branch2)
# View(cleaned_data_branch3)
# View(cleaned_data)

