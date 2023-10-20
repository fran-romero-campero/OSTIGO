# A treemap R script produced by the Revigo server at http://revigo.irb.hr/
# If you found Revigo useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# author: Anton Kratz <anton.kratz@gmail.com>, RIKEN Omics Science Center, Functional Genomics Technology Team, Japan
# created: Fri, Nov 02, 2012  7:25:52 PM
# last change: Fri, Nov 09, 2012  3:20:01 PM

# -----------------------------------------------------------------------------
# If you don't have the treemap package installed, uncomment the following line:
# install.packages( "treemap" );
library(treemap) 								# treemap package by Martijn Tennekes

# Set the working directory if necessary
# setwd("C:/Users/username/workingdir");

# --------------------------------------------------------------------------
# Here is your data from Revigo. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0001522","pseudouridine synthesis",0.33551850101541647,0.6495467509410973,0.03216462,"pseudouridine synthesis"),
c("GO:0006396","RNA processing",4.055292831628201,0.5071703325288706,0.53354483,"pseudouridine synthesis"),
c("GO:0009451","RNA modification",2.050454036972228,0.5786527752565511,0.42056531,"pseudouridine synthesis"),
c("GO:0010467","gene expression",9.706370753664654,0.7766297723204365,0.14717947,"pseudouridine synthesis"),
c("GO:0016070","RNA metabolic process",13.53069692267082,0.5339324329758697,0.60237865,"pseudouridine synthesis"),
c("GO:0016071","mRNA metabolic process",1.3064539347919566,0.6019120431489573,0.34470342,"pseudouridine synthesis"),
c("GO:0016072","rRNA metabolic process",1.1833519865547792,0.5276940839904326,0.394218,"pseudouridine synthesis"),
c("GO:0034660","ncRNA metabolic process",3.769763500568378,0.551328907559517,0.48276415,"pseudouridine synthesis"),
c("GO:0090304","nucleic acid metabolic process",19.07620852119602,0.5578475814247724,0.36747535,"pseudouridine synthesis"),
c("GO:0032259","methylation",3.1286355155207577,0.9362260455833492,0,"methylation"),
c("GO:0043603","amide metabolic process",6.518961624921768,0.8385367586448036,0.0870141,"amide metabolic process"),
c("GO:0006518","peptide metabolic process",5.3920715559926595,0.6778411586424314,0.34821146,"amide metabolic process"),
c("GO:1901566","organonitrogen compound biosynthetic process",14.63667861962968,0.7520781449342735,0.15763417,"amide metabolic process"),
c("GO:0044085","cellular component biogenesis",4.796572117984153,0.7239590455350096,-0,"cellular component biogenesis"),
c("GO:0006334","nucleosome assembly",0.09057190085107651,0.7113307506254574,0.66833899,"cellular component biogenesis"),
c("GO:0034728","nucleosome organization",0.09438037776897892,0.7371230101419786,0.67893359,"cellular component biogenesis"),
c("GO:0042254","ribosome biogenesis",1.6536972228253697,0.691710301985269,0.59874765,"cellular component biogenesis"),
c("GO:0065004","protein-DNA complex assembly",0.1970396193359134,0.6985032677709652,0.65956535,"cellular component biogenesis"),
c("GO:0071824","protein-DNA complex organization",1.1399652853171207,0.7082594314260413,0.56909375,"cellular component biogenesis"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );


# check the tmPlot command documentation for all possible parameters - there are a lot more
treemap(
  stuff,
  index = c("representative","description"),
  vSize = "uniqueness",
  type = "categorical",
  vColor = "representative",
  title = "Revigo TreeMap
  sd_zt12_GO_enrichment_V1",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

