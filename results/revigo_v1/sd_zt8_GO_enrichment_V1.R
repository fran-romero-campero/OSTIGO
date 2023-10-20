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
revigo.data <- rbind(c("GO:0006260","DNA replication",1.444034747678592,0.6095519886468798,0.00899011,"DNA replication"),
c("GO:0006259","DNA metabolic process",5.803533415077551,0.7087954859619675,0.48915168,"DNA replication"),
c("GO:0006261","DNA-templated DNA replication",0.5186580111461646,0.6186567359179806,0.5645601,"DNA replication"),
c("GO:0006270","DNA replication initiation",0.12078027409857843,0.6567177785692835,0.69721437,"DNA replication"),
c("GO:0006310","DNA recombination",1.6570433606239807,0.6048509486810942,0.6432088,"DNA replication"),
c("GO:0090304","nucleic acid metabolic process",19.07620852119602,0.7109043232182932,0.37371736,"DNA replication"),
c("GO:0006950","response to stress",4.90663876400189,0.7307888294188564,-0,"response to stress"),
c("GO:0006298","mismatch repair",0.15569186687613623,0.4862863509219364,0.66277719,"response to stress"),
c("GO:0006974","DNA damage response",2.609069457039582,0.6226231700923396,0.49168104,"response to stress"),
c("GO:0051716","cellular response to stimulus",12.016805727629972,0.6856387132128062,0.63796693,"response to stress"),
c("GO:0050896","response to stimulus",14.674014998147983,1,-0,"response to stimulus"),
c("GO:0051258","protein polymerization",0.13128435279441755,0.8336886286173386,0,"protein polymerization"),
c("GO:0006996","organelle organization",3.543576559632832,0.7810759705198248,0.47204875,"protein polymerization"),
c("GO:0051276","chromosome organization",1.2297688384231882,0.7997948204773784,0.60852115,"protein polymerization"),
c("GO:0071840","cellular component organization or biogenesis",9.440442605554349,0.9718394258039251,0.01481564,"cellular component organization or biogenesis"));

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
  sd_zt8_GO_enrichment_V1",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

