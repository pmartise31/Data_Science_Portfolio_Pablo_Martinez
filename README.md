# Data Scientist and Biomedical Engineer

## Data Science Projects

### Age prediciton of the Abalone dataset with Random Forrest Regression 

This project focused on predicting the age of abalones using the UCI Abalone dataset, aiming to replace the labor-intensive biological ring-counting method with machine learning. Random Forest Regression and Support Vector Regression were implemented with extensive preprocessing, including outlier analysis, feature scaling, and dimensionality reduction. Hyperparameter tuning through Grid Search and Keras Tuner improved performance, with the Keras-based Random Forest achieving the highest R² of 0.60. The study revealed that the dataset’s complex non-linear relationships and high prevalence of outliers limit the accuracy of standard regression models, highlighting deep learning as a promising direction for future work.

### DNA Core Promoters identification through BERT

This project investigated the use of transformer-based natural language processing methods to identify DNA core promoters, which are key regulatory regions in gene expression. Human genomic sequences were collected and tokenized using different strategies, with k-mer tokenization proving the most effective. A DNABERT classifier was designed by adapting BERT to DNA sequences, skipping the pre-training phase and focusing on fine-tuning with labeled promoter/non-promoter data. The model was trained with Pytorch using Adam optimization, dropout regularization, and multi-head self-attention across encoder layers. Results showed that 6-mer tokenization achieved the best accuracy (0.93), while 3-mer offered a more computationally efficient alternative with slightly lower accuracy (0.91). The study demonstrated that BERT can successfully capture contextual biological patterns for promoter prediction, though further work is needed to address data imbalance and optimize efficiency for large-scale genomic applications.
