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
revigo.data <- rbind(c("GO:0006629","lipid metabolic process",4.558650411488468,0.8593096066828836,0,"lipid metabolic process"),
c("GO:0006720","isoprenoid metabolic process",0.5931910685927647,0.6788620968879844,0.06877689,"isoprenoid metabolic process"),
c("GO:0008299","isoprenoid biosynthetic process",0.5122118729218023,0.5794006695437847,0.63645805,"isoprenoid metabolic process"),
c("GO:0008610","lipid biosynthetic process",2.7358634658696603,0.5502695092496929,0.67552632,"isoprenoid metabolic process"),
c("GO:0010467","gene expression",9.706370753664654,0.8149223988788472,0.0801484,"gene expression"),
c("GO:0009059","macromolecule biosynthetic process",15.258385035486357,0.6035606327860441,0.28055017,"gene expression"),
c("GO:0044271","cellular nitrogen compound biosynthetic process",18.93399433857433,0.547970024800052,0.51204972,"gene expression"),
c("GO:1901566","organonitrogen compound biosynthetic process",14.63667861962968,0.559380613540079,0.50121883,"gene expression"),
c("GO:0043038","amino acid activation",0.9991846865833046,0.5084367820720026,0.07394572,"amino acid activation"),
c("GO:0006082","organic acid metabolic process",8.895121929802153,0.5326624858104022,0.45573237,"amino acid activation"),
c("GO:0006518","peptide metabolic process",5.3920715559926595,0.5748708057650409,0.2240164,"amino acid activation"),
c("GO:0019752","carboxylic acid metabolic process",8.61761202044457,0.4520217876696829,0.65731846,"amino acid activation"),
c("GO:0043039","tRNA aminoacylation",0.9985360813440113,0.45471420582710625,0.59655099,"amino acid activation"),
c("GO:0044283","small molecule biosynthetic process",6.034460163531009,0.4550697882856759,0.61251244,"amino acid activation"),
c("GO:0043603","amide metabolic process",6.518961624921768,0.8388950773929386,0.09995706,"amide metabolic process"),
c("GO:0044281","small molecule metabolic process",15.15473791824727,0.8846172456044659,0.05923346,"small molecule metabolic process"));

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
  ld_zt4_GO_enrichment_V1",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

