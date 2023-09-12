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
revigo.data <- rbind(c("GO:0006091","generation of precursor metabolites and energy",2.62835465282124,0.9475798572914379,0.0119405,"generation of precursor metabolites and energy"),
c("GO:0006457","protein folding",1.0590625918025878,0.9848443795841082,0.01047416,"protein folding"),
c("GO:0007017","microtubule-based process",0.8354933550892162,0.9852144483020556,0,"microtubule-based process"),
c("GO:0007264","small GTPase mediated signal transduction",0.33345626897253483,0.9718152449607674,0.00932009,"small GTPase mediated signal transduction"),
c("GO:0009056","catabolic process",6.059177012419161,0.9777752330709065,0.04574167,"catabolic process"),
c("GO:0015980","energy derivation by oxidation of organic compounds",1.3592204656440126,0.8606418265689796,0.09068117,"energy derivation by oxidation of organic compounds"),
c("GO:0016071","mRNA metabolic process",1.3064539347919566,0.9082309414398717,0.09023105,"mRNA metabolic process"),
c("GO:0009057","macromolecule catabolic process",2.3186905544982737,0.8410806044221671,0.14586454,"mRNA metabolic process"),
c("GO:0071025","RNA surveillance",0.016511161065910534,0.8293994903701098,0.43408681,"mRNA metabolic process"),
c("GO:0071027","nuclear RNA surveillance",0.007051503114369526,0.8236671337072319,0.59239411,"mRNA metabolic process"),
c("GO:0016192","vesicle-mediated transport",1.624410201635736,0.7557293406934772,-0,"vesicle-mediated transport"),
c("GO:0006810","transport",18.43241959157694,0.6614307529694372,0.57967313,"vesicle-mediated transport"),
c("GO:0006897","endocytosis",0.33861850144116756,0.7940063357522446,0.28126942,"vesicle-mediated transport"),
c("GO:0033036","macromolecule localization",3.705455122637613,0.731788486975171,0.36615236,"vesicle-mediated transport"),
c("GO:0046907","intracellular transport",2.0388822542670906,0.592414232235443,0.37772848,"vesicle-mediated transport"),
c("GO:0051641","cellular localization",3.7434567372987795,0.7211048071120859,0.41260575,"vesicle-mediated transport"),
c("GO:0071702","organic substance transport",6.066900404037823,0.7110556242480901,0.61057863,"vesicle-mediated transport"),
c("GO:0071705","nitrogen compound transport",4.774462994776034,0.7202803907726223,0.42913564,"vesicle-mediated transport"),
c("GO:0043933","protein-containing complex organization",2.6611873826523444,0.801428996227933,0.01345482,"protein-containing complex organization"),
c("GO:0006334","nucleosome assembly",0.09057190085107651,0.7731144746219818,0.66833899,"protein-containing complex organization"),
c("GO:0022607","cellular component assembly",2.5732697740112993,0.7880267187513516,0.64626874,"protein-containing complex organization"),
c("GO:0034728","nucleosome organization",0.09438037776897892,0.7767530369657097,0.67893359,"protein-containing complex organization"),
c("GO:0065004","protein-DNA complex assembly",0.1970396193359134,0.7624297028529458,0.65956535,"protein-containing complex organization"),
c("GO:0071824","protein-DNA complex organization",1.1399652853171207,0.7591331254183936,0.58131297,"protein-containing complex organization"),
c("GO:0051179","localization",18.792076186036212,1,-0,"localization"),
c("GO:0065007","biological regulation",23.052697479340427,1,-0,"biological regulation"));

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

