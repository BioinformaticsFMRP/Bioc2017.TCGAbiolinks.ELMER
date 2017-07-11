## ----vignette, eval=TRUE, message=FALSE,warning=F------------------------
library(ELMER)
library(DT)
library(dplyr)

## ----mae, eval=FALSE, message=FALSE,warning=F----------------------------
#  library(MultiAssayExperiment)
#  distal.probes <- get.feature.probe(genome = "hg38",
#                                     met.platform = "450K",
#                                     rm.chr = paste0("chr",c(2:22,"X","Y")))
#  mae
#  mae <- createMAE(exp = GeneExp,
#                    met = Meth,
#                    save = FALSE,
#                    linearize.exp = TRUE,
#                    filter.probes = distal.probes,
#                    save.filename = "mae_bioc2017.rda",
#                    met.platform = "450K",
#                    genome = "hg19",
#                    TCGA = TRUE)
#  colData(mae)[1:5,] %>%  as.data.frame %>% datatable(options = list(scrollX = TRUE))

## ----eval=FALSE, message=FALSE-------------------------------------------
#  
#  sig.diff <- get.diff.meth(mae,
#                            group.col = "definition",
#                            group1 =  "Primary solid Tumor",
#                            group2 = "Solid Tissue Normal",
#                            minSubgroupFrac = 0.2,
#                            sig.dif = 0.3,
#                            diff.dir = "hypo", # Search for hypomethylated probes in group 1
#                            cores = 1,
#                            dir.out ="result",
#                            pvalue = 0.01)
#  
#  as.data.frame(sig.diff)  %>% datatable(options = list(scrollX = TRUE))
#  # get.diff.meth automatically save output files.
#  # getMethdiff.hypo.probes.csv contains statistics for all the probes.
#  # getMethdiff.hypo.probes.significant.csv contains only the significant probes which
#  # is the same with sig.diff
#  dir(path = "result", pattern = "getMethdiff")

## ----sessioninfo, eval=TRUE----------------------------------------------
sessionInfo()

