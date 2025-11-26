## Example for functional enrichment based on GO terms
install.packages("./org.Otauriv6.eg.db/", repos=NULL, type = "source")
library(org.Otauriv6.eg.db)
library(clusterProfiler)

gene.set <- read.table(file="example_gene_set.txt",header = F,as.is=T)[[1]]

activated.enrich.go <- enrichGO(gene          = gene.set,
                                OrgDb         = org.Otauriv5.eg.db,
                                ont           = "BP",
                                pAdjustMethod = "BH",
                                pvalueCutoff  = 0.05,
                                readable      = FALSE,
                                keyType = "GID")

## treeplot clustering significant go terms according to semantic similarities
treeplot(pairwise_termsim(activated.enrich.go))
treeplot(pairwise_termsim(activated.enrich.go),cluster.params = list(n = 4))
treeplot(pairwise_termsim(activated.enrich.go),cluster.params = list(n = 3))
treeplot(pairwise_termsim(activated.enrich.go),cluster.params = list(n = 2))

