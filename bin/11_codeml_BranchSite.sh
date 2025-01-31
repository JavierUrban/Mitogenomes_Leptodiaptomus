#!/bin/bash

# Lista de genes
genes=("COX1" "COX2" "COX3" "CYTB" "ND1" "ND2" "ND3" "ND4" "ND5" "ND6" "ATP6" "ATP8")

# Ejecutar los comandos en paralelo
# Se cambio de carpeta para editar los alinemaientos de genes correspondientes a cada rama evaluada. 
for gene in "${genes[@]}"; do
    codeml "${gene}_Alt.ctl" &  # Ejecutar en segundo plano
    codeml "${gene}_Null.ctl" & # Ejecutar en segundo plano
done

# Esperar a que todos los procesos en segundo plano finalicen
wait

echo "Ejecución completada para todos los genes."
