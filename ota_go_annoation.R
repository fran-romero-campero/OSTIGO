## Load current GO annoation for Ostreococcus tauri
ostta_v3_go_annotation <- read.table(file="ostta_v3_go_annotation.tsv", header=T, sep="\t")

head(ostta_v3_go_annotation)
length(unique(ostta_v3_go_annotation$GID))
length(unique(ostta_v3_go_annotation$GID))/7668

## Only 4060 genes, 52.9% of the genome is currently annotated
## our goal is to improve this annotation included 
## annotation provided by other researchers
## annotation inferred from KEGG pathways
################################################################################

# Creation of v4
# Read the TSV file
# Read the CSV file with semicolon (;) as the delimiter
#ostta_v3_go_annotation <- read.table("ostta_v3_go_annotation.tsv", sep = "\t", header = TRUE)
gene_expansion <- read.csv("gene_expansion.csv", sep = ";", header = FALSE)

# To combine both dataframes using rbind, they need to have the same format (same column names)
colnames(gene_expansion) <- colnames(ostta_v3_go_annotation)
ostta_v4_go_annotation <- rbind(ostta_v3_go_annotation, gene_expansion)

# Get the order of rows based on the first column; first, we need to create the vector
order <- order(ostta_v4_go_annotation[, 1])
# Reorder the rows of the dataframe according to the order vector
ostta_v4_go_annotation <- ostta_v4_go_annotation[order, ]

  # Observe
  # Identify duplicate rows in columns 1 and 2 (genes and GO)
  duplicate_rows <- duplicated(ostta_v4_go_annotation[, c(1, 2)]) | duplicated(ostta_v4_go_annotation[, c(1, 2)], fromLast = TRUE)
  # Select only the duplicate rows
  duplicate_data <- ostta_v4_go_annotation[duplicate_rows, ]
  # View the result
  print(duplicate_data)
  
  # Remove
  # Remove duplicate rows in columns 1 and 2 (genes and GO), leaving one copy
  ostta_v4_go_annotation <- unique(ostta_v4_go_annotation[, c(1, 2, 3)])
  # Print the result
  print(ostta_v4_go_annotation)
  
  # Save the ostta_v4_go_annotation dataframe to a TSV file without quotes
  write.table(ostta_v4_go_annotation, "ostta_v4_go_annotation.tsv", sep = "\t", quote = FALSE, row.names = FALSE)


################################################################################
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
################################################################################

# Creation of v5
# Read the TSV file
ostta_v4_go_annotation <- read.table("ostta_v4_go_annotation.tsv", sep = "\t", header = TRUE)
ostta_go_annotation_from_kegg_pathways <- read.table("ostta_go_annotation_from_kegg_pathways.tsv", sep = "\t", header = TRUE)

# Merge
ostta_v5_go_annotation <- rbind(ostta_go_annotation_from_kegg_pathways, ostta_v4_go_annotation)

# Get the order of rows based on the first column; first, we need to create the vector
order <- order(ostta_v5_go_annotation[, 1])
# Reorder the rows of the dataframe according to the order vector 
ostta_v5_go_annotation <- ostta_v5_go_annotation[order, ]

# Observe
# Identify duplicate rows in columns 1 and 2 (genes and GO)
duplicate_rows <- duplicated(ostta_v5_go_annotation[, c(1, 2)]) | duplicated(ostta_v5_go_annotation[, c(1, 2)], fromLast = TRUE)
# Select only the duplicate rows
duplicate_data <- ostta_v5_go_annotation[duplicate_rows, ]
# View the result
print(duplicate_data)

# Remove
# Remove duplicate rows in columns 1 and 2 (genes and GO), leaving one copy
ostta_v5_go_annotation <- unique(ostta_v5_go_annotation[, c(1, 2, 3)])
# Print the result (optional)
print(ostta_v5_go_annotation)

