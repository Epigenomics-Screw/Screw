#!/usr/bin/env Rscript

rm(list = ls())

library(knitr)
library(optparse)
library(rmarkdown)

setwd(getwd())

option_list = list(
  make_option(c("-g", "--genome_build"), action="store",
              type="character", default="hg19", help="The name of the genome build e.g. hg19"),
  make_option(c("-a", "--annotation"), action="store", type="character",
              default=NA, help="A file containing gene models (GFF, GTF, GFF2, GFF3)
              This must be compatible with Gviz's GeneRegionTrack function."),
  make_option(c("-t", "--targets_bed", action="store", type="character",
                default="test_metadata/example_dmrs.bed",
                help="A BED file containing locations of interest. These regions inform the Gviz plots.")),
  make_option(c("-c", "--cpg_bed", action="store", type="character",
                default="hg19_CpG.bed", help="A BED file containing annotated CpG islands")),
  make_option(c("-b", "--BigWig", action="store", type="character",
                help="A BigWig file containing data which are to be included in the figures")));

opt_parser <- OptionParser(option_list=option_list, add_help_option = TRUE,
                           usage = "./Region_methylation_wrapper.R -g build -a annot.gff -t targets.bed -c cpg.bed -b file.bw")
opt <- parse_args(opt_parser)

if (length(opt) < 5) {
  print("Error: insufficient number of arguments provided!")
  print_help(opt_parser)
  quit()
}

if (is.na(opt$annotation)) {
  print("Error: Annotation not provided!")
  quit()
}

opt_files <- c(opt$annotation, opt$targets_bed, opt$cpg_bed, opt$BigWig)
for (input_file in opt_files) {
  if (file.exists(input_file) == FALSE) {
    print(paste("Error:", input_file, "does not exist!"))
    quit()
  }
}

rmarkdown::render("bin/Methylation_gviz.Rmd",
                  output_format="html_document",
                  params = list(genome_build = opt$genome_build,
                                annotation = opt$annotation,
                                BigWig = opt$BigWig,
                                targets_bed = opt$targets_bed,
                                cpg_bed = opt$cpg_bed),
                  envir = new.env())
