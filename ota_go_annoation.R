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


## We illustrate the processing for the first case
i <- 1

pathways.df$pathway.id[i]
keggList(pathways.df$pathway.id[i])

## We split the name of the pathway using - and get the first element
strsplit(x = keggList(pathways.df$pathway.id[i]),split = " - ")
strsplit(x = keggList(pathways.df$pathway.id[i]),split = " - ")[[1]][1]

## We save in the corresponding position the name of the pathway
pathways.df$pathway.description[i] <- strsplit(x = keggList(pathways.df$pathway.id[i]),split = " - ")[[1]][1]

## We get all genes assocaited to ther corresponding pathway
ota.gene.pathways
ota.gene.pathways == ota.pathways[i]
which(ota.gene.pathways == ota.pathways[i])

## To get the correct gene names we split the gene names and keep the second part
names(which(ota.gene.pathways == ota.pathways[i]))
strsplit(x = names(which(ota.gene.pathways == ota.pathways[i])),split = "_")

genes.in.pathway <- unlist(sapply(X = strsplit(x = names(which(ota.gene.pathways == ota.pathways[i])),split = "_"),
                                  FUN =  function(x){
                                   if(length(x) > 1)
                                   {
                                    return(x[[2]])
                                   }
                                  }))


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

## Now you have to manually associated a GO term to each pathway using 
## for example the web page: http://geneontology.org/ searching only for ontology

## Next we load the pathways in Ostreococcus tauri annotated with GOs
ostta.pathways.go <- read.table(file="pathways_ostreococcus_tauri_go_added.tsv",header=T, sep="\t")
head(ostta.pathways.go)

## We keep only pathways annotated with a GO
ostta.pathways.with.go <- subset(ostta.pathways.go, !is.na(GO))

## We generate a data frame with GID, GO and EVIDENCE
ostta.pathway.go.gid.go.evidence <- data.frame(matrix(nrow=14000,ncol=3)) # we generate a very large data frame not all rows will be filled
colnames(ostta.pathway.go.gid.go.evidence) <- c("GID", "GO", "EVIDENCE")
head(ostta.pathway.go.gid.go.evidence)

## We illustrate how to fill this data frame using the first pathway with GO associated

i <- 1 ## Counter to go through pathways
j <- 1 ## Counter to go through the rows of ostta.pathway.go.gid.go.evidence filling it

## We separate genes that were together with commas
current.genes.pathway <- ostta.pathways.with.go[i,3]

current.genes.pathway <- strsplit(current.genes.pathway, split=",")[[1]]

## We repeat the current go for each gene
current.go <- rep(ostta.pathways.with.go[i,4], length(current.genes.pathway))

## We always repeat the ISS evidence
current.evidence <- rep("ISS",length(current.genes.pathway))

## Now we fill the data frame and update the counter j.

## We fill the genes
ostta.pathway.go.gid.go.evidence[j:(j+length(current.genes.pathway)-1),1] <- current.genes.pathway
head(ostta.pathway.go.gid.go.evidence)

## We fill the GO
ostta.pathway.go.gid.go.evidence[j:(j+length(current.genes.pathway)-1),2] <- current.go
head(ostta.pathway.go.gid.go.evidence)

## We fill the GO
ostta.pathway.go.gid.go.evidence[j:(j+length(current.genes.pathway)-1),3] <- current.evidence
head(ostta.pathway.go.gid.go.evidence)

j <- j+length(current.genes.pathway) ## we update the counter to fill the data frame

## Now we do the full loop
j <- 1 #initialize the counter to fill the data frame
for(i in 1:nrow(ostta.pathways.with.go))
{
 ## We separate genes that were together with commas
 current.genes.pathway <- ostta.pathways.with.go[i,3]
 
 current.genes.pathway <- strsplit(current.genes.pathway, split=",")[[1]]
 
 ## We repeat the current go for each gene
 current.go <- rep(ostta.pathways.with.go[i,4], length(current.genes.pathway))
 
 ## We always repeat the ISS evidence
 current.evidence <- rep("ISS",length(current.genes.pathway))
 
 ## Now we fill the data frame and update the counter j.
 ostta.pathway.go.gid.go.evidence[j:(j+length(current.genes.pathway)-1),1] <- current.genes.pathway
 ostta.pathway.go.gid.go.evidence[j:(j+length(current.genes.pathway)-1),2] <- current.go
 ostta.pathway.go.gid.go.evidence[j:(j+length(current.genes.pathway)-1),3] <- current.evidence

 j <- j+length(current.genes.pathway) ## we update the counter to fill the data frame
}

## We only keep the rows with an assignation
ostta.pathway.go.gid.go.evidence <- subset(ostta.pathway.go.gid.go.evidence, !is.na(GID))

## We write the result of this annotation to a file
write.table(x = ostta.pathway.go.gid.go.evidence, file = "ostta_go_annotation_from_kegg_pathways.tsv",quote = F,sep = "\t",row.names = F)








## Now we generate an annotation R package with the updated annotations
ostta.manual.annotation <- read.table(file="ostta_v3_go_annotation.tsv",header=T,sep="\t")
head(ostta.manual.annotation)
ostta.pathway.go.annotation <- read.table(file="ostta_go_annotation_from_kegg_pathways.tsv",header=T,sep="\t")
head(ostta.pathway.go.annotation)

## We paste together the two annotations
ostta.complete.annotation <- rbind(ostta.manual.annotation,ostta.pathway.go.annotation)
nrow(ostta.complete.annotation)

length(unique(ostta.complete.annotation$GID))/7668 # improvement in the annotation

## We sort the unified annoation according to the gene names
genes.sorted <- sort(x = ostta.complete.annotation$GID,decreasing = F,index.return=T)
index.genes.sorted <- genes.sorted$ix

ostta.complete.annotation <- ostta.complete.annotation[index.genes.sorted,]

## Remove duplicate rows
ostta.complete.annotation <- ostta.complete.annotation[!duplicated(ostta.complete.annotation),]

## We need this package to create our annotation package 
## Before remove the current version in the folder to avoid conflicts
BiocManager::install("AnnotationForge")
library(AnnotationForge)

makeOrgPackage(go=ostta.complete.annotation,
               version = "2.1",
               maintainer = "Francisco J. Romero-Campero <fran@us.es>",
               author = "Pedro J. Vega-Asecio",
               outputDir = ".", 
               tax_id = "70448",
               genus = "Ostreococcus",
               species = "tauri",
               goTable = "go",
               verbose = TRUE)

## You can install the package with this command
install.packages("./org.Otauri.eg.db/", repos=NULL)

## Using clusterprofiler, this new package and the gene sets to test enrihcment
## you can test how your annotation improves the previous one. 
library(clusterProfiler)
library(org.Otauri.eg.db)

## You can remove the package you have created and install the old one and
## check the changes in the annotation
remove.packages("org.Otauri.eg.db")