# Save the ostta_v5_go_annotation dataframe to a TSV file without quotes
write.table(ostta_v5_go_annotation, "ostta_v5_go_annotation.tsv", sep = "\t", quote = FALSE, row.names = FALSE)



  # ## Now we generate an annotation R package with the updated annotations
  # ostta.manual.annotation <- read.table(file="ostta_v4_go_annotation.tsv",header=T,sep="\t")
  # head(ostta.manual.annotation)
  # ostta.pathway.go.annotation <- read.table(file="ostta_go_annotation_from_kegg_pathways.tsv",header=T,sep="\t")
  # head(ostta.pathway.go.annotation)
  # 
  # ## We paste together the two annotations
  # ostta.complete.annotation <- rbind(ostta.manual.annotation,ostta.pathway.go.annotation)
  # nrow(ostta.complete.annotation)
  # 
  # ## We sort the unified annoation according to the gene names
  # genes.sorted <- sort(x = ostta.complete.annotation$GID,decreasing = F,index.return=T)
  # index.genes.sorted <- genes.sorted$ix
  # 
  # ostta.complete.annotation <- ostta.complete.annotation[index.genes.sorted,]
  # 
  # ## Remove duplicate rows
  # ostta.complete.annotation <- ostta.complete.annotation[!duplicated(ostta.complete.annotation),]
  # 
  # length(unique(ostta.complete.annotation$GID))/7668 # improvement in the annotation


# Is there any improvement ostta_v5_go_annotation compared to version 3?
ostta.annoation.v5 <- read.table(file="ostta_v5_go_annotation.tsv",header=T,sep="\t")

head(ostta.annoation)
length(unique(ostta.annoation.v5$GID))
length(unique(ostta.annoation.v5$GID))/7668 #we see that the annotation has improved around 4%


################################################################################

## We need this package to create our annotation package 
## Before remove the current version in the folder to avoid conflicts
BiocManager::install("AnnotationForge")
library(AnnotationForge)

BiocManager::install("GO.db")
library(GO.db)


makeOrgPackage(go=ostta.complete.annotation,
               version = "2.1",
               maintainer = "Francisco J. Romero-Campero <fran@us.es>",
               author = "Pedro J. Vega-Asencio",
               outputDir = ".", 
               tax_id = "70448",
               genus = "Ostreococcus",
               species = "tauriv2",
               goTable = "go",
               verbose = TRUE)

## You can install the package with this command
install.packages("./org.Otauriv2.eg.db/", repos=NULL, type = "source")
library(org.Otauriv2.eg.db)


install.packages("./old_otauri_package/org.Otauri.eg.db/", repos=NULL, type = "source")
library(org.Otauri.eg.db)

## Using clusterprofiler, this new package and the gene sets to test enrihcment
## you can test how your annotation improves the previous one. 
BiocManager::install("clusterProfiler")
library(clusterProfiler)

## You can remove the package you have created and install the old one and
## check the changes in the annotation
remove.packages("org.Otauri.eg.db")












################################################################################
#QUEDA: CORREGIR EN EL BUCLE EL ERROR QUE TENGA EL 1X1 
#AÑADIR AL BUBLE LA CREACIÓN DE LOS DEMÁS GRÁFICOS O HACER OTRO BUCLE PARA ELLO

# Enriquecimiento
# Cargar la base de datos de anotación de Ostreococcus tauri 
library(org.Otauri.eg.db)


# # Así podríamos realizar el enriquecimiento de cada conjunto de genes uno por uno:
#   # Leer el conjunto de genes
    ld_zt0 <- read.table("./gene_data/ld_zt0.tsv", header = TRUE, sep = " ")
    
    # Realizar el análisis de enriquecimiento
    enrichresult_ld_zt0 <- enrichGO(gene = ld_zt0$geneID,
                                    OrgDb = org.Otauriv2.eg.db,
                                    ont = "BP",
                                    keyType = "GID") # keytypes(org.Otauri.eg.db)
    # Ver los resultados: 2 fromas
      #1
      head(enrichresult_ld_zt0)
      length(unique(enrichresult_ld_zt0@result$ID)) # debo poner @ en lugar de $
      GO_ld_zt0=enrichresult_ld_zt0@result$ID
      
      #2
      df_enrichresult_ld_zt0=as.data.frame(enrichresult_ld_zt0)
      head(enrichresult_ld_zt0)
      length(unique(df_enrichresult_ld_zt0$ID)) #al pasarlo a data frame se reduce mucho el numero de GO, aunque de todos sale algo menos del ld_zt20, puede que el problema esté en el keytype?
      write.table(df_enrichresult_ld_zt0, file = "enrichresult_ld_zt0.txt", sep = "\t", quote = FALSE, row.names = FALSE)
      GO_ld_zt0=enrichresult_ld_zt0$ID
      
      write.table(GO_ld_zt0, #cual cojo? el del enrich o el df?
                  file = "GO_ld_zt0.tsv",
                  quote = F,
                  sep = "\t",
                  col.names = F,
                  row.names = F)


