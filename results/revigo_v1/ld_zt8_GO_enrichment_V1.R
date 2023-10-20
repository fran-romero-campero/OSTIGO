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
revigo.data <- rbind(c("GO:0005975","carbohydrate metabolic process",5.521546466478484,0.8954917339534234,0.08699302,"carbohydrate metabolic process"),
c("GO:0006090","pyruvate metabolic process",0.8124529012810852,0.8709167813939764,0.06612663,"pyruvate metabolic process"),
c("GO:0006091","generation of precursor metabolites and energy",2.62835465282124,0.8612778358472976,0.08515975,"generation of precursor metabolites and energy"),
c("GO:0008610","lipid biosynthetic process",2.7358634658696603,0.7490077945305923,0.03335442,"lipid biosynthetic process"),
c("GO:0018130","heterocycle biosynthetic process",13.771272921376537,0.6000558226487138,0.53496242,"lipid biosynthetic process"),
c("GO:0019438","aromatic compound biosynthetic process",13.451580388199883,0.6012138357445467,0.46012145,"lipid biosynthetic process"),
c("GO:1901362","organic cyclic compound biosynthetic process",14.3966447883804,0.6317369594799456,0.34414104,"lipid biosynthetic process"),
c("GO:0015979","photosynthesis",0.23078372268274303,0.8917573843795228,0.02606063,"photosynthesis"),
c("GO:0033013","tetrapyrrole metabolic process",0.8131480730503791,0.7331562203888069,0.08516837,"tetrapyrrole metabolic process"),
c("GO:0015994","chlorophyll metabolic process",0.0535648142234938,0.5288324070087119,0.15883951,"tetrapyrrole metabolic process"),
c("GO:0042440","pigment metabolic process",0.5319993219913232,0.938409590680194,0,"pigment metabolic process"),
c("GO:0046148","pigment biosynthetic process",0.49384137683658397,0.840639476886991,0.02794033,"pigment biosynthetic process"));

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
  ld_zt8_GO_enrichment_V1",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)

  position.legend = "none"
)

dev.off()

