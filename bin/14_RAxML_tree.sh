###!/bin/bash

##Javier Urban##
##ModelTest-NG

modeltest-ng -d aa -i ../data/Conca_13G_AA_CluW_BlocksTodo_PartFind.phy -p 28 -q ../data/Partitions_AA13GB.nex -t ml -r 5678432890 -T raxml -o ModelTes_AA_Conca13GBlocks

##RAxML-NG
raxml-ng --all --msa ../data/Conca_13G_AA_CluW_BlocksTodo_PartFind.phy --model ../results/ModelTes_AA_Conca13GBlocks.part.aic --tree pars{15} --threads 18 --data-type AA --prefix RaxML_13GenAA_Best --bs-metric fbp,tbe
