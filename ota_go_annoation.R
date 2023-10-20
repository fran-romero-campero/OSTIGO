## Load current GO annoation for Ostreococcus tauri
ostta_v1_go_annotation <- read.table(file="./annotation/ostta_v1_go_annotation.tsv", header=T, sep="\t")

head(ostta_v1_go_annotation)
length(unique(ostta_v1_go_annotation$GID))
length(unique(ostta_v1_go_annotation$GID))/7668

## Only 4060 genes, 52.9% of the genome is currently annotated
## our goal is to improve this annotation included 
## annotation provided by other researchers
## annotation inferred from KEGG pathways
################################################################################

# Creation of v1.2
# Read the TSV file
# Read the CSV file with semicolon (;) as the delimiter
#ostta_v1_go_annotation <- read.table("./annotation/ostta_v1_go_annotation.tsv", sep = "\t", header = TRUE)
gene_expansion <- read.csv("./manual_expansion/gene_expansion.csv", sep = ";", header = FALSE)

# To combine both dataframes using rbind, they need to have the same format (same column names)
colnames(gene_expansion) <- colnames(ostta_v1_go_annotation)
ostta_v1.2_go_annotation <- rbind(ostta_v1_go_annotation, gene_expansion)

# Get the order of rows based on the first column; first, we need to create the vector
order <- order(ostta_v1.2_go_annotation[, 1])
# Reorder the rows of the dataframe according to the order vector
ostta_v1.2_go_annotation <- ostta_v1.2_go_annotation[order, ]

  # Observe
  # Identify duplicate rows in columns 1 and 2 (genes and GO)
  duplicate_rows <- duplicated(ostta_v1.2_go_annotation[, c(1, 2)]) | duplicated(ostta_v1.2_go_annotation[, c(1, 2)], fromLast = TRUE)
  # Select only the duplicate rows
  duplicate_data <- ostta_v1.2_go_annotation[duplicate_rows, ]
  # View the result
  print(duplicate_data)
  
  # Remove
  # Remove duplicate rows in columns 1 and 2 (genes and GO), leaving one copy
  ostta_v1.2_go_annotation <- unique(ostta_v1.2_go_annotation[, c(1, 2, 3)])
  # Print the result
  print(ostta_v1.2_go_annotation)
  
  # Save the ostta_v1.2_go_annotation dataframe to a TSV file without quotes
  write.table(ostta_v1.2_go_annotation, "./manual_expansion/ostta_v1.2_go_annotation.tsv", sep = "\t", quote = FALSE, row.names = FALSE)


################################################################################
## Load library to connect to KEGG annotation
# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("KEGGREST")
library(KEGGREST)

## Get all supported organisms
org <- keggList("organism")
org

## Write file to look for Ostreococcus tauri identifier
write.table(org,file = "./kegg_expansion/organisms_in_kegg.txt")

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

write.table(x = pathways.df,file = "./kegg_expansion/pathways_ostreococcus_tauri.tsv",quote = F,sep = "\t",row.names = FALSE)

## Now you have to manually associated a GO term to each pathway using 
## for example the web page: http://geneontology.org/ searching only for ontology

## Next we load the pathways in Ostreococcus tauri annotated with GOs
ostta.pathways.go <- read.table(file="./kegg_expansion/pathways_ostreococcus_tauri_go_added.tsv",header=T, sep="\t")
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
write.table(x = ostta.pathway.go.gid.go.evidence, file = "./kegg_expansion/ostta_go_annotation_from_kegg_pathways.tsv",quote = F,sep = "\t",row.names = F)


################################################################################

# Creation of v2
# Read the TSV file
ostta_v1.2_go_annotation <- read.table("./manual_expansion/ostta_v1.2_go_annotation.tsv", sep = "\t", header = TRUE)
ostta_go_annotation_from_kegg_pathways <- read.table("./kegg_expansion/ostta_go_annotation_from_kegg_pathways.tsv", sep = "\t", header = TRUE)

# Merge
ostta_v2_go_annotation <- rbind(ostta_go_annotation_from_kegg_pathways, ostta_v1.2_go_annotation)

