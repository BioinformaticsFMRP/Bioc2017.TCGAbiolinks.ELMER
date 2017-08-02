## ---- echo = FALSE,hide=TRUE, message=FALSE,warning = FALSE--------------
devtools::load_all(".")

## ----vignette, eval=TRUE, message=FALSE,warning = FALSE------------------
library(ELMER)
library(DT)
library(dplyr)

## ----data, eval=TRUE, message=FALSE, warning = FALSE---------------------
library(MultiAssayExperiment)
lusc.exp
lusc.met

## ----distal probes, eval=TRUE, message=FALSE, warning = FALSE------------
distal.probes <- get.feature.probe(genome = "hg38", met.platform = "450K")

## ----mae, eval=TRUE, message=FALSE, warning = FALSE----------------------
library(MultiAssayExperiment)
mae <- createMAE(exp = lusc.exp, 
                 met = lusc.met,
                 save = TRUE,
                 linearize.exp = TRUE,
                 filter.probes = distal.probes,
                 save.filename = "mae_bioc2017.rda",
                 met.platform = "450K",
                 genome = "hg19",
                 TCGA = TRUE)
mae
colData(mae)[1:5,] %>%  as.data.frame %>% datatable(options = list(scrollX = TRUE))
sampleMap(mae)[1:5,] %>%  as.data.frame %>% datatable(options = list(scrollX = TRUE))

## ----eval=TRUE, message=FALSE, warning = FALSE, results = "hide"---------
sig.diff <- get.diff.meth(data = mae, 
                          group.col = "definition",
                          group1 =  "Primary solid Tumor",
                          group2 = "Solid Tissue Normal",
                          minSubgroupFrac = 0.2,
                          sig.dif = 0.3,
                          diff.dir = "hypo", # Search for hypomethylated probes in group 1
                          cores = 1, 
                          dir.out ="result", 
                          pvalue = 0.01)

## ----eval=TRUE, message=FALSE, warning = FALSE---------------------------
as.data.frame(sig.diff)  %>% datatable(options = list(scrollX = TRUE))
# get.diff.meth automatically save output files. 
# getMethdiff.hypo.probes.csv contains statistics for all the probes.
# getMethdiff.hypo.probes.significant.csv contains only the significant probes which
# is the same with sig.diff
dir(path = "result", pattern = "getMethdiff")  

## ---- eval = TRUE, message = FALSE, warning = FALSE, results = "hide"----
nearGenes <- GetNearGenes(data = mae, 
                         probes = sig.diff$probe, 
                         numFlankingGenes = 20, # 10 upstream and 10 dowstream genes
                         cores = 1)

Hypo.pair <- get.pair(data = mae,
                      group.col = "definition",
                      group1 =  "Primary solid Tumor",
                      group2 = "Solid Tissue Normal",
                      nearGenes = nearGenes,
                      minSubgroupFrac = 0.4, # % of samples to use in to create groups U/M
                      permu.dir = "result/permu",
                      permu.size = 100, # Please set to 100000 to get significant results
                      pvalue = 0.05,   
                      Pe = 0.01, # Please set to 0.001 to get significant results
                      filter.probes = TRUE, # See preAssociationProbeFiltering function
                      filter.percentage = 0.05,
                      filter.portion = 0.3,
                      dir.out = "result",
                      cores = 1,
                      label = "hypo")

## ---- eval = TRUE, message = FALSE, warning = FALSE----------------------
Hypo.pair %>% datatable(options = list(scrollX = TRUE))
# get.pair automatically save output files. 
#getPair.hypo.all.pairs.statistic.csv contains statistics for all the probe-gene pairs.
#getPair.hypo.pairs.significant.csv contains only the significant probes which is 
# same with Hypo.pair.
dir(path = "result", pattern = "getPair") 

## ----eval=TRUE, message=FALSE, warning = FALSE---------------------------
# Identify enriched motif for significantly hypomethylated probes which 
# have putative target genes.
enriched.motif <- get.enriched.motif(data = mae,
                                     probes = Hypo.pair$Probe, 
                                     dir.out = "result", 
                                     label = "hypo",
                                     min.incidence = 10,
                                     lower.OR = 1.1)
names(enriched.motif) # enriched motifs
head(enriched.motif["P73_HUMAN.H10MO.A"]) ## probes in the given set that have TP53 motif.

# get.enriched.motif automatically save output files. 
# getMotif.hypo.enriched.motifs.rda contains enriched motifs and the probes with the motif. 
# getMotif.hypo.motif.enrichment.csv contains summary of enriched motifs.
dir(path = "result", pattern = "getMotif") 

motif.enrichment <- read.csv("result/getMotif.hypo.motif.enrichment.csv")
motif.enrichment  %>% datatable(options = list(scrollX = TRUE))


# motif enrichment figure will be automatically generated.
dir(path = "result", pattern = "motif.enrichment.pdf") 

## ----eval=TRUE, message=FALSE, warning = FALSE, results = "hide"---------
## identify regulatory TF for the enriched motifs
TF <- get.TFs(data = mae, 
              group.col = "definition",
              group1 =  "Primary solid Tumor",
              group2 = "Solid Tissue Normal",
              minSubgroupFrac = 0.4,
              enriched.motif = enriched.motif,
              dir.out = "result", 
              cores = 1, 
              label = "hypo")

## ----eval=TRUE, message=FALSE, warning = FALSE---------------------------
TF  %>% datatable(options = list(scrollX = TRUE))

# get.TFs automatically save output files. 
# getTF.hypo.TFs.with.motif.pvalue.rda contains statistics for all TF with average 
# DNA methylation at sites with the enriched motif.
# getTF.hypo.significant.TFs.with.motif.summary.csv contains only the significant probes.
dir(path = "result", pattern = "getTF")  

# TF ranking plot based on statistics will be automatically generated.
dir(path = "result/TFrankPlot_family/", pattern = "pdf") 

## ----sessioninfo, eval=TRUE----------------------------------------------
sessionInfo()

