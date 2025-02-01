###SCRIPT for phylogenetic ANOVA with phylANOVA (phytools 2.0, Revell 2024)

library(ape)
library(maps)
library(phytools)
library(phytools)
library(ggplot2)

tree_text <- "(((Calanus_simillimus:0.075283,Calanus_hyperboreus:0.065377)#1:0.136647,(((Leptodiaptomus_atexcac:0.003351,Leptodiaptomus_garciai:0.082465)#1:0.072005,Phyllodiaptomus_tunguidus:0.117430)#1:0.099839,(Labidocera_rotunda:0.101809,Eurytemora_affinis:0.130146)#1:0.141372)#1:0.037792)#1:0.165322,((((Sinergasilus_major:0.027447,Sinergasilus_polycolpus:0.029260)#1:0.018197,Sinergasilus_undulatus:0.039366)#1:0.397156,(((Lamproglena_orientalis:0.276990,Lamproglena_chinensis:0.384525)#1:0.087225,Lernaea_cyprinacea:0.423074)#1:0.344239,Paracyclopina_nana:0.523318)#1:0.057420)#1:0.057785,((((Tigriopus_japonicus:0.135573,Tigriopus_californicus:0.180460)#1:0.439000,Tigriopus_kingsejongensis:0.455117)#1:0.305369,Amphiascoides_atopus:0.459528)#1:0.064554,(Pennella_sp:0.466439,(Lepeophtheirus_salmonis:0.482343,Pandarus_rhincodonicus:0.246261)#1:0.505184)#1:0.380097)#1:0.028682)#1:0.082451);"

phylo_tree <- read.tree(text = tree_text)

# Creating data.frame with species and qMGR scores by group (Order) as factor

dataporcent <- data.frame(
  species = c("Calanus_simillimus", "Calanus_hyperboreus", "Leptodiaptomus_atexcac",
              "Leptodiaptomus_garciai", "Phyllodiaptomus_tunguidus", "Labidocera_rotunda",
              "Eurytemora_affinis", "Sinergasilus_major", "Sinergasilus_polycolpus",
              "Sinergasilus_undulatus", "Lamproglena_orientalis", "Lamproglena_chinensis",
              "Lernaea_cyprinacea", "Paracyclopina_nana", "Tigriopus_japonicus",
              "Tigriopus_californicus", "Tigriopus_kingsejongensis", "Amphiascoides_atopus",
              "Pennella_sp", "Lepeophtheirus_salmonis", "Pandarus_rhincodonicus"),
 porcent=c(94.6,94.6,94.6,94.6,94.6,97.3,94.6,100.0,100.0,100.0,97.3,97.3,94.6,97.3,97.3,97.3,100.0,100.0,100.0,98.6,100.0),
  group = factor(c("Calanoida", "Calanoida", "Calanoida",
                   "Calanoida", "Calanoida", "Calanoida", "Calanoida", "Cyclopoida", "Cyclopoida",
                   "Cyclopoida", "Cyclopoida", "Cyclopoida", "Cyclopoida", "Cyclopoida", "Harpacticoida",
                   "Harpacticoida", "Harpacticoida", "Harpacticoida", "Siphonostomatoida", "Siphonostomatoida", "Siphonostomatoida"))
)


result <- phylANOVA(tree = phylo_tree, x = dataporcent$group, y = dataporcent$porcent, nsim = 1000)
print(result)
