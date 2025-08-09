# Age Prediction of Abalone Using Random Forest Regression

## Summary
This study tackles the challenge of predicting the age of abalones without relying on the labor-intensive biological process of ring counting via microscopy. Using the UCI Abalone dataset, which contains physical measurements such as length, weight, and shell characteristics, the research explores **Random Forest Regression (RFR)** alongside **Support Vector Regression (SVR)** to estimate age.

A key focus is the **impact of outliers on model performance**. Two datasets were compared: one with original values and one with outliers removed via **z-score** and **IQR-based detection**. Feature preprocessing included scaling, encoding the `Sex` variable, and correlation analysis. Dimensionality reduction techniques (**PCA**, **t-SNE**) and hyperparameter tuning (**grid search**, **Keras tuner**) were applied to enhance accuracy.

---

## Findings
- **Outlier removal** reduced error metrics (MAE, MSE) but also decreased R², indicating loss of variance and predictive power.
- **RFR and SVR** both struggled to achieve high accuracy due to the dataset’s complex, non-linear relationships and high prevalence of outliers.
- The **Keras-based RFR** (integrating neural networks) slightly outperformed the scikit-learn implementation, achieving the highest R² (**0.60** with outliers).
- **Dimensionality reduction** did not improve results, as RFR handled feature dimensionality effectively.

---

## Conclusion
The dataset’s non-linear nature and large number of outliers present significant prediction challenges. Standard regression models, even with tuning and preprocessing, could not achieve high accuracy. **Deep learning architectures** show promise for future work, offering better potential to model complex feature–target relationships.

---
