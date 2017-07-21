## ----src, eval=FALSE-----------------------------------------------------
#  source("http://bioconductor.org/biocLite.R")
#  useDevel()
#  biocLite("devtools")
#  biocLite("BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER",
#           dependencies = TRUE, build_vignettes = TRUE)

## ----vignette, eval=FALSE------------------------------------------------
#  library("Bioc2017.TCGAbiolinks.ELMER")
#  Biobase::openVignette("Bioc2017.TCGAbiolinks.ELMER")

## ----sessioninfo, eval=TRUE----------------------------------------------
sessionInfo()

