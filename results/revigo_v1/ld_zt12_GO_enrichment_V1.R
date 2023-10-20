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
revigo.data <- rbind(c("GO:0006091","generation of precursor metabolites and energy",2.62835465282124,0.9102261246014218,0,"generation of precursor metabolites and energy"),
c("GO:0006260","DNA replication",1.444034747678592,0.6824670472247882,0.09137804,"DNA replication"),
c("GO:0006259","DNA metabolic process",5.803533415077551,0.7550792220687408,0.48915168,"DNA replication"),
c("GO:0006261","DNA-templated DNA replication",0.5186580111461646,0.6917322126709137,0.5645601,"DNA replication"),
c("GO:0006270","DNA replication initiation",0.12078027409857843,0.7237607031267809,0.69721437,"DNA replication"),
c("GO:0006310","DNA recombination",1.6570433606239807,0.6784610159335688,0.6432088,"DNA replication"),
c("GO:0090304","nucleic acid metabolic process",19.07620852119602,0.7515992339931726,0.37371736,"DNA replication"),
c("GO:0006950","response to stress",4.90663876400189,0.7969561336296764,-0,"response to stress"),
c("GO:0006298","mismatch repair",0.15569186687613623,0.5882452268966835,0.66277719,"response to stress"),
c("GO:0006974","DNA damage response",2.609069457039582,0.7086658477640408,0.49168104,"response to stress"),
c("GO:0051716","cellular response to stimulus",12.016805727629972,0.7570253006817049,0.63796693,"response to stress"),
c("GO:0006996","organelle organization",3.543576559632832,0.8683218448670481,0.01400691,"organelle organization"),
c("GO:0051276","chromosome organization",1.2297688384231882,0.8798190280350966,0.60852115,"organelle organization"),
c("GO:0016192","vesicle-mediated transport",1.624410201635736,0.8865782532505639,-0,"vesicle-mediated transport"),
c("GO:0046907","intracellular transport",2.0388822542670906,0.8293165600186868,0.37826542,"vesicle-mediated transport"),
c("GO:0048193","Golgi vesicle transport",0.41485123723278794,0.8995486946861074,0.28721532,"vesicle-mediated transport"),
c("GO:0051641","cellular localization",3.7434567372987795,0.8597142991486474,0.36665687,"vesicle-mediated transport"),
c("GO:0045333","cellular respiration",1.1686502677974617,0.8585787211547435,0.08898752,"cellular respiration"),
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
  title = "Revigo TreeMap
  ld_zt12_GO_enrichment_V1",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

