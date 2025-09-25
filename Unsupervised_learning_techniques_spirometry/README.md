### Summary
This study addresses the challenge of classifying patients with restrictive or obstructive respiratory diseases using spirometry signals, avoiding manual clinical diagnosis. Leveraging continuous spirometry data from NHANES, the research explores unsupervised learning by combining autoencoders and reservoir computing with clustering algorithms (primarily K-means) to distinguish between diseased and healthy individuals. Data preprocessing involved signal quality control, peak-flow extraction, and denoising to ensure robust temporal representations.

### Findings
- K-means outperformed other clustering methods (DBSCAN, hierarchical clustering) with higher silhouette scores for both full and peak spirometry sequences.
- Autoencoders captured latent high-level patterns and provided compressed representations that increased inter-class variance, though training was computationally demanding.
- Reservoir computing efficiently modeled temporal dependencies with lower risk of overfitting and reduced training cost, though it was highly sensitive to hyperparameters and less effective in long-term dependencies.
- Both approaches achieved clinically significant separation for full sequences, but failed to produce meaningful groups when applied only to peak data.
- Boundary cases revealed that severe respiratory conditions were better detected, while mild cases remained harder to classify.

### Conclusion
Deep learning–based hybrid approaches, such as autoencoders and reservoir computing combined with clustering, show promise in complementing traditional diagnostics by offering automated first-stage detection of severe respiratory diseases. Full spirometry sequences preserve crucial temporal dynamics for effective clustering, while peak-based data lose discriminatory power. Although these solutions are promising for clear obstructive or restrictive cases, integration with clinical expertise remains essential, especially for borderline patients. Future improvements include peak detection automation, transient state handling in reservoirs, and applying models to labeled datasets to distinguish between restrictive and obstructive conditions more accurately
