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
revigo.data <- rbind(c("GO:0006629","lipid metabolic process",4.558650411488468,0.8782935454374463,0.03428066,"lipid metabolic process"),
c("GO:0008202","steroid metabolic process",0.25984788976451706,0.6995668042373843,0.06249771,"steroid metabolic process"),
c("GO:0006694","steroid biosynthetic process",0.14729326057246497,0.6393403311369804,0.4725869,"steroid metabolic process"),
c("GO:0006720","isoprenoid metabolic process",0.5931910685927647,0.6535472352760123,0.53200408,"steroid metabolic process"),
c("GO:0006721","terpenoid metabolic process",0.3306922127989305,0.6114736217605554,0.61076577,"steroid metabolic process"),
c("GO:0008610","lipid biosynthetic process",2.7358634658696603,0.5599559624668082,0.67552632,"steroid metabolic process"),
c("GO:0010467","gene expression",9.706370753664654,0.8490655656265158,0.0801484,"gene expression"),
c("GO:0009059","macromolecule biosynthetic process",15.258385035486357,0.6902432948475458,0.28055017,"gene expression"),
c("GO:0015979","photosynthesis",0.23078372268274303,0.8924157864314464,0.02544878,"photosynthesis"),
c("GO:0019748","secondary metabolic process",0.40536164365481797,0.9403943492391099,0,"secondary metabolic process"),
c("GO:0042180","cellular ketone metabolic process",0.46003407605618213,0.6942274392467119,0.0628428,"cellular ketone metabolic process"),
c("GO:0006082","organic acid metabolic process",8.895121929802153,0.5803946312268449,0.65731846,"cellular ketone metabolic process"),
c("GO:0019752","carboxylic acid metabolic process",8.61761202044457,0.5364004352047055,0.62971678,"cellular ketone metabolic process"),
c("GO:0043038","amino acid activation",0.9991846865833046,0.5955748318331119,0.59655099,"cellular ketone metabolic process"),
c("GO:0043039","tRNA aminoacylation",0.9985360813440113,0.5503822287084099,0.32055808,"cellular ketone metabolic process"),
c("GO:0044283","small molecule biosynthetic process",6.034460163531009,0.5379601152953619,0.43184243,"cellular ketone metabolic process"),
c("GO:1901661","quinone metabolic process",0.2951552980470796,0.5836231800828139,0.28569676,"cellular ketone metabolic process"),
c("GO:0043603","amide metabolic process",6.518961624921768,0.8842370681765802,0.05064561,"amide metabolic process"),
c("GO:0006518","peptide metabolic process",5.3920715559926595,0.6916848937565164,0.12977678,"amide metabolic process"),
c("GO:0044550","secondary metabolite biosynthetic process",0.30917182357724615,0.8286886250775454,0.02610808,"secondary metabolite biosynthetic process"));

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

