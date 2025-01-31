install.packages(c("ggplot2", "reshape2"))
library(ggplot2)
library(reshape2)
library(pheatmap)

data <- read.csv("../data/qMGR_Copepoda.csv", row.names=1)

data_matrix <- as.matrix(data)

pdf("qMGR.pdf", width = 8, height = 8)


pheatmap(data_matrix, color = colorRampPalette(c("aquamarine", "purple", "blue"))(100),
        clustering_method = "average",
        cluster_rows = TRUE, cluster_cols = TRUE,
         clustering_distance_rows ="euclidean",
         clustering_distance_cols="euclidean",
         cutree_rows = 3,
         cutree_cols=2)

dev.off()
