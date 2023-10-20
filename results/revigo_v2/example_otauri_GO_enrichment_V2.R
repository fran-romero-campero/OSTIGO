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
revigo.data <- rbind(c("GO:0005975","carbohydrate metabolic process",5.521546466478484,0.8882456375255497,0.05356926,"carbohydrate metabolic process"),
c("GO:0005976","polysaccharide metabolic process",1.1167319130275588,0.7506130771490015,0.09729857,"polysaccharide metabolic process"),
c("GO:0005982","starch metabolic process",0.017608800701637863,0.789056897783889,0.62602389,"polysaccharide metabolic process"),
c("GO:0005996","monosaccharide metabolic process",0.908795725671516,0.6592727554729668,0.59519536,"polysaccharide metabolic process"),
c("GO:0006096","glycolytic process",0.5384787220228288,0.6574255102553318,0.56314364,"polysaccharide metabolic process"),
c("GO:0016051","carbohydrate biosynthetic process",0.9607174066221332,0.7056043405497033,0.59881341,"polysaccharide metabolic process"),
c("GO:0019318","hexose metabolic process",0.6874284205910277,0.6668193336742358,0.57765858,"polysaccharide metabolic process"),
c("GO:0019685","photosynthesis, dark reaction",0.022531548158839232,0.7383017755204722,0.4245138,"polysaccharide metabolic process"),
c("GO:0044042","glucan metabolic process",0.38687140506388396,0.745301793969277,0.54461487,"polysaccharide metabolic process"),
c("GO:0006091","generation of precursor metabolites and energy",2.62835465282124,0.8806628256914032,0.07412192,"generation of precursor metabolites and energy"),
c("GO:0006720","isoprenoid metabolic process",0.5931910685927647,0.753798352555807,0.08210412,"isoprenoid metabolic process"),
c("GO:0006694","steroid biosynthetic process",0.14729326057246497,0.6757447359000527,0.5060764,"isoprenoid metabolic process"),
c("GO:0008202","steroid metabolic process",0.25984788976451706,0.7085094546492323,0.53200408,"isoprenoid metabolic process"),
c("GO:0008610","lipid biosynthetic process",2.7358634658696603,0.692983576825203,0.67552632,"isoprenoid metabolic process"),
c("GO:0016116","carotenoid metabolic process",0.0650933565793451,0.7528376247391759,0.53112224,"isoprenoid metabolic process"),
c("GO:0007049","cell cycle",1.795399173617054,0.986428176119749,0,"cell cycle"),
c("GO:0015977","carbon fixation",0.05010558628059554,0.9398519569687729,-0,"carbon fixation"),
c("GO:0015979","photosynthesis",0.23078372268274303,0.9051994647733338,0.02155679,"photosynthesis"),
c("GO:0019748","secondary metabolic process",0.40536164365481797,0.9485896403266081,0.02610808,"secondary metabolic process"),
c("GO:0035825","homologous recombination",0.04754110094985078,0.7852471343976113,0.05244879,"homologous recombination"),
c("GO:0006260","DNA replication",1.444034747678592,0.7177106697640387,0.45108594,"homologous recombination"),
c("GO:0006310","DNA recombination",1.6570433606239807,0.7141424523121594,0.6432088,"homologous recombination"),
c("GO:0015994","chlorophyll metabolic process",0.0535648142234938,0.7446937351127708,0.1567224,"homologous recombination"),
c("GO:0018130","heterocycle biosynthetic process",13.771272921376537,0.6571556189693795,0.53496242,"homologous recombination"),
c("GO:0019438","aromatic compound biosynthetic process",13.451580388199883,0.6632552729957413,0.46012145,"homologous recombination"),
c("GO:0033013","tetrapyrrole metabolic process",0.8131480730503791,0.7747602453290247,0.20026218,"homologous recombination"),
c("GO:0072524","pyridine-containing compound metabolic process",0.6882566395888947,0.7836824915556395,0.15524208,"homologous recombination"),
c("GO:1901362","organic cyclic compound biosynthetic process",14.3966447883804,0.6656893970230563,0.27991849,"homologous recombination"),
c("GO:0042440","pigment metabolic process",0.5319993219913232,0.9472849317064019,0.02794033,"pigment metabolic process"),
c("GO:0044550","secondary metabolite biosynthetic process",0.30917182357724615,0.8774643916934507,0.02486707,"secondary metabolite biosynthetic process"),
c("GO:0046148","pigment biosynthetic process",0.49384137683658397,0.9211470127996895,0.02723823,"pigment biosynthetic process"),
c("GO:0050896","response to stimulus",14.674014998147983,1,-0,"response to stimulus"),
c("GO:0051156","glucose 6-phosphate metabolic process",0.23190464558347063,0.7317723496215743,0.07415893,"glucose 6-phosphate metabolic process"),
c("GO:0009141","nucleoside triphosphate metabolic process",0.762872851553353,0.5855122499141426,0.50891058,"glucose 6-phosphate metabolic process"),
c("GO:0009179","purine ribonucleoside diphosphate metabolic process",0.04863208822414945,0.6180586314948868,0.38763943,"glucose 6-phosphate metabolic process"),
c("GO:0046034","ATP metabolic process",0.4379083219444906,0.5674378349209444,0.61742646,"glucose 6-phosphate metabolic process"),
c("GO:0046496","nicotinamide nucleotide metabolic process",0.561705441950962,0.5584821763844585,0.63271009,"glucose 6-phosphate metabolic process"));

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
  example_otauri_GO_enrichment_V2",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