# Get the order of rows based on the first column; first, we need to create the vector
order <- order(ostta_v2_go_annotation[, 1])
# Reorder the rows of the dataframe according to the order vector 
ostta_v2_go_annotation <- ostta_v2_go_annotation[order, ]

  # Observe
  # Identify duplicate rows in columns 1 and 2 (genes and GO)
  duplicate_rows <- duplicated(ostta_v2_go_annotation[, c(1, 2)]) | duplicated(ostta_v2_go_annotation[, c(1, 2)], fromLast = TRUE)
  # Select only the duplicate rows
  duplicate_data <- ostta_v2_go_annotation[duplicate_rows, ]
  # View the result
  print(duplicate_data)
  
  # Remove
  # Remove duplicate rows in columns 1 and 2 (genes and GO), leaving one copy
  ostta_v2_go_annotation <- unique(ostta_v2_go_annotation[, c(1, 2, 3)])
  # Print the result (optional)
  print(ostta_v2_go_annotation)
  
  # Save the ostta_v2_go_annotation dataframe to a TSV file without quotes
  write.table(ostta_v2_go_annotation, "./annotation/ostta_v2_go_annotation.tsv", sep = "\t", quote = FALSE, row.names = FALSE)

# Is there any improvement ostta_v2_go_annotation compared to version 1?
ostta.annoation.v2 <- read.table(file="./annotation/ostta_v2_go_annotation.tsv",header=T,sep="\t")

head(ostta.annoation.v2)
length(unique(ostta.annoation.v2$GID))
length(unique(ostta.annoation.v2$GID))/7668 #we see that the annotation has improved around 4%

  # ## Alternative way:
  # ## Now we generate an annotation R package with the updated annotations
  # ostta.manual.annotation <- read.table(file="./manual_expansion/ostta_v1.2_go_annotation.tsv",header=T,sep="\t")
  # head(ostta.manual.annotation)
  # ostta.pathway.go.annotation <- read.table(file="./kegg_expansion/ostta_go_annotation_from_kegg_pathways.tsv",header=T,sep="\t")
  # head(ostta.pathway.go.annotation)
  # 
  # ## We paste together the two annotations
  # ostta.annoation.v2 <- rbind(ostta.manual.annotation,ostta.pathway.go.annotation)
  # nrow(ostta.annoation.v2)
  # 
  # ## We sort the unified annoation according to the gene names
  # genes.sorted <- sort(x = ostta.annoation.v2$GID,decreasing = F,index.return=T)
  # index.genes.sorted <- genes.sorted$ix
  # 
  # ostta.annoation.v2 <- ostta.annoation.v2[index.genes.sorted,]
  # 
  # ## Remove duplicate rows
  # ostta.annoation.v2 <- ostta.annoation.v2[!duplicated(ostta.annoation.v2),]
  # 
  # length(unique(ostta.annoation.v2$GID))/7668 # improvement in the annotation




################################################################################

## We need this package to create our annotation package 
## Before remove the current version in the folder to avoid conflicts
# BiocManager::install("AnnotationForge")
library(AnnotationForge)

# BiocManager::install("GO.db")
library(GO.db)


