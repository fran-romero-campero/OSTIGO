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
revigo.data <- rbind(c("GO:0034660","ncRNA metabolic process",3.769763500568378,0.4702871438929144,0.0154783,"ncRNA metabolic process"),
c("GO:0006396","RNA processing",4.055292831628201,0.42867913007487374,0.53354483,"ncRNA metabolic process"),
c("GO:0016070","RNA metabolic process",13.53069692267082,0.4888234262580807,0.5079932,"ncRNA metabolic process"),
c("GO:0016072","rRNA metabolic process",1.1833519865547792,0.3636572551276465,0.44836608,"ncRNA metabolic process"),
c("GO:0044085","cellular component biogenesis",4.796572117984153,0.6837959957904567,0,"cellular component biogenesis"),
c("GO:0042254","ribosome biogenesis",1.6536972228253697,0.6207085464217718,0.59874765,"cellular component biogenesis"),
c("GO:0071840","cellular component organization or biogenesis",9.440442605554349,0.967167244357849,0.01811084,"cellular component organization or biogenesis"));

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

