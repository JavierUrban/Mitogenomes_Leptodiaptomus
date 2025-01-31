###!/bin/bash

##Javier Urban##
#Copepod mitochondrial genome annotation using MitoZ##

mitoz annotate --fastafiles Lgarciai_mito.fasta --thread_number 28 --outprefix reads_Lgarciai_R2_annot_MitZ --genetic_code 5 --clade Arthropoda --fq1 reads_Lgarciai_R1.fastq --fq2 reads_Lgarciai_R2.fastq


mitoz annotate --fastafiles Latexcac_mito.fasta --thread_number 28 --outprefix Latexcac_annot_MitZ --genetic_code 5 --clade Arthropoda --fq1 reads_Latexcac_R1.fastq --fq2 reads_Latexcac_R2.fastq


mitoz annotate --fastafiles Lcarmen_mito.fasta --thread_number 28 --outprefix Lcarmen_annot_MitZ --genetic_code 5 --clade Arthropoda --fq1 reads_Lgarciai_R1.fastq --fq2 reads_Lgarciai_R2.fastq


mitoz annotate --fastafiles Lpreciosa_mito.fasta --thread_number 28 --outprefix Lpreciosa_annot_MitZ --genetic_code 5 --clade Arthropoda --fq1 reads_Lpreciosa_R1.fastq --fq2 reads_Lpreciosa_R2.fastq


mitoz annotate --fastafiles Lquechulac_mito.fasta --thread_number 28 --outprefix Lquechulac_annot_MitZ --genetic_code 5 --clade Arthropoda --fq1 reads_Lquechulac_R1.fastq --fq2 reads_Lquechulac_R2.fastq
