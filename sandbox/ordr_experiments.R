library(Lock5withR)
library(ordr)
pca_ordr <- ordinate(Cereal, cols = 3:10,
                     model = ~ prcomp(., scale. = TRUE))

ggbiplot(pca_ordr) +
  geom_rows_point(size = 1, color = "cornflowerblue") +
  geom_rows_text_repel(aes(label = Name),
                       size = 2, color = "cornflowerblue") +
  geom_cols_vector(color = "red",
                   vector_labels = FALSE) +
  geom_cols_axis(aes(label = name), label_size = 2.5, 
                 label_color = "red", num = 12) +
  stat_rows_projection(subset = 23,
                       ref_subset = c(2, 4, 6),
                       color = "blue",
                       linetype = "dashed") +
  xlim(c(-5, 5)) +
  theme_minimal()
