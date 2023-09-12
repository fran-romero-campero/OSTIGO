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
revigo.data <- rbind(c("GO:0034660","ncRNA metabolic process",3.769763500568378,0.6325224786598304,0,"ncRNA metabolic process"),
c("GO:0006082","organic acid metabolic process",8.895121929802153,0.4190600347359752,0.43583618,"ncRNA metabolic process"),
c("GO:0006399","tRNA metabolic process",2.5269959479136066,0.5973658453784567,0.49726658,"ncRNA metabolic process"),
c("GO:0006518","peptide metabolic process",5.3920715559926595,0.5319035554828191,0.12977678,"ncRNA metabolic process"),
c("GO:0009059","macromolecule biosynthetic process",15.258385035486357,0.594926461216639,0.28055017,"ncRNA metabolic process"),
c("GO:0009072","aromatic amino acid metabolic process",0.7250308935664747,0.3799497032309576,0.23883006,"ncRNA metabolic process"),
c("GO:0009073","aromatic amino acid family biosynthetic process",0.5149127316618344,0.3330696894490736,0.5390342,"ncRNA metabolic process"),
c("GO:0010467","gene expression",9.706370753664654,0.7883016570534829,0.21063862,"ncRNA metabolic process"),
c("GO:0043038","amino acid activation",0.9991846865833046,0.379870899612989,0.57652081,"ncRNA metabolic process"),
c("GO:0043603","amide metabolic process",6.518961624921768,0.8242084690793975,0.12204631,"ncRNA metabolic process"),
c("GO:0044283","small molecule biosynthetic process",6.034460163531009,0.4034544718550468,0.61251244,"ncRNA metabolic process"));

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
  title = "Revigo TreeMap",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)

  position.legend = "none"
)

dev.off()

