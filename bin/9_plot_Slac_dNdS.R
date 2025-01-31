# Cargar librerías necesarias
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(svglite)

#En cada ejecución se seleccionaron los archivos de cada grupo
#Y se editaron las salidas con los nombres correspondientes
# Leer los datos
datos <- read.table("../data/genes_dNdS_concatenados_cyclop.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# Convertir la columna dN-dS a numérico
datos$dN.dS <- as.numeric(datos$dN.dS)

# Asignar colores por complejo
datos$Color <- ifelse(datos$Complex == "IV", "#008C00",
                      ifelse(datos$Complex == "I", "#EEE000",
                             ifelse(datos$Complex == "III", "#FE33FF",
                                    ifelse(datos$Complex == "V", "#006CFF", "black"))))

# Filtrar las posiciones de los sitios donde aparece el número 1
lineas_separadoras <- datos$Site[datos$Site == 1]

# Crear el gráfico y guardarlo en una variable
grafico <-ggplot(datos, aes(x = Site, y = dN.dS, fill = Color)) +
  geom_bar(stat = "identity", width = 0.5) +
  scale_fill_identity() +  # Usa los colores asignados
  scale_y_continuous(breaks = seq(-3, 3, by = 1), limits = c(-2, 1)) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(size = 8),
    axis.text.y = element_text(size = 6),
    strip.text = element_text(size = 8, face = "bold"),
    panel.spacing = unit(0, "lines")
  ) +
  labs(title = "dN/dS Cyclopoida", x = "Gene", y = "dN/dS") +
  facet_wrap(~ Gene, scales = "free_x", strip.position = "top", nrow = 1) +
  geom_vline(
    xintercept = lineas_separadoras,
    color = "black", linetype = "solid", size = 0.3
  )

# Exportar el gráfico en PDF
ggsave("grafico_dNdS_Cyclopoida.pdf", plot = grafico, width = 10, height = 6, units = "in")

# Exportar el gráfico en formato SVG de alta calidad
ggsave("dNdS_Cyclopoida.svg", plot = grafico, width = 10, height = 6, units = "in", dpi = 300)
