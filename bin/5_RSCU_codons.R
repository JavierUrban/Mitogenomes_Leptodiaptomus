#Load libraries
library(ggplot2)
library(dplyr)
library(tidyr)

#Load data
datos <- read.csv("../data/RSCU_Todo_pR.txt", sep = "\t")

#Transform data to long format
datos_largos <- datos %>%
  pivot_longer(cols = starts_with("L_"), 
               names_to = "Species", 
               values_to = "RSCU")
#Check data structure
head(datos_largos)

# Calcular el promedio de RSCU por codón y especie
datos_resumidos_codones <- datos_largos %>%
  group_by(Species, AMINOACIDS, CODONS) %>%
  summarise(RSCU_promedio = mean(RSCU, na.rm = TRUE))

# Definir una paleta de colores personalizada para cada especie
colores_especies <- c("L_garciai" = "red3", "L_Atexcac" = "royalblue", 
                      "L_Carmen" = "mediumpurple", "L_Preciosa" = "chartreuse3", 
                      "L_Quechulac" = "gold")

pdf("RSCU_codons.pdf", width = 10, height = 8)

# Crear el gráfico con colores personalizados y ajuste de cuadrícula
ggplot(datos_resumidos_codones, aes(x = CODONS, y = RSCU_promedio, fill = Species)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ AMINOACIDS, scales = "free_x") +
  labs(title = "Promedio de Uso Relativo de Codones (RSCU) por Codón y Especie",
       x = "Codons",
       y = "RSCU") +
  scale_fill_manual(values = colores_especies) +  # Aplicar colores personalizados
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1),
    strip.text = element_text(size = 8),
    panel.grid.major = element_line(color = "azure2"),  # Aclarar las líneas de la cuadrícula mayor
    panel.grid.minor = element_blank()  # Eliminar las líneas de la cuadrícula menor
  )

dev.off()  # Cierra el archivo PDF
