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
revigo.data <- rbind(c("GO:0006950","response to stress",4.90663876400189,0.7776615592012387,-0,"response to stress"),
c("GO:0006298","mismatch repair",0.15569186687613623,0.5471141850604584,0.66277719,"response to stress"),
c("GO:0006974","DNA damage response",2.609069457039582,0.6700281701086955,0.49168104,"response to stress"),
c("GO:0051716","cellular response to stimulus",12.016805727629972,0.7359868808335296,0.63796693,"response to stress"),
c("GO:0007049","cell cycle",1.795399173617054,0.9781662467167223,0,"cell cycle"),
c("GO:0050896","response to stimulus",14.674014998147983,1,-0,"response to stimulus"),
c("GO:0051258","protein polymerization",0.13128435279441755,0.7521708175018378,0.00917386,"protein polymerization"),
c("GO:0006996","organelle organization",3.543576559632832,0.6954556970519845,0.67595103,"protein polymerization"),
c("GO:0022607","cellular component assembly",2.5732697740112993,0.6884577994014976,0.64626874,"protein polymerization"),
c("GO:0043933","protein-containing complex organization",2.6611873826523444,0.704209106303546,0.58680598,"protein polymerization"),
c("GO:0051276","chromosome organization",1.2297688384231882,0.726090646680743,0.42677248,"protein polymerization"),
c("GO:0071840","cellular component organization or biogenesis",9.440442605554349,0.9728246110388036,0.01532138,"cellular component organization or biogenesis"),
c("GO:0072527","pyrimidine-containing compound metabolic process",0.9993809312454497,0.8259368262700395,0.01133261,"pyrimidine-containing compound metabolic process"),
c("GO:0006220","pyrimidine nucleotide metabolic process",0.6361387139761323,0.8165329822918894,0.20290403,"pyrimidine-containing compound metabolic process"),
c("GO:0006259","DNA metabolic process",5.803533415077551,0.7395098295246018,0.27869458,"pyrimidine-containing compound metabolic process"),
c("GO:0006260","DNA replication",1.444034747678592,0.6372142027738956,0.45108594,"pyrimidine-containing compound metabolic process"),
c("GO:0006261","DNA-templated DNA replication",0.5186580111461646,0.6492354245060782,0.5645601,"pyrimidine-containing compound metabolic process"),
c("GO:0006270","DNA replication initiation",0.12078027409857843,0.6836181892387343,0.69721437,"pyrimidine-containing compound metabolic process"),
c("GO:0006310","DNA recombination",1.6570433606239807,0.633041117236428,0.6432088,"pyrimidine-containing compound metabolic process"),
c("GO:0035825","homologous recombination",0.04754110094985078,0.7198675318257983,0.15996597,"pyrimidine-containing compound metabolic process"));

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

