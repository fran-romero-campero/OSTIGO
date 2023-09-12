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
revigo.data <- rbind(c("GO:0005975","carbohydrate metabolic process",5.521546466478484,0.8804829946475966,0.09441481,"carbohydrate metabolic process"),
c("GO:0006629","lipid metabolic process",4.558650411488468,0.883075353602976,0.03649661,"lipid metabolic process"),
c("GO:0019748","secondary metabolic process",0.40536164365481797,0.9453775320556664,0,"secondary metabolic process"),
c("GO:0043413","macromolecule glycosylation",0.6284419318031838,0.7548811804505264,0.05325524,"macromolecule glycosylation"),
c("GO:0009100","glycoprotein metabolic process",0.6877410815781743,0.7534658867222873,0.11760122,"macromolecule glycosylation"),
c("GO:0016266","O-glycan processing",0.0019291848143086442,0.7066109679125165,0.62191369,"macromolecule glycosylation"),
c("GO:1901137","carbohydrate derivative biosynthetic process",4.616841943085589,0.6635767710353448,0.63815486,"macromolecule glycosylation"),
c("GO:0044255","cellular lipid metabolic process",3.2652883239880963,0.5803827020463179,0.08679617,"cellular lipid metabolic process"),
c("GO:0006720","isoprenoid metabolic process",0.5931910685927647,0.6120455587782601,0.68950433,"cellular lipid metabolic process"),
c("GO:0006721","terpenoid metabolic process",0.3306922127989305,0.5612125367603124,0.64539261,"cellular lipid metabolic process"),
c("GO:0044550","secondary metabolite biosynthetic process",0.30917182357724615,0.8498475602489098,0.02610808,"secondary metabolite biosynthetic process"),
c("GO:0046148","pigment biosynthetic process",0.49384137683658397,0.9443641954649675,0.02723823,"pigment biosynthetic process"),
c("GO:0061611","mannose to fructose-6-phosphate metabolic process",0.00015300431285896144,0.8500649577906986,0.01559323,"mannose to fructose-6-phosphate metabolic process"),
c("GO:0019318","hexose metabolic process",0.6874284205910277,0.7663284631788582,0.50713535,"mannose to fructose-6-phosphate metabolic process"),
c("GO:0032787","monocarboxylic acid metabolic process",2.668208950140285,0.7779938514922143,0.18818748,"mannose to fructose-6-phosphate metabolic process"),
c("GO:0072330","monocarboxylic acid biosynthetic process",0.9938095785489549,0.6935337338609804,0.54403752,"mannose to fructose-6-phosphate metabolic process"),
c("GO:0070085","glycosylation",0.6831509521924055,0.9426149583138421,0.02861889,"glycosylation"),
c("GO:1901135","carbohydrate derivative metabolic process",6.41604626743983,0.897962186681653,0.07446158,"carbohydrate derivative metabolic process"));

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