# Así realizamos el enriquecimiento de todos los conjuntos de genes de forma automatizada con un bucle for
# Especifica la ruta a la carpeta "gene_data"
ruta_genes <- "./gene_data/"

# Lista de nombres de los archivos de conjuntos de genes
archivos_genes <- c("sd_zt20.tsv", "sd_zt16.tsv", "sd_zt12.tsv", 
                    "sd_zt8.tsv", "sd_zt4.tsv", "sd_zt0.tsv", 
                    "ld_zt20.tsv", "ld_zt16.tsv", "ld_zt12.tsv", 
                    "ld_zt8.tsv", "ld_zt4.tsv", "ld_zt0.tsv")

# Bucle para cargar y analizar cada conjunto de genes
for (archivo in archivos_genes) {
  # Construir la ruta completa al archivo
  archivo_completo <- paste0(ruta_genes, archivo)
  
  # Cargar el conjunto de genes
  conjunto_genes <- read.table(archivo_completo, header = TRUE, sep = " ")
  
  # Realizar el análisis de enriquecimiento
  enrich_result <- enrichGO(gene = conjunto_genes$geneID, 
                            OrgDb = org.Otauri.eg.db,
                            ont = "BP", 
                            keyType = "GID")
  # Imprimir los resultados
  print(paste("Resultados para:", archivo))
  print(head(enrich_result))
  
  # Crear un nombre de archivo para el resultado
  nombre_archivo <- paste("GO_", gsub(".tsv", "", archivo), ".txt", sep = "")
  
  # Extraer los términos de GO del resultado
  GO_result <- as.data.frame(enrich_result$ID)
  
  # Escribir el resultado en un archivo de texto
  write.table(GO_result, 
              file = file.path("./results/revigo", nombre_archivo), 
              quote = FALSE, 
              sep = "\t",
              col.names = FALSE,
              row.names = FALSE)
  
  # Imprimir mensaje de finalización para este conjunto de genes
  cat("Archivo", nombre_archivo, "generado.\n")
}








  # # me da problemas este
  # ld_zt20 <- read.table("./gene_data/ld_zt20.tsv", header = TRUE, sep = " ")
  # 
  # # Realizar el análisis de enriquecimiento
  # enrichresult_ld_zt20 <- enrichGO(gene = ld_zt20$geneID, 
  #                                  OrgDb = org.Otauri.eg.db,
  #                                  ont = "BP", 
  #                                  keyType = "GID") # keytypes(org.Otauri.eg.db)
  # # Ver los resultados
  # head(enrichresult_ld_zt20)
  # 
  # enrichresult_ld_zt20=as.data.frame(enrichresult_ld_zt20)
  # GO_ld_zt20=enrichresult_ld_zt20$ID
  # 
  # write.table(GO_ld_zt20, 
  #             file = "GO_ld_zt20.txt", 
  #             quote = F, 
  #             sep = "\t",
  #             col.names = F,
  #             row.names = F)


  # # otro ejemplo interesante
  # example_otauri <- read.table("./gene_data/example_otauri.txt", header = TRUE, sep = " ")
  # 
  # # Realizar el análisis de enriquecimiento
  # enrichresult_example_otauri <- enrichGO(gene = example_otauri$geneID,
  #                                  OrgDb = org.Otauri.eg.db,
  #                                  ont = "BP",
  #                                  keyType = "GID") # keytypes(org.Otauri.eg.db)
  # # Ver los resultados
  # head(enrichresult_example_otauri)
  # 
  # enrichresult_example_otauri=as.data.frame(enrichresult_example_otauri)
  # GO_example_otauri=enrichresult_example_otauri$ID
  # 
  # write.table(GO_example_otauri,
  #             file = "GO_example_otauri.txt",
  #             quote = F,
  #             sep = "\t",
  #             col.names = F,
  #             row.names = F)






