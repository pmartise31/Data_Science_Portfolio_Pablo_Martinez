# DNA Core Promoters Identification through BERT

### Summary

This study explores the application of Bidirectional Encoder Representations from Transformers (BERT) to identify DNA core promoters, which play a crucial role in gene expression regulation. Human genomic sequences from multiple sources, including globin genes, mitochondrial DNA, and transmembrane proteins, were compiled and labeled using promoter prediction tools. Different tokenization strategies were compared: single-base, Byte-Pair Encoding (BPE), and k-mer tokenization. DNABERT, an adaptation of BERT for DNA sequences, was trained using Pytorch with Adam optimization, dropout regularization, and attention-based encoder layers. Hyperparameters such as embedding dimension, sequence length, and learning rate were tuned to optimize performance.

### Findings

K-mer tokenization was the most biologically meaningful method, with 6-mer achieving the highest test accuracy (0.93) and 3-mer providing a more efficient trade-off (0.91).

Training loss decreased rapidly within the first epochs before plateauing, while validation loss remained stable due to strong dropout regularization.

The adaptation of BERT to DNA required skipping pre-training tasks (e.g., masked language modeling) and focusing on fine-tuning for promoter classification.

Larger k-mer sizes improved biological context capture but increased vocabulary size, computational expense, and training time.

Cross-entropy loss effectively measured prediction performance, confirming that BERT could generalize from repetitive DNA patterns despite lacking natural language semantics.

### Conclusion
The results demonstrate that BERT can be successfully adapted for promoter site classification in DNA sequences. K-mer tokenization, especially with k=6, provides the richest biological context, though smaller k-values are computationally more efficient. While DNABERT achieves strong predictive accuracy, challenges remain in handling long DNA sequences, data imbalance, and computational cost. Future work should refine tokenization strategies, address imbalance, and explore deeper or pre-trained architectures to enhance generalization across large genomic datasets.
