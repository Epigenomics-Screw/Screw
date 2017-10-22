#!/usr/bin/env Rscript

library(optparse)
library(pheatmap)
library(RColorBrewer)

 option_list = list(
    make_option(c("-i", "--pairwiseTable"), action="store",
               type="character", default=NA, help="dataset file name"),
   	make_option(c("-a", "--annotation"), action="store", type="character",
              default=NA, help="Annotation file for coloring heatmap
              margins by label."));

opt_parser<-OptionParser(option_list=option_list);
opt<-parse_args(opt_parser);

pairwiseDistances<-read.table(opt$pairwiseTable, header=TRUE)

if(!is.na(opt$annotation)){
  annotations<-read.table(opt$annotation,row.names=1,header=TRUE)
  colnames(pairwiseDistances) <- annotations[colnames(pairwiseDistances),'cell_name']
  rownames(pairwiseDistances) <- annotations[rownames(pairwiseDistances),'cell_name']
  rownames(annotations) <- annotations$cell_name
}


 
col.pal <- brewer.pal(9,"Blues")
diag(pairwiseDistances)<-0

pdf("pairwise-euc-heatmap.pdf",onefile=FALSE)
if(!is.na(opt$annotation)){
  pheatmap(pairwiseDistances,annotation_col=annotations[,-1],col=col.pal)
} else{
  pheatmap(pairwiseDistances,col=col.pal)
}
dev.off()
