#!/usr/bin/env Rscript

library(rtracklayer)
library(dplyr)
library(reshape)
library(tidyr)
library(GenomicRanges)
library(data.table)
library(LOLA)
library(getopt)

spec <- matrix(c(
  'infile', 'i', 1, "character",
  'outdir'   , 'd', 1, "character",
  'lola.path', 'b', 1, "character",
  'lola.collections', 'c', 1, "character"
), byrow=TRUE, ncol=4)

opt = getopt(spec)
in.file <- opt$infile
out.dir <- opt$outdir
lola.path <- opt$lola.path
lola.collections <- unlist(strsplit(opt$lola.collections, split = ','))

if(is.null(in.file)|is.null(out.dir))
{
  message('Usage: test.R -i input_file -d out_dir -b lola_path -c lola_collections' )
  q(status=1)
}

# Helper functions that allow string arguments for dplyr's data modification functions like arrange, select etc.
# Author: Sebastian Kranz
# Examples are below
#' Modified version of dplyr's filter that uses string arguments
eval.string.dplyr = function(.data, .fun.name, ...) {
  args = list(...)
  args = unlist(args)
  code = paste0(.fun.name,"(.data,", paste0(args, collapse=","), ")")
  df = eval(parse(text=code,srcfile=NULL))
  df
}

#' Average a genome-positional value over genomic features
#' Similar to binnedAverage(), but with more control
#' @param data.grange the data to be averaged (GenomicRanges object)
#' @param feature.grange the features to be averaged over (GenomicRanges)
#' @param value.column name of the column in data.grange to use
#' @param fill.NA if true, will fill in NAs for features not represented in data.grange; if false, will omit these

averageByFeature <- function(feature.grange, data.grange,  value.column, fill.NA=TRUE)
{
  
  # For cases where chromosomes aren't covered, ensure seqlevels are the same:
  subset.features <- subsetByOverlaps(feature.grange, data.grange, type='any', ignore.strand=TRUE)
  seqlevels(subset.features) <- seqlevels(data.grange)
  
  overlaps <- findOverlaps(subset.features, data.grange, type='any', ignore.strand=TRUE)
  overlaps <- as.data.frame(overlaps)
  
  # Add in the scores from data.grange:
  overlaps <- cbind(overlaps, data.grange[overlaps$subjectHits]@elementMetadata[,value.column] )
  
  #Test that there are actually overlapping methylation; some unplaced scaffolds may have no CpGs or something:
  if(nrow(overlaps)==0)
  {
    scored.features <- feature.grange[0]
  }
  else
  {
    colnames(overlaps)[3] <- value.column
    
    by.feature <- group_by(overlaps, queryHits)
    
    #Use dplyr's summarise. Getting dplyr to work with string-named columns is ... painful:
    by.feature.score <- eval.string.dplyr(by.feature, "summarise",
                                          paste("mean.score=mean(",value.column,
                                                "), num.cpgs=length(", value.column, ")", sep=''))
    by.feature.score <- data.frame(by.feature.score)
    
    scored.features <- feature.grange[by.feature.score[,1]]
    scored.features@elementMetadata[[value.column]] <- by.feature.score$mean.score
    scored.features$num.cpgs <- by.feature.score$num.cpgs
  }

  #Add in NAs for missing features:
  all.features <- feature.grange
  elementMetadata(all.features)[[value.column]] <- rep(NA, length(all.features))
  elementMetadata(all.features)[[value.column]] <- as.numeric(elementMetadata(all.features)[[value.column]] )
  
  elementMetadata(all.features[which(all.features %in% subset.features)])[[value.column]] <-
    elementMetadata(scored.features)[[value.column]]
  
  all.features$num.cpgs <- rep(NA, length(all.features))
  all.features$num.cpgs <- as.integer(all.features$num.cpgs)
  all.features[which(all.features %in% subset.features)]$num.cpgs <- scored.features$num.cpgs
  
  if(fill.NA)
  {
    return(all.features)
  }
  else
  {
    return(scored.features)
  }
  
}

averageAllByFeature <- function(feature.grs, cpg.gr, meth.field='score')
{
  #print('Averaging across features')
  
  averaged.meth <- lapply(feature.grs, averageByFeature, cpg.gr, meth.field)
  
  getAverageMethByLib <- function(lib.feature.gr)
    sum(lib.feature.gr$score*lib.feature.gr$num.cpgs, na.rm=TRUE) / sum(lib.feature.gr$num.cpgs, na.rm=TRUE)
  
  getAverageMethBySubset <- function(subset.list)
    sapply(subset.list, getAverageMethByLib)
  
  getAverageMethBySubset(averaged.meth)
}


lola.db <- loadRegionDB(lola.path)
subset.grs <- lola.db$regionGRL[which(lola.db$regionAnno$collection %in% lola.collections)]
names(subset.grs) <- lola.db$regionAnno$description[which(lola.db$regionAnno$collection %in% lola.collections)]

this.cpg.gr <- import(in.file)

#message('Averaging within subsets')
this.subsets.meth <- averageAllByFeature(subset.grs, this.cpg.gr)

write.table(t(this.subsets.meth), 
           file=file.path(out.dir, paste0(gsub('.bw', '.csv',basename(in.file)))),
#            file=file.path(out.dir, paste0(basename(in.file), '.csv')),
            col.names=names(this.subsets.meth),
            row.names=FALSE,
            sep="\t",
            quote=FALSE)





