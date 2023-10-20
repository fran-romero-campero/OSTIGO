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
revigo.data <- rbind(c("GO:0034660","ncRNA metabolic process",3.769763500568378,0.604525458905403,0,"ncRNA metabolic process"),
c("GO:0006399","tRNA metabolic process",2.5269959479136066,0.5671926905919087,0.49726658,"ncRNA metabolic process"),
c("GO:0009059","macromolecule biosynthetic process",15.258385035486357,0.6118863628394082,0.28055017,"ncRNA metabolic process"),
c("GO:0010467","gene expression",9.706370753664654,0.776728148131238,0.21063862,"ncRNA metabolic process"),
c("GO:0043603","amide metabolic process",6.518961624921768,0.8041039979693494,0.12204631,"ncRNA metabolic process"),
c("GO:0044271","cellular nitrogen compound biosynthetic process",18.93399433857433,0.5375500439215242,0.51204972,"ncRNA metabolic process"),
c("GO:1901566","organonitrogen compound biosynthetic process",14.63667861962968,0.5564037927973396,0.50121883,"ncRNA metabolic process"),
c("GO:0043038","amino acid activation",0.9991846865833046,0.491806094911762,0.09301315,"amino acid activation"),
c("GO:0006082","organic acid metabolic process",8.895121929802153,0.5395618888284117,0.45573237,"amino acid activation"),
c("GO:0006518","peptide metabolic process",5.3920715559926595,0.497810493886054,0.2240164,"amino acid activation"),
c("GO:0009072","aromatic amino acid metabolic process",0.7250308935664747,0.48557536714557065,0.57652081,"amino acid activation"),
c("GO:0019752","carboxylic acid metabolic process",8.61761202044457,0.45427697071787027,0.65731846,"amino acid activation"),
c("GO:0044281","small molecule metabolic process",15.15473791824727,0.880376004845337,0.05705433,"small molecule metabolic process"));

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
  sd_zt16_GO_enrichment_V1",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

