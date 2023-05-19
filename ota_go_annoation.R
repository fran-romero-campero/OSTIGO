## Load current GO annoation for Ostreococcus tauri
ostta.annoation <- read.table(file="ostta_v3_go_annotation.tsv",header=T,sep="\t")

head(ostta.annoation)
length(unique(ostta.annoation$GID))
length(unique(ostta.annoation$GID))/7668

## Only 4060 genes, 52.9% of the genome is currently annotated
## our goal is to improve this annotation included 
## annotation provided by other researchers
## annotation inferred from KEGG pathways

## Load library to connect to KEGG annotation
library(KEGGREST)

## Get all supported organisms
org <- keggList("organism")
org

## Write file to look for Ostreococcus tauri identifier
write.table(org,file = "organisms_in_kegg.txt")

## Once we have found the identifier for Ostreococcus tauri
## we check the information available
keggList("ota")

## Get the mapping between Ostreococcus genes and pathways
ota.gene.pathways <- keggLink("pathway", "ota")
length(ota.gene.pathways)

## Get all the Ostreococcus pathways
ota.pathways <- unique(ota.gene.pathways)
length(ota.pathways)

## Generate a data frame containing in each row
## the pathway id, pathway description, list of genes
## and a final column filled with NA where the GO
## term will be inputted manually

pathways.df <- data.frame(pathway.id=ota.pathways,
                          pathway.description="",
                          genes="",
                          GO=NA,
                          stringsAsFactors = F)



i <- 1

pathways.df$pathway.id[i]
keggList(pathways.df$pathway.id[i])
strsplit(x = keggList(pathways.df$pathway.id[i]),split = " - ")
strsplit(x = keggList(pathways.df$pathway.id[i]),split = " - ")[[1]][1]

pathways.df$pathway.description[i] <- strsplit(x = keggList(pathways.df$pathway.id[i]),split = " - ")[[1]][1]

ota.gene.pathways
ota.gene.pathways == ota.pathways[i]
which(ota.gene.pathways == ota.pathways[i])
names(which(ota.gene.pathways == ota.pathways[i]))
strsplit(x = names(which(ota.gene.pathways == ota.pathways[i])),split = "_")
genes.in.pathway <- sapply(X = strsplit(x = names(which(ota.gene.pathways == ota.pathways[i])),split = "_"),FUN =  function(x){x[[2]]})
paste(genes.in.pathway,collapse = ",")

pathways.df$genes[i] <- paste(genes.in.pathway,collapse = ",")

head(pathways.df)

for(i in 1:nrow(pathways.df))
{
 print(i)
 ## Save current pathway description
 pathways.df$pathway.description[i] <- strsplit(x = keggList(pathways.df$pathway.id[i]),split = " - ")[[1]][1]
 
 ## Save current pathway genes
 genes.in.pathway <- unlist(sapply(X = strsplit(x = names(which(ota.gene.pathways == ota.pathways[i])),split = "_"),
                            FUN =  function(x){
                             if(length(x) > 1)
                             {
                              return(x[[2]])
                             }
                             }))
 pathways.df$genes[i] <- paste(genes.in.pathway,collapse = ",")
}

head(pathways.df)

write.table(x = pathways.df,file = "pathways_ostreococcus_tauri.tsv",quote = F,sep = "\t",row.names = FALSE)
