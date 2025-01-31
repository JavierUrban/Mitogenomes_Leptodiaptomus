###!/bin/bash

##Javier Urban##

### Assembly and annotation pipeline for Leptodiaptomus mitochondrial ###

#### Step 1 ####
##Removing adapters and quality trimming
trimmomatic-0.39.jar PE Lgarciai.R1.fastq.gz Lgarciai_R2.fastq.gz Lgarciai_read_R1_trimm_paired.fq Lgarciai_read_R1_trimm_unpaired.fq Lgarciai_read_R2_trimm_paired.fq Lgarciai_read_R2_trimm_unpaired.fq ILLUMINACLIP:TruSeq3:2:30:10 SLIDINGWINDOW:5:20

trimmomatic-0.39.jar PE Latexcac.R1.fastq.gz Latexcac_R2.fastq.gz Latexcac_read_R1_trimm_paired.fq Latexcac_read_R1_trimm_unpaired.fq Latexcac_read_R2_trimm_paired.fq Latexcac_read_R2_trimm_unpaired.fq ILLUMINACLIP:TruSeq3:2:30:10 SLIDINGWINDOW:5:20


##Mitochondrial reconstruction
### Step 3 ###
##For reference, the mitochondria sequences of 19 copepods available from NCBI were concatenated.

bwa index mitochondrias_copepods.fasta

bwa mem -t 28 mitochondrias_copepods.fasta Lgarciai_read_R1_trimm_paired.fq Lgarciai_read_R2_trimm_paired.fq -o Lgarciai_mapeado.sam

bwa mem -t 28 mitochondrias_copepods.fasta Latexcac_read_R1_trimm_paired.fq Latexcac_read_R2_trimm_paired.fq -o Latexcac_mapeado.sam


##Transform the file with the mitochondria-aligned sequences from the .sam file to .fasta

samtools view -@ 28 -bS Lgarciai_mapeado.sam > Lgarciai_mapeado.bam
samtools sort -@ 28 Lgarciai_mapeado.bam -o Lgarciai_mapeado_sorted.bam
samtools fastq -@ 28 -G 12 -f 65 Lgarciai_mapeado_sorted.bam > Lgarciai_mito_R1.fastq
samtools fastq -@ 28 -G 12 -f 129 Lgarciai_mapeado_sorted.bam > Lgarciai_mito_R2.fastq

samtools view -@ 28 -bS Latexcac_mapeado.sam > Latexcac_mapeado.bam
samtools sort -@ 28 Latexcac_mapeado.bam -o Latexcac_mapeado_sorted.bam
samtools fastq -@ 28 -G 12 -f 65 Latexcac_mapeado_sorted.bam > Latexcac_mito_R1.fastq
samtools fastq -@ 28 -G 12 -f 129 Latexcac_mapeado_sorted.bam > Latexcac_mito_R2.fastq


### Step 3 ###
## Assembly using unicycler L.garciai
unicycler -t 28 -1 Lgarciai_mito_R1.fastq -2 Lgarciai_mito_R1.fastq -o Unicycler_ensamble_Lgarciai


## Recover the mitochondria from the pacbio reads the following commands were used

bwa mem -x pacbio -t 28 mitochondrias_copepods.fasta Latexcac_pacbio.fasta > alin_atexpacbio_mitos.sam
samtools view -@ 28 -bS alin_atexpacbio_mitos.sam > alin_atexpacbio_mitos.bam
samtools sort -@ 28 alin_atexpacbio_mitos.bam -o alin_atexpacbio_mitos_sorted.bam
samtools fasta -@ 28 -F 5 alin_atexpacbio_mitos_sorted.bam > atexcecpacbio_seqsMitocondria.fasta



##### Step 4 #####
## Assembly L.atexcac ##
## using unicycler software ##
unicycler -t 22 -1 L_atexcac_R1.fastq -2 L_atexcac_R2.fastq -l atexcecpacbio_seqsMitocondria.fasta -o ensamble_mito_atexcac_hybrid
