## ---- echo = FALSE,hide=TRUE, message=FALSE,warning=FALSE----------------
devtools::load_all(".")

## ----libs, eval=TRUE, message=FALSE,warning=F----------------------------
library(TCGAbiolinks)
library(SummarizedExperiment)
library(DT)
library(dplyr)

## ----tcgabiolinks-exp, eval=FALSE----------------------------------------
#  query.exp <- GDCquery(project = "TCGA-LUSC",
#                    data.category = "Transcriptome Profiling",
#                    data.type = "Gene Expression Quantification",
#                    workflow.type = "HTSeq - FPKM-UQ",
#                     barcode = c("TCGA-34-5231-01","TCGA-77-7138-01"))
#  GDCdownload(query.exp)
#  exp <- GDCprepare(query = query.exp,
#                            save = TRUE,
#                            save.filename = "Exp_LUSC.rda",
#                            summarizedExperiment = TRUE)

## ----tcgabiolinks-exp-obj, eval=TRUE-------------------------------------
exp

colData(exp) %>% as.data.frame %>% datatable(options = list(scrollX = TRUE), rownames = TRUE)
assay(exp)[1:5,] %>% datatable (options = list(scrollX = TRUE), rownames = TRUE)
rowRanges(exp)

## ----tcgabiolinks-met, eval=FALSE----------------------------------------
#  query.met <- GDCquery(project = "TCGA-LUSC",
#                        data.category = "DNA Methylation",
#                        platform = "Illumina Human Methylation 450",
#                        barcode = c("TCGA-34-5231-01A-21D-1818-05","TCGA-77-7138-01A-41D-2043-05"))
#  GDCdownload(query.met)
#  met <- GDCprepare(query = query.met,
#                    save = TRUE,
#                    save.filename = "DNAmethylation_LUSC.rda",
#                    summarizedExperiment = TRUE)

## ----tcgabiolinks-met-obj, eval=TRUE-------------------------------------
met

colData(met) %>% as.data.frame %>% datatable(options = list(scrollX = TRUE), rownames = TRUE)
assay(met)[1:5,] %>% datatable (options = list(scrollX = TRUE), rownames = TRUE)
rowRanges(met)

## ----gui, eval=FALSE, message=FALSE,warning=F----------------------------
#  library(TCGAbiolinksGUI)
#  TCGAbiolinksGUI()

## ----sessioninfo, eval=TRUE----------------------------------------------
sessionInfo()