makeOrgPackage(go=ostta.annoation.v2,
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
# install.packages("./org.Otauriv2.eg.db/", repos=NULL, type = "source")
library(org.Otauriv2.eg.db)


# install.packages("./old_otauri_package/org.Otauri.eg.db/", repos=NULL, type = "source")
library(org.Otauri.eg.db)

## You can remove the package you have created and install the old one and
## check the changes in the annotation
# remove.packages("org.Otauri.eg.db")

################################################################################
# # COMPARISON OF VERSIONS
## Using clusterprofiler, this new package and the gene sets to test enrihcment
## you can test how your annotation improves the previous one. 
# BiocManager::install("clusterProfiler")
library(clusterProfiler)


# # GO IMPROVEMENT
# install.packages("DBI")
library(DBI) #(Data Base Interface)
# Comparison of GO terms for each annotation
  # Extract all GO terms from the old package org.Otauri.eg.db and determine their ontology
  go.1 <- dbGetQuery(dbconn(org.Otauri.eg.db), "select * from go;")
  head(go.1)
  (count_v1 <- table(go.1$ONTOLOGY))
  # Extract all GO terms from the new package org.Otauriv2.eg.db and determine their ontology
  go.2 <- dbGetQuery(dbconn(org.Otauriv2.eg.db), "select * from go;")
  head(go.2)
  (count_v2 <- table(go.2$ONTOLOGY))
    # Barplot
    # install.packages("ggplot2")
    library(ggplot2)
    # install.packages("tidyr")
    library(dplyr)
    # Create a dataframe with the counts
    df <- data.frame(Version = c("v1", "v2"),
                     BP = c(count_v1["BP"], count_v2["BP"]),
                     CC = c(count_v1["CC"], count_v2["CC"]),
                     MF = c(count_v1["MF"], count_v2["MF"]))
    # Convert the dataframe to long (tidy) format for the plot
    library(tidyr)
    df_long <- pivot_longer(df, cols = -Version, names_to = "Ontology", values_to = "NumberOfGO")
    # Create the bar chart
    library(ggplot2)
    ggplot(df_long, 
           aes(x = Ontology, 
               y = NumberOfGO, 
               fill = Version)) + geom_bar(stat = "identity", 
                                           position = "dodge") + labs(x = "Ontology", 
                                                                      y = "Number of GO", 
                                                                      fill = "Version") + ggtitle("Comparison of Number of GO terms per Category and Version") + theme_minimal()

# # GENE IMPROVEMENT
# Compare the total number of genes associated with each ontology GO term (For each ontology, extract GO terms, and for each GO term, extract genes)
  # Create an empty dataframe to store the results
  result_categories <- data.frame(Version = character(0), Category = character(0), Genes = numeric(0))
  
  # Create a vector of versions
  annotation <- c("V1", "V2")
  
  for (version in annotation) {
    # Get data for the current version
    if (version == "V1") {
      go_data <- go.1
      db_conn <- org.Otauri.eg.db
    } else if (version == "V2") {
      go_data <- go.2
      db_conn <- org.Otauriv2.eg.db
    }
    
    # Unique categories
    categories <- sort(unique(go_data$ONTOLOGY)) # Sort the categories; another option would be to directly specify the vector as categories <- c("BP", "CC", "MF")
    
    for (category in categories) {
      # Filter GO terms for the current category
      go_category <- subset(go_data, ONTOLOGY == category)$GO
      genes_category <- character(0)
      
      for (go in go_category) {
        # Get genes for the current GO term
        genes <- unique(AnnotationDbi::select(db_conn, keytype = "GOALL", keys = go, columns = "GID")$GID)
        genes_category <- c(genes_category, genes)
      }
      
      # Count the number of unique genes
      num_genes_category <- length(unique(genes_category))
      
      # Add results to the dataframe
      result_categories <- rbind(result_categories, data.frame(Version = version, Category = category, Genes = num_genes_category))
    }
  }
  
  # Pivot the dataframe to obtain the desired format
  save(result_categories, file= "result_categories.RData")
  load("./result_categories.RData")
  library(reshape2)
  result_categories_df <- dcast(result_categories, Version ~ Category, value.var = "Genes")
  # Print the results dataframe
  print(result_categories_df)
  # Barplot of the data
  library(ggplot2)
  # Convert the dataframe to long (tidy) format for the plot
  library(tidyr)
  result_categories_long <- pivot_longer(result_categories_df, 
                                         cols = -Version, 
                                         names_to = "Category", 
                                         values_to = "NumberGenes")
  
  # Create the bar chart
  ggplot(result_categories_long, aes(x = Category, y = NumberGenes, fill = Version)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(x = "Category", y = "Number of Genes", fill = "Version") +
    ggtitle("Comparison of Number of Genes per Category and Version") +
    theme_minimal()

  
  

# # Enrichment GO terms
# BiocManager::install("enrichplot")
library(enrichplot)
# Define the versions
annotation <- c("V1", "V2")
# Create the folders
dir.create("./results")
dir.create("./results/revigo_v1")
dir.create("./results/revigo_v2")
dir.create("./results/plots_v1")
dir.create("./results/plots_v2")
# Loop to process each version
for (version in annotation) {
  # Set the database based on the version
  if (version == "V1") {
    db_conn <- org.Otauri.eg.db
    revigo_folder <- "./results/revigo_v1"
    plots_folder <- "./results/plots_v1"
  } else if (version == "V2") {
    db_conn <- org.Otauriv2.eg.db
    revigo_folder <- "./results/revigo_v2"
    plots_folder <- "./results/plots_v2"
  }
  
  # This is how we perform enrichment of all gene sets automatically with a for loop
  # Specify the path to the "gene_data" folder
  gene_folder <- "./gene_data/"
  
  # List of names of gene set files
  data_set <- c("example_otauri.tsv", 
                "ld_zt0.tsv", "ld_zt4.tsv", "ld_zt8.tsv", "ld_zt12.tsv", "ld_zt16.tsv", "ld_zt20.tsv",
                "sd_zt0.tsv", "sd_zt4.tsv", "sd_zt8.tsv", "sd_zt12.tsv", "sd_zt16.tsv", "sd_zt20.tsv")
  
  # Loop to load and analyze each gene set
  for (set in data_set) {
    
    # Load the gene set
    current_set <- read.table(file.path(gene_folder, set), header = TRUE, sep = " ")
    
    # Perform the enrichment analysis
    enrichment <- enrichGO(gene = current_set$geneID, 
                           OrgDb = db_conn,
                           ont = "BP", 
                           keyType = "GID")
    
    
    # Print the results
    cat("Results for:", set, "\n")
    print(head(enrichment))
    
    # Create a filename for the result
    set_name <- gsub(".tsv", "", set)
    filename <- paste(set_name, "_GO_enrichment_", version, sep = "")
    
    # Save the enrichment results in a dataframe (SIGNIFICANT INFORMATION FILTER)
    enrichment_df <- as.data.frame(enrichment)
    write.table(enrichment_df, 
                file = file.path(revigo_folder, paste(filename, "_df.txt", sep = "")), 
                sep = "\t", 
                quote = FALSE, 
                row.names = FALSE)
    
    # Extract the GO terms from the result
    GO_result <- enrichment_df$ID
    
    # Write the result to a text file
    write.table(GO_result, 
                file = file.path(revigo_folder, paste(filename, ".txt", sep = "")), 
                quote = FALSE, 
                sep = "\t",
                col.names = FALSE,
                row.names = FALSE)
    
    # Print a completion message for this gene set
    cat("File", filename, "generated.\n")
    
    # Check if enrichment is not empty
    if (!identical(GO_result, character(0))) { #if (nrow(enrichment_df) > 0) #if (nrow(enrichment_df) >= 1)
      # Now we will generate the plots for each gene set using the loop
      # Generate and save the plots with customized titles
      # Create a base filename for the plots

      # Barplot
      pdf(file.path(plots_folder, paste(set_name, "_barplot_", version,".pdf", sep = "")))
      plot(barplot(enrichment, showCategory = 15, title = paste("Barplot ", filename)))
      dev.off()
      
      # Dotplot
      pdf(file.path(plots_folder, paste(set_name, "_dotplot_", version,".pdf", sep = "")))
      plot(dotplot(enrichment, showCategory = 15, title = paste("Dotplot ", filename)))
      dev.off()
      
      # Emapplot
      pdf(file.path(plots_folder, paste(set_name, "_emapplot_", version,".pdf", sep = "")))
      plot(emapplot(pairwise_termsim(enrichment), showCategory = 15, title = paste("Emapplot ", filename))) 
      dev.off()
      
      # Cnetplot
      pdf(file.path(plots_folder, paste(set_name, "_cnetplot_", version,".pdf", sep = "")))
      plot(cnetplot(enrichment, title = paste("Cnetplot ", filename))) 
      dev.off()
      
    } else {
      cat("No graphs generated for:", set, "as enrichment is empty.\n")
    }
  }
}

  


################################################################################
