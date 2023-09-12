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
revigo.data <- rbind(c("GO:0005976","polysaccharide metabolic process",1.1167319130275588,0.8356789668239719,0.03028312,"polysaccharide metabolic process"),
c("GO:0005982","starch metabolic process",0.017608800701637863,0.8476736575425892,0.62602389,"polysaccharide metabolic process"),
c("GO:0016051","carbohydrate biosynthetic process",0.9607174066221332,0.7582362681611098,0.59881341,"polysaccharide metabolic process"),
c("GO:0044042","glucan metabolic process",0.38687140506388396,0.8227026039150294,0.54461487,"polysaccharide metabolic process"),
c("GO:0006081","cellular aldehyde metabolic process",0.40854147241771294,0.9259938246061911,0.06219813,"cellular aldehyde metabolic process"),
c("GO:0009605","response to external stimulus",1.9406468330502087,0.9769334783301925,0,"response to external stimulus"),
c("GO:0000160","phosphorelay signal transduction system",2.5024686913261722,0.7567258513861299,0.42922025,"response to external stimulus"),
c("GO:0006355","regulation of DNA-templated transcription",9.968929480711344,0.6257767445153237,0.59915174,"response to external stimulus"),
c("GO:0050794","regulation of cellular process",20.405819326121108,0.7034077034382703,0.44222417,"response to external stimulus"),
c("GO:0015979","photosynthesis",0.23078372268274303,0.9339025601177974,0.02544878,"photosynthesis"),
c("GO:0019748","secondary metabolic process",0.40536164365481797,0.9626457985340486,-0,"secondary metabolic process"),
c("GO:0033013","tetrapyrrole metabolic process",0.8131480730503791,0.8319316384531344,0.0697943,"tetrapyrrole metabolic process"),
c("GO:0015994","chlorophyll metabolic process",0.0535648142234938,0.7517505498660728,0.15883951,"tetrapyrrole metabolic process"),
c("GO:0018130","heterocycle biosynthetic process",13.771272921376537,0.7314024744216058,0.53496242,"tetrapyrrole metabolic process"),
c("GO:0019438","aromatic compound biosynthetic process",13.451580388199883,0.7323184624630674,0.51068804,"tetrapyrrole metabolic process"),
c("GO:0034654","nucleobase-containing compound biosynthetic process",11.392930641947556,0.6833132740847937,0.28073725,"tetrapyrrole metabolic process"),
c("GO:1901362","organic cyclic compound biosynthetic process",14.3966447883804,0.7505610318380251,0.46357923,"tetrapyrrole metabolic process"),
c("GO:0042440","pigment metabolic process",0.5319993219913232,0.9616229340531782,0.02794033,"pigment metabolic process"),
c("GO:0044550","secondary metabolite biosynthetic process",0.30917182357724615,0.8701636297149544,0.02610808,"secondary metabolite biosynthetic process"),
c("GO:0046148","pigment biosynthetic process",0.49384137683658397,0.9209298957811405,0.02723823,"pigment biosynthetic process"),
c("GO:0046487","glyoxylate metabolic process",0.06306771252432103,0.9229153974925806,0.05355166,"glyoxylate metabolic process"),
c("GO:0006544","glycine metabolic process",0.21159498614180067,0.8880497365603954,0.33120701,"glyoxylate metabolic process"),
c("GO:0050896","response to stimulus",14.674014998147983,1,-0,"response to stimulus"));

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

