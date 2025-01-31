
###!/bin/bash

##Javier Urban##

#### Step 1 ####
##Removing adapters and quality trimming
trimmomatic-0.39.jar PE Lcarmen.R1.fastq.gz Lcarmen_R2.fastq.gz Lcarmen_read_R1_trimm_paired.fq Lcarmen_read_R1_trimm_unpaired.fq Lcarmen_read_R2_trimm_paired.fq Lcarmen_read_R2_trimm_unpaired.fq ILLUMINACLIP:TruSeq3:2:30:10 SLIDINGWINDOW:5:20

trimmomatic-0.39.jar PE Lpreciosa.R1.fastq.gz Lpreciosa_R2.fastq.gz Lpreciosa_read_R1_trimm_paired.fq Lpreciosa_read_R1_trimm_unpaired.fq Lpreciosa_read_R2_trimm_paired.fq Lpreciosa_read_R2_trimm_unpaired.fq ILLUMINACLIP:TruSeq3:2:30:10 SLIDINGWINDOW:5:20

trimmomatic-0.39.jar PE Lquechulac.R1.fastq.gz Lquechulac_R2.fastq.gz Lquechulac_read_R1_trimm_paired.fq Lquechulac_read_R1_trimm_unpaired.fq Lquechulac_read_R2_trimm_paired.fq Lquechulac_read_R2_trimm_unpaired.fq ILLUMINACLIP:TruSeq3:2:30:10 SLIDINGWINDOW:5:20

##Step 2 ##
##Remapping of the copepod Leptodiaptomus to the de novo mitochondrial genome of the copepod L.Atexcac##
bwa index Latexcac_mito_deNovo.fasta -p Atexcac_mito_deNovo_index

bwa mem -t 28 Atexcac_mito_deNovo_index Lcarmen_read_R1_trimm_paired.fq Lcarmen_read_R2_trimm_paired.fq -o Carmen_toAtexcac_map.sam
samtools view -@ 28 -bS Carmen_toAtexcac_map.sam > Carmen_toAtexcac_map.bam
samtools sort -@ 28 Carmen_toAtexcac_map.bam -o Carmen_toAtexcac_map_sorted.bam

bwa mem -t 28 Atexcac_mito_deNovo_index Lpreciosa_read_R1_trimm_paired.fq Lpreciosa_read_R2_trimm_paired.fq -o Preciosa_toAtexcac_map.sam
samtools view -@ 28 -bS Preciosa_toAtexcac_map.sam > Preciosa_toAtexcac_map.bam
samtools sort -@ 28 Preciosa_toAtexcac_map.bam -o Preciosa_toAtexcac_map_sorted.bam

bwa mem -t 28 Atexcac_mito_deNovo_index Lquechulac_read_R1_trimm_paired.fq Lquechulac_read_R2_trimm_paired.fq -o Quechulac_toAtexcac_map.sam
samtools view -@ 28 -bS Quechulac_toAtexcac_map.sam > Quechulac_toAtexcac_map.bam
samtools sort -@ 28 Quechulac_toAtexcac_map.bam -o Quechulac_toAtexcac_map_sorted.bam

### Step 3 ###
### Recover consensus sequence from remapping for each mitochondrial genome of the copepods leptodiaptomus sicilis-group ###
samtools mpileup -uf Latexcac_mito_deNovo.fasta Carmen_toAtexcac_map_sorted.bam -o Lcarmen_mito_mpileup
bcftools call -c Lcarmen_mito_mpileup | vcfutils.pl vcf2fq > consenso_Lcarmen.fq
seqtk seq -a consenso_Lcarmen.fq > Lcarmen_mito.fasta

samtools mpileup -uf Latexcac_mito_deNovo.fasta Preciosa_toAtexcac_map_sorted.bam -o Lpreciosa_mito_mpileup
bcftools call -c Lpreciosa_mito_mpileup | vcfutils.pl vcf2fq > consenso_Lpreciosa.fq
seqtk seq -a consenso_Lpreciosa.fq > Lpreciosa_mito.fasta

samtools mpileup -uf Latexcac_mito_deNovo.fasta Quechulac_toAtexcac_map_sorted.bam -o Lquechulac_mito_mpileup
bcftools call -c Lquechulac_mito_mpileup | vcfutils.pl vcf2fq > consenso_Lquechulac.fq
seqtk seq -a consenso_Lquechulac.fq > Lquechulac_mito.fasta
