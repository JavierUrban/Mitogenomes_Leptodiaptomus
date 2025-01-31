# Cargar librerías necesarias
library(ggplot2)
library(readr)
library(tidyr)
library(dbplyr)
library(dplyr)
library(svglite)

# Cargar los datos, estos se cambiaron para cada grupo de datos
#Y se editaron los nombres de las salidas con el nombre del grupo correspondiente
kaks_data <- read_delim("../data/Table_KaKs_Cyclopoida.txt", delim = "\t")
head(kaks_data)

# Asignar colores a los complejos
kaks_data$Complex <- case_when(
  kaks_data$Gen %in% c("ND1", "ND2", "ND3", "ND4", "ND4L", "ND5", "ND6") ~ "Complex I",
  kaks_data$Gen %in% c("CYTB") ~ "Complex III",
  kaks_data$Gen %in% c("COX1", "COX2", "COX3") ~ "Complex IV",
  kaks_data$Gen %in% c("ATP6", "ATP8") ~ "Complex V",
  TRUE ~ "Other"
)

# Definir la paleta de colores
complex_colors <- c("Complex I" = "#EEE000", "Complex III" = "#FE33FF",
                    "Complex IV" = "#008C00", "Complex V" = "#006CFF")

# Crear el boxplot

p <- ggplot(kaks_data, aes(x = Gen, y = `Ka/Ks`, fill = Complex)) +
  geom_boxplot() +
  scale_fill_manual(values = complex_colors) +
  labs(title = "Ka/Ks for gen Cyclopoida",
       x = "Gen",
       y = "Ka/Ks",
       fill = "Complex") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "bottom", # leyenda debajo del gráfico
    legend.title = element_text(face = "bold"), # Título de la leyenda en negritas
    legend.text = element_text(size = 10) # Tamaño del texto de la leyenda
  )
  #theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Guardar el gráfico en un archivo PDF
ggsave("KaKs_Boxplot_Cyclopeida.pdf", plot = p, width = 10, height = 6)

# Exportar el gráfico en formato SVG de alta calidad
ggsave("KaKs_Cyclopoida.svg", plot = p, width = 10, height = 6, units = "in", dpi = 300)

# Mostrar el gráfico en la consola
print(p)
