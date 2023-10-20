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
revigo.data <- rbind(c("GO:0034660","ncRNA metabolic process",3.769763500568378,0.4225809749347167,0.01324497,"ncRNA metabolic process"),
c("GO:0006396","RNA processing",4.055292831628201,0.38531305771791863,0.53354483,"ncRNA metabolic process"),
c("GO:0006520","amino acid metabolic process",5.465247531707815,0.8121343883836293,0.11856729,"ncRNA metabolic process"),
c("GO:0010467","gene expression",9.706370753664654,0.6944335225202604,0.21063862,"ncRNA metabolic process"),
c("GO:0016070","RNA metabolic process",13.53069692267082,0.41258988795092644,0.60237865,"ncRNA metabolic process"),
c("GO:0016072","rRNA metabolic process",1.1833519865547792,0.34270771619063223,0.44836608,"ncRNA metabolic process"),
c("GO:0090304","nucleic acid metabolic process",19.07620852119602,0.4533831604210497,0.44638538,"ncRNA metabolic process"),
c("GO:0042254","ribosome biogenesis",1.6536972228253697,0.7295024135501199,0,"ribosome biogenesis"));

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
  ld_zt0_GO_enrichment_V1",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

