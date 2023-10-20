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
revigo.data <- rbind(c("GO:0015979","photosynthesis",0.23078372268274303,0.9314544323737669,0,"photosynthesis"),
c("GO:0033013","tetrapyrrole metabolic process",0.8131480730503791,0.8060574288854547,0.06613183,"tetrapyrrole metabolic process"),
c("GO:0015994","chlorophyll metabolic process",0.0535648142234938,0.6926936460425912,0.15883951,"tetrapyrrole metabolic process"),
c("GO:0018130","heterocycle biosynthetic process",13.771272921376537,0.7079958086016711,0.53496242,"tetrapyrrole metabolic process"),
c("GO:0019438","aromatic compound biosynthetic process",13.451580388199883,0.709020442673945,0.51068804,"tetrapyrrole metabolic process"),
c("GO:0034654","nucleobase-containing compound biosynthetic process",11.392930641947556,0.6495208031822568,0.46357923,"tetrapyrrole metabolic process"),
c("GO:1901362","organic cyclic compound biosynthetic process",14.3966447883804,0.735117181366536,0.27991849,"tetrapyrrole metabolic process"),
c("GO:0042440","pigment metabolic process",0.5319993219913232,0.9653094483702263,0.02794033,"pigment metabolic process"),
c("GO:0046148","pigment biosynthetic process",0.49384137683658397,0.9095420495884083,0.02589022,"pigment biosynthetic process"),
c("GO:0065007","biological regulation",23.052697479340427,1,-0,"biological regulation"),
c("GO:0065008","regulation of biological quality",1.9965832141230166,0.750347094556404,-0,"regulation of biological quality"),
c("GO:0000160","phosphorelay signal transduction system",2.5024686913261722,0.7160578966053361,0.297072,"regulation of biological quality"),
c("GO:0001505","regulation of neurotransmitter levels",0.053787668331353594,0.8090603611020856,0.19736988,"regulation of biological quality"),
c("GO:0006355","regulation of DNA-templated transcription",9.968929480711344,0.5420664150829672,0.42212773,"regulation of biological quality"),
c("GO:0042133","neurotransmitter metabolic process",0.011847855704426534,0.7807488678148911,0.46299362,"regulation of biological quality"));

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
  sd_zt4_GO_enrichment_V1",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

