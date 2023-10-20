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
revigo.data <- rbind(c("GO:0015833","peptide transport",0.3261553023045909,0.6964274538030628,-0,"peptide transport"),
c("GO:0006913","nucleocytoplasmic transport",0.36092054313071836,0.560010314334336,0.30440297,"peptide transport"),
c("GO:0033036","macromolecule localization",3.705455122637613,0.6903241458157326,0.30098522,"peptide transport"),
c("GO:0042886","amide transport",0.39183739287037156,0.6916559645821455,0.51415511,"peptide transport"),
c("GO:0051169","nuclear transport",0.3609238693114327,0.5600099839844022,0.67802652,"peptide transport"),
c("GO:0071702","organic substance transport",6.066900404037823,0.6689469790775321,0.47204183,"peptide transport"),
c("GO:0071705","nitrogen compound transport",4.774462994776034,0.6778742194072473,0.4284447,"peptide transport"),
c("GO:0016071","mRNA metabolic process",1.3064539347919566,0.982106282001515,0,"mRNA metabolic process"),
c("GO:0035556","intracellular signal transduction",3.7944870018179575,0.9418602652279695,0.0128461,"intracellular signal transduction"),
c("GO:0007264","small GTPase mediated signal transduction",0.33345626897253483,0.9464464572981359,0.51359779,"intracellular signal transduction"),
c("GO:0051276","chromosome organization",1.2297688384231882,0.6231197391350012,0.01118932,"chromosome organization"),
c("GO:0006334","nucleosome assembly",0.09057190085107651,0.6090453081270546,0.66833899,"chromosome organization"),
c("GO:0006996","organelle organization",3.543576559632832,0.5975060919774089,0.67595103,"chromosome organization"),
c("GO:0022607","cellular component assembly",2.5732697740112993,0.5886872030121265,0.64626874,"chromosome organization"),
c("GO:0034728","nucleosome organization",0.09438037776897892,0.6144159465030905,0.67893359,"chromosome organization"),
c("GO:0043933","protein-containing complex organization",2.6611873826523444,0.6080639474655009,0.58680598,"chromosome organization"),
c("GO:0065004","protein-DNA complex assembly",0.1970396193359134,0.590082246591204,0.65956535,"chromosome organization"),
c("GO:0071103","DNA conformation change",0.7916476409129807,0.6368296044203838,0.69754761,"chromosome organization"),
c("GO:0071824","protein-DNA complex organization",1.1399652853171207,0.5677405605813344,0.5307363,"chromosome organization"));

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
  ld_zt16_GO_enrichment_V1",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

