install.packages(c("ggplot2", "reshape2"))
library(ggplot2)
library(reshape2)

library(pheatmap)
data <- read.csv("../data/Pares_sinap.csv", row.names=1)

data_matrix <- as.matrix(data)

pdf("Pares_sinapEuc_UPGMA7.pdf", width = 4, height = 8)


pheatmap(data_matrix, color = colorRampPalette(c("white", "orange", "red"))(100),
        clustering_method = "average",
        cluster_rows = TRUE, cluster_cols = TRUE,
         clustering_distance_rows ="euclidean",
         clustering_distance_cols="euclidean",
         cutree_rows = 7)

dev.off()  # Cierra el archivo PDF
