library(ggplot2)
library(reshape2)
# Valores de log-likelihood para cada modelo en cada gen de las diferentes ramas evaluadas (se extraen de los archivos de salida de Codeml)
lnL_null <- c(-18860.72505, -9333.180181, -12268.08007, -15936.52817, -15240.61317, -15331.40103, -6219.21397, -24219.49772, -5225.992268, -31011.83796, -7798.368706, -11182.27404, -1088.132870)  # Log-likelihood del modelo nulo
lnL_alt <- c(-18859.78726, -9332.890031, -12267.50451, -15936.19705, -15234.22816, -15325.73109, -6218.659178, -24214.93327, -5224.777331, -31006.8384, -7796.528316, -11182.27404, -1088.132888)    # Log-likelihood del modelo alternativo

# Calcula el estadístico LRT para cada gen
LRT_values <- 2 * (lnL_alt - lnL_null)

# Calcula el valor p con distribución chi-cuadrada con 1 grado de libertad
p_values <- pchisq(LRT_values, df = 1, lower.tail = FALSE)

# Corrección por pruebas múltiples (Bonferroni)
p_adjusted_bonferroni <- p.adjust(p_values, method = "bonferroni")


# Resultados
results <- data.frame(Gene = paste0("Gene_", 1:length(lnL_null)),
                      LRT = LRT_values,
                      p_value = p_values,
                      p_adj_bonferroni = p_adjusted_bonferroni,
                      p_adj_fdr = p_adjusted_fdr)

print(results)
gene_names <- c("COX1", "COX2", "COX3", "CYTB", "ND1", "ND2", "ND3",
                "ND4", "ND4L", "ND5", "ND6", "ATP6", "ATP8")

# Asignar los nombres al dataframe de resultados
results$Gene <- gene_names

# Verificar la tabla actualizada
print(results)


# Exportar la tabla de resultados a un archivo CSV
write.csv(results, file = "Resultados_LRT_Gymnoplea_Codeml.csv", row.names = FALSE)
