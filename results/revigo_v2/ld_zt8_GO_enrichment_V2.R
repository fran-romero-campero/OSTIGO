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
revigo.data <- rbind(c("GO:0005975","carbohydrate metabolic process",5.521546466478484,0.8932091676289861,0.0764469,"carbohydrate metabolic process"),
c("GO:0005976","polysaccharide metabolic process",1.1167319130275588,0.7587800075131528,0.03592384,"polysaccharide metabolic process"),
c("GO:0005982","starch metabolic process",0.017608800701637863,0.8029912286035685,0.62602389,"polysaccharide metabolic process"),
c("GO:0005996","monosaccharide metabolic process",0.908795725671516,0.6448890164413665,0.59519536,"polysaccharide metabolic process"),
c("GO:0016051","carbohydrate biosynthetic process",0.9607174066221332,0.7078024888315818,0.59881341,"polysaccharide metabolic process"),
c("GO:0016052","carbohydrate catabolic process",1.3222932073535736,0.7553004451581359,0.62049982,"polysaccharide metabolic process"),
c("GO:0019318","hexose metabolic process",0.6874284205910277,0.6528204767070758,0.57765858,"polysaccharide metabolic process"),
c("GO:0019685","photosynthesis, dark reaction",0.022531548158839232,0.749149841660499,0.4245138,"polysaccharide metabolic process"),
c("GO:0044042","glucan metabolic process",0.38687140506388396,0.7624625586236576,0.54461487,"polysaccharide metabolic process"),
c("GO:0006091","generation of precursor metabolites and energy",2.62835465282124,0.886279075097649,0.07412192,"generation of precursor metabolites and energy"),
c("GO:0006720","isoprenoid metabolic process",0.5931910685927647,0.7581816352916443,0.08210412,"isoprenoid metabolic process"),
c("GO:0006694","steroid biosynthetic process",0.14729326057246497,0.6961394351733909,0.5060764,"isoprenoid metabolic process"),
c("GO:0008202","steroid metabolic process",0.25984788976451706,0.7268995522344462,0.53200408,"isoprenoid metabolic process"),
c("GO:0008610","lipid biosynthetic process",2.7358634658696603,0.7014902154306217,0.67552632,"isoprenoid metabolic process"),
c("GO:0016116","carotenoid metabolic process",0.0650933565793451,0.7564671905593555,0.53112224,"isoprenoid metabolic process"),
c("GO:0009605","response to external stimulus",1.9406468330502087,0.9674393211874955,0,"response to external stimulus"),
c("GO:0009991","response to extracellular stimulus",0.4148379325099307,0.9457862854002138,0.34739614,"response to external stimulus"),
c("GO:0031667","response to nutrient levels",0.14280956896955455,0.9409166363568738,0.64232317,"response to external stimulus"),
c("GO:0015977","carbon fixation",0.05010558628059554,0.9420582824852353,-0,"carbon fixation"),
c("GO:0015979","photosynthesis",0.23078372268274303,0.9096811547771229,0.02155679,"photosynthesis"),
c("GO:0019748","secondary metabolic process",0.40536164365481797,0.950369841212275,0.02610808,"secondary metabolic process"),
c("GO:0032787","monocarboxylic acid metabolic process",2.668208950140285,0.7196181502622621,0.09910299,"monocarboxylic acid metabolic process"),
c("GO:0006090","pyruvate metabolic process",0.8124529012810852,0.7399649889639006,0.53104456,"monocarboxylic acid metabolic process"),
c("GO:0033013","tetrapyrrole metabolic process",0.8131480730503791,0.7956226943588663,0.08516837,"tetrapyrrole metabolic process"),
c("GO:0015994","chlorophyll metabolic process",0.0535648142234938,0.760621976865457,0.15883951,"tetrapyrrole metabolic process"),
c("GO:0018130","heterocycle biosynthetic process",13.771272921376537,0.6907149679114278,0.53496242,"tetrapyrrole metabolic process"),
c("GO:0019438","aromatic compound biosynthetic process",13.451580388199883,0.691641326415886,0.46012145,"tetrapyrrole metabolic process"),
c("GO:1901362","organic cyclic compound biosynthetic process",14.3966447883804,0.7004045278375222,0.27991849,"tetrapyrrole metabolic process"),
c("GO:0042440","pigment metabolic process",0.5319993219913232,0.9491075173178705,0.02794033,"pigment metabolic process"),
c("GO:0044550","secondary metabolite biosynthetic process",0.30917182357724615,0.8836898644630451,0.02486707,"secondary metabolite biosynthetic process"),
c("GO:0046148","pigment biosynthetic process",0.49384137683658397,0.9229323105411772,0.02723823,"pigment biosynthetic process"),
c("GO:0051156","glucose 6-phosphate metabolic process",0.23190464558347063,0.7374718270908539,0.07415893,"glucose 6-phosphate metabolic process"),
c("GO:0009132","nucleoside diphosphate metabolic process",0.09319293125396481,0.6514518906357555,0.4069663,"glucose 6-phosphate metabolic process"),
c("GO:0009141","nucleoside triphosphate metabolic process",0.762872851553353,0.5924234486005225,0.53683255,"glucose 6-phosphate metabolic process"),
c("GO:0009179","purine ribonucleoside diphosphate metabolic process",0.04863208822414945,0.6235248250295676,0.43566137,"glucose 6-phosphate metabolic process"),
c("GO:0046034","ATP metabolic process",0.4379083219444906,0.5739031369685629,0.61742646,"glucose 6-phosphate metabolic process"),
c("GO:0046496","nicotinamide nucleotide metabolic process",0.561705441950962,0.5740306544942806,0.63271009,"glucose 6-phosphate metabolic process"));

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
  ld_zt8_GO_enrichment_V2",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

