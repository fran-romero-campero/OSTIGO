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
revigo.data <- rbind(c("GO:0005975","carbohydrate metabolic process",5.521546466478484,0.8742569859266451,0.0764469,"carbohydrate metabolic process"),
c("GO:0005976","polysaccharide metabolic process",1.1167319130275588,0.8376127223534895,0.03028312,"polysaccharide metabolic process"),
c("GO:0000271","polysaccharide biosynthetic process",0.5412494305578618,0.7344013557531355,0.56344117,"polysaccharide metabolic process"),
c("GO:0016051","carbohydrate biosynthetic process",0.9607174066221332,0.7214367849227181,0.59881341,"polysaccharide metabolic process"),
c("GO:0016052","carbohydrate catabolic process",1.3222932073535736,0.7299616441336683,0.62049982,"polysaccharide metabolic process"),
c("GO:1901361","organic cyclic compound catabolic process",1.2574559666892315,0.6277343476288427,0.62220898,"polysaccharide metabolic process"),
c("GO:0006091","generation of precursor metabolites and energy",2.62835465282124,0.8497838467424438,0.07412192,"generation of precursor metabolites and energy"),
c("GO:0006720","isoprenoid metabolic process",0.5931910685927647,0.8193353811653724,0.68950433,"generation of precursor metabolites and energy"),
c("GO:0008299","isoprenoid biosynthetic process",0.5122118729218023,0.710050506915917,0.67786632,"generation of precursor metabolites and energy"),
c("GO:0044255","cellular lipid metabolic process",3.2652883239880963,0.7886471612280168,0.10193743,"generation of precursor metabolites and energy"),
c("GO:0015979","photosynthesis",0.23078372268274303,0.8825330189815159,0.02589022,"photosynthesis"),
c("GO:0033013","tetrapyrrole metabolic process",0.8131480730503791,0.7023422658121018,0.08516837,"tetrapyrrole metabolic process"),
c("GO:0006260","DNA replication",1.444034747678592,0.6563530403515909,0.24853208,"tetrapyrrole metabolic process"),
c("GO:0006778","porphyrin-containing compound metabolic process",0.5250476042983834,0.6517350076385483,0.19487473,"tetrapyrrole metabolic process"),
c("GO:0018130","heterocycle biosynthetic process",13.771272921376537,0.560273202971419,0.53496242,"tetrapyrrole metabolic process"),
c("GO:0019438","aromatic compound biosynthetic process",13.451580388199883,0.5615669522899787,0.46012145,"tetrapyrrole metabolic process"),
c("GO:0034654","nucleobase-containing compound biosynthetic process",11.392930641947556,0.45795994797685075,0.56998917,"tetrapyrrole metabolic process"),
c("GO:0072521","purine-containing compound metabolic process",2.595262480894418,0.6623970001625702,0.23166815,"tetrapyrrole metabolic process"),
c("GO:0072522","purine-containing compound biosynthetic process",1.9841965171428693,0.48631193559690494,0.36360986,"tetrapyrrole metabolic process"),
c("GO:0072525","pyridine-containing compound biosynthetic process",0.4155597137249392,0.5988696980479615,0.19044807,"tetrapyrrole metabolic process"),
c("GO:1901362","organic cyclic compound biosynthetic process",14.3966447883804,0.5916905577915714,0.33803542,"tetrapyrrole metabolic process"),
c("GO:0042440","pigment metabolic process",0.5319993219913232,0.9417876082119676,0.02794033,"pigment metabolic process"),
c("GO:0042866","pyruvate biosynthetic process",0.00408122373647708,0.6962797115941017,0.04448907,"pyruvate biosynthetic process"),
c("GO:0006090","pyruvate metabolic process",0.8124529012810852,0.616328392410119,0.53104456,"pyruvate biosynthetic process"),
c("GO:0009132","nucleoside diphosphate metabolic process",0.09319293125396481,0.4612396017549389,0.18740757,"pyruvate biosynthetic process"),
c("GO:0009179","purine ribonucleoside diphosphate metabolic process",0.04863208822414945,0.454059676888059,0.43566137,"pyruvate biosynthetic process"),
c("GO:0032787","monocarboxylic acid metabolic process",2.668208950140285,0.5891647097922399,0.32630237,"pyruvate biosynthetic process"),
c("GO:0034404","nucleobase-containing small molecule biosynthetic process",0.2502452060422601,0.42774222563084063,0.455956,"pyruvate biosynthetic process"),
c("GO:0044270","cellular nitrogen compound catabolic process",1.0342260004087211,0.641191881599907,0.0876631,"cellular nitrogen compound catabolic process"),
c("GO:0009141","nucleoside triphosphate metabolic process",0.762872851553353,0.3733832490137528,0.60533746,"cellular nitrogen compound catabolic process"),
c("GO:0009144","purine nucleoside triphosphate metabolic process",0.5274224973284116,0.3470095463714385,0.6287731,"cellular nitrogen compound catabolic process"),
c("GO:0009156","ribonucleoside monophosphate biosynthetic process",1.014794452675633,0.30973796735580933,0.68595488,"cellular nitrogen compound catabolic process"),
c("GO:0046390","ribose phosphate biosynthetic process",2.0360150864913424,0.385085025449426,0.56121773,"cellular nitrogen compound catabolic process"),
c("GO:0046434","organophosphate catabolic process",0.3828500525802647,0.47868200589218024,0.51963571,"cellular nitrogen compound catabolic process"),
c("GO:0046148","pigment biosynthetic process",0.49384137683658397,0.9206695012798862,0,"pigment biosynthetic process"));

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
  example_otauri_GO_enrichment_V1",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  position.legend = "none"
)

dev.off()

