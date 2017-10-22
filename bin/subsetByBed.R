#!/usr/bin/env Rscript

library(getopt)
library(rtracklayer)
library(data.table)

spec <- matrix(c(
  'infile', 'i', 1, "character",
  'outdir'   , 'd', 1, "character",
  'bedfile', 'b', 1, "character"
), byrow=TRUE, ncol=4)

opt = getopt(spec)
in.file <- opt$infile
out.dir <- file.path(opt$outdir, 'subset')
bed.file <- opt$bedfile

if(is.null(in.file)|is.null(out.dir))
{
  message('Usage: subsetByBed.R -i input_file -b bed_file -o out_dir' )
  q(status=1)
}

cpg.bed <- fread(in.file)
colnames(cpg.bed) <- c('chr', 'start', 'strand', 'type', 'meth_prop', 'cov')
cpg.bed$end <- cpg.bed$start+1
#cpg.bed <- cpg.bed[which(cpg.bed$chr=="chr19_gl000208_random" )]

base.gr <- makeGRangesFromDataFrame(cpg.bed)
elementMetadata(base.gr) <- data.frame(meth_prop=cpg.bed$meth_prop, cov=cpg.bed$cov)

reference.bed <- import.bed(bed.file)
subset.gr <-subsetByOverlaps(base.gr, reference.bed)
subset.frame <- as.data.frame(subset.gr)
  
output.frame <- data.frame(chr=subset.frame$seqnames,
                           start=subset.frame$start,
                           strand=rep("*", nrow(subset.frame)),
                           type=rep("CpG", nrow(subset.frame)),
                           meth_prop=subset.frame$meth_prop,
                           cov=subset.frame$cov)

write.table(output.frame, 
          file=file.path(out.dir, paste0(basename(in.file))),
          col.names=FALSE,
          row.names=FALSE,
          sep="\t",
          quote=FALSE)
  
  
  
