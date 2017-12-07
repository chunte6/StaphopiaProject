#Conducting Linear Regression Based on GWAS

library(staphopia)
library(ggplot2)

MAF <- 0.05

tag <-get_tag_by_name('visa-gwas-2014')
tag

samples <-get_samples_by_tag(6)
head(samples)

vancomycin <- get_resistance(antibiotic = "vancomycin", test="etest")
vancomycin

phenotype=get_resistance_by_samples(samples$sample_id, resistance_id=vancomycin$id)
head(phenotype)