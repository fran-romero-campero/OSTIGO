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
revigo.data <- rbind(c("GO:0006099","tricarboxylic acid cycle",0.5408768983178572,0.9204131356456686,0.0105796,"tricarboxylic acid cycle"),
c("GO:0006950","response to stress",4.90663876400189,0.7604214100542375,-0,"response to stress"),
c("GO:0006289","nucleotide-excision repair",0.25156237360513284,0.49998075672340864,0.69579504,"response to stress"),
c("GO:0006298","mismatch repair",0.15569186687613623,0.5171403349300674,0.66277719,"response to stress"),
c("GO:0006974","DNA damage response",2.609069457039582,0.6402233556479793,0.49168104,"response to stress"),
c("GO:0051716","cellular response to stimulus",12.016805727629972,0.7228035513454913,0.63796693,"response to stress"),
c("GO:0006996","organelle organization",3.543576559632832,0.8801804283777775,0.01328157,"organelle organization"),
c("GO:0051276","chromosome organization",1.2297688384231882,0.890432685487555,0.60852115,"organelle organization"),
c("GO:0007049","cell cycle",1.795399173617054,0.9823259306350625,0,"cell cycle"),
c("GO:0016192","vesicle-mediated transport",1.624410201635736,0.9771547623721524,-0,"vesicle-mediated transport"),
c("GO:0048193","Golgi vesicle transport",0.41485123723278794,0.9771547623721524,0.28721532,"vesicle-mediated transport"),
c("GO:0044042","glucan metabolic process",0.38687140506388396,0.8549021215085058,0.05244203,"glucan metabolic process"),
c("GO:0005982","starch metabolic process",0.017608800701637863,0.8762086998819543,0.62602389,"glucan metabolic process"),
c("GO:0050896","response to stimulus",14.674014998147983,1,-0,"response to stimulus"),
c("GO:0072527","pyrimidine-containing compound metabolic process",0.9993809312454497,0.8125254924935735,0.07325237,"pyrimidine-containing compound metabolic process"),
c("GO:0006220","pyrimidine nucleotide metabolic process",0.6361387139761323,0.8012034498682957,0.20290403,"pyrimidine-containing compound metabolic process"),
c("GO:0006259","DNA metabolic process",5.803533415077551,0.7106809135811637,0.27869458,"pyrimidine-containing compound metabolic process"),
c("GO:0006260","DNA replication",1.444034747678592,0.6025007028482522,0.45108594,"pyrimidine-containing compound metabolic process"),
c("GO:0006261","DNA-templated DNA replication",0.5186580111461646,0.6178968812487134,0.5645601,"pyrimidine-containing compound metabolic process"),
c("GO:0006270","DNA replication initiation",0.12078027409857843,0.6550475160080856,0.69721437,"pyrimidine-containing compound metabolic process"),
c("GO:0006310","DNA recombination",1.6570433606239807,0.5979907906836992,0.6432088,"pyrimidine-containing compound metabolic process"),
c("GO:0035825","homologous recombination",0.04754110094985078,0.6918081960486577,0.15996597,"pyrimidine-containing compound metabolic process"));

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

