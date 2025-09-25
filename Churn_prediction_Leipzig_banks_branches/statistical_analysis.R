# Load necessary libraries
library(dplyr)
library(tidyr)

#setwd("C:/Users/azart/Documents/MScDataScience/Data Science Fundamentals/Group Project/")

# Load cleaned data
cleaned_data <- read.csv("Cleaned_data.csv")

# Function for numerical statistics
calculate_numerical_stats <- function(data) {
  data %>%
    summarise(across(c(Age, Score, Tenure, Salary, Balance, Products_in_Use),
                     list(Mean = mean, Median = median, SD = sd, Min = min, Max = max),
                     .names = "{col}_{.fn}")) %>%
    pivot_longer(everything(), names_to = "Statistic", values_to = "Value")
}

# Function for nominal statistics
calculate_nominal_stats <- function(data, cols = c("Gender", "Left", "Branch")) {
  data %>%
    summarise(across(all_of(cols),
                     list(Freq = ~list(table(.)), Prop = ~list(prop.table(table(.)))),
                     .names = "{col}_{.fn}"))
}

# Calculate stats for each branch simultaneously
branches <- unique(cleaned_data$Branch)

for (branch in branches) {
  cat("\nBranch:", branch, "\n")
  branch_data <- cleaned_data %>% filter(Branch == branch)
  
  cat("Numerical statistics:\n")
  print(calculate_numerical_stats(branch_data))
  
  cat("\nNominal statistics:\n")
  print(calculate_nominal_stats(branch_data))
  
  # Export data by branch
  write.csv(branch_data, paste0("Cleaned_Data_", branch, ".csv"), row.names = FALSE)
}

# Chi-square tests (categorical variables)
cat("\n\nChi-Square Test Results:\n")

# Gender vs Left
gender_left_test <- chisq.test(table(cleaned_data$Gender, cleaned_data$Left))

# Branch vs Left
branch_left_test <- chisq.test(table(cleaned_data$Branch, cleaned_data$Left))

# Collect Chi-square results into one data frame
chi_sq_results <- data.frame(
  Test = c("Gender vs Left", "Branch vs Left"),
  Chi_Square = c(gender_left_test$statistic, branch_left_test$statistic),
  df = c(gender_left_test$parameter, branch_left_test$parameter),
  p_value = c(gender_left_test$p.value, branch_left_test$p.value)
)

print(chi_sq_results)

# ANOVA tests (numerical variables vs Left)
anova_vars <- c("Score", "Age", "Tenure", "Salary", "Balance")

anova_results <- lapply(anova_vars, function(var) {
  aov_result <- aov(as.formula(paste(var, "~ Left")), data = cleaned_data)
  summary_result <- summary(aov_result)[[1]]
  
  data.frame(
    Variable = var,
    F_value = summary_result$`F value`[1],
    p_value = summary_result$`Pr(>F)`[1]
  )
}) %>% bind_rows()

cat("\n\nANOVA Test Results:\n")
print(anova_results)