# XGBoost

# Importing the libraries
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import xgboost as xgb
from sklearn.metrics import log_loss, classification_report ,confusion_matrix, RocCurveDisplay
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import OneHotEncoder
from xgboost import XGBClassifier


# Read the csv file
cleaned_data = pd.read_csv('Cleaned_Data.csv')
cleaned_data_encoding = cleaned_data.copy()


# Extract dataframe except Customer_ID column
cleaned_data_encoding = cleaned_data_encoding.drop('Customer_ID', axis=1)


# One-hot encoding for Gender and Branch column
# Initialize OneHot Encoder
encoder = OneHotEncoder(sparse_output= False)

# Implement OneHot Encoder for Gender column
encoded_gender = encoder.fit_transform(cleaned_data_encoding[["Gender"]])
gender_columns = encoder.get_feature_names_out(["Gender"])
encoded_gender_df = pd.DataFrame(encoded_gender, columns = gender_columns)

# Implement OneHot Encoder for Branch column
encoded_branch = encoder.fit_transform(cleaned_data_encoding[["Branch"]])
branch_columns = encoder.get_feature_names_out(["Branch"])
encoded_branch_df = pd.DataFrame(encoded_branch, columns = branch_columns)


# Merge dataframe and save to csv
cleaned_data_encoding = pd.concat([cleaned_data_encoding.drop(["Gender", "Branch"], axis = 1), encoded_gender_df, encoded_branch_df], axis = 1)
# cleaned_data_encoding = pd.concat([cleaned_data_encoding.drop(["Gender", "Branch"], axis = 1), encoded_branch_df], axis = 1)
# cleaned_data_encoding = pd.concat([cleaned_data_encoding.drop(["Branch"], axis = 1), encoded_branch_df], axis = 1)
 

cleaned_data_encoding.to_csv("Cleaned_Data_Encoding.csv", index = False)


# Split data into the target vector of the eigenmatrix
X = cleaned_data_encoding.drop('Left', axis = 1)
y = cleaned_data_encoding['Left']


# Split the data into the Training set and Test set
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 42)
    

# Tune hyperparameter by GridSearchCV
# Define XGBoost classifier
model = xgb.XGBClassifier()

# Define the grid of hyperparameters
param_grid = {
    'max_depth': [4],
    'objective': ['binary:logistic'],
    'eval_metric': ['logloss'],
    #'eval_metric': ['logloss', 'error'],
    'learning_rate': [0.2],
    'gamma': [0, 0.1],
    'reg_lambda': [0, 1.0, 10.0],
    'scale_pos_weight': [8,9,10,11,12],
    # 'n_estimators': [ 90, 100, 110],
    'n_estimators': [ 30],
}

grid_search = GridSearchCV(estimator = model, param_grid = param_grid, cv = 5, scoring = 'roc_auc',n_jobs = -1, verbose = 2)

# Train the XGBoost model
grid_search.fit(X_train, y_train)

# Get best model
best_model = grid_search.best_estimator_
print("best_model:", best_model)


# Get the probability of the prediction of class 1
y_prob = best_model.predict_proba(X_test)[:, 1]

# Set the new threshold(by default, the threshold is 0.5)
# Predict the Test set results
threshold = 0.8
y_pred = (y_prob >= threshold).astype(int)


# Evaluate model
loss = log_loss(y_test, y_prob)
print(f"Log Loss: {loss}")
print(classification_report(y_test, y_pred))

# Plot ROC curve
RocCurveDisplay.from_estimator(best_model, X_test, y_test, name = 'XGBoost')
plt.title('ROC Curve of customer churn prediction')
xlabel = plt.xlabel('False Positive Rate(Predicted churn when actual retained)')
ylabel = plt.ylabel('True Positive Rate(Predicted churn when actual churn)')
plt.show()

# Plot the Confusion Matrix
# Cumstomer stay--negative--0
confusion_matrix = confusion_matrix(y_test, y_pred)
plt.figure(figsize = (8, 6))
sns.heatmap(confusion_matrix, annot = True, fmt = 'd', cmap = 'Blues',
            xticklabels = ['Predicted retained(0)', 'Predicted churn(1)'],
            yticklabels = ['Actual retained(0)', 'Actual churn(1)'])
plt.xlabel('Predicted label')
plt.ylabel('Actual label')
plt.title('Confusion Matrix of customer churn prediction')
plt.show()

# Plot important features
xgb.plot_importance(best_model)
plt.title('Important features')
plt.show()