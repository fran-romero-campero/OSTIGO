# OSTIGO
**Ostreococcus tauri Gene Ontology Annotation Curation**

The functional annotation of genes plays a crucial role in understanding the biological processes and genetic functions of an organism, as it not only identifies, catalogues and names these genes, but also associates them with Gene Ontology terms that describe their roles according to the functions of their products, the processes in which they are involved and the cellular structures in which they occur. In the case of the marine microalgae Ostreococcus tauri, which is unique in research as a model organism because of its extremely compact genome, there is a need to expand its functional annotation as it currently has a very low percentage of annotated genes relative to the total number of genes. This means that the advantages of manipulation in studying it are overshadowed by the lack of rigorous results, as the functions of almost half of its genome are unknown. Therefore, this study focuses on the development of a new functional annotation based on the Gene Ontology, resulting in an improved and enriched version of the previous one, as it offers a significant increase in the number of Gene Ontology terms and annotated genes. As a result, the new version provides a more accurate description of the biological processes and gene functions of the organism, as well as more statistically significant results for its low "p.adjust", reinforcing its quality and relevance for future research. Furthermore, the implications of this study are not only to benefit the understanding of the biology and ecology of this particular organism, but also to provide valuable information on biological processes relevant to a wide range of organisms and to highlight the importance of maintaining an up-to-date Gene Ontology. Thus, improving the functional annotation of Ostreococcus tauri contributes to the advancement of genomics and molecular biology in general.

## Workspace
The work conducted during the OSTIGO project is documented in this GitHub repository. It contains the project code in the "ota_go_annotation.R" file and documents organized by their significance in the research study in the following folders with representative names:

- **annotation**: This folder contains both the previous annotation versions: "ostta_v1_go_annotation.tsv" and the new version "ostta_v2_go_annotation.tsv."

- **gene_data**: This folder houses real datasets of *Ostreococcus tauri*, which were used to validate the improvement in the new annotation compared to the previous one. These datasets are divided into two case studies based on their source of study:
  - Photoperiod Studies:
    - Long photoperiod: "ld_zt0.tsv," "ld_zt4.tsv," "ld_zt8.tsv," "ld_zt12.tsv," "ld_zt16.tsv," "ld_zt20.tsv."
    - Short photoperiod: "sd_zt0.tsv," "sd_zt4.tsv," "sd_zt8.tsv," "sd_zt12.tsv," "sd_zt16.tsv," "sd_zt20.tsv."
  - Iron-deficient Organism: "example_otauri.tsv."

- **kegg_expansion**: In this folder, you will find computational annotation expansion via KEGG pathways for *O. tauri* in the "pathways_ostreococcus_tauri.tsv" file. This file was manually enhanced with GO terms ("pathways_ostreococcus_tauri_go_added.tsv"). Additionally, a programmatic matrix was generated in a format suitable for integration ("ostta_go_annotation_from_kegg_pathways.tsv").

- **manual_expansion**: This folder contains the manual annotation expansion documented in the "gene_expansion.csv" file. This expansion was based on genetic data extracted from the same article as the photoperiod data. This file includes the GO terms associated with genes collected from files such as "1_cell_cycle_gene_ids.tsv," "2_pahtways_doc.pdf," "3_nitrate_assimilation.jpg," "4_carotenoid_metabolic_process.jpg," and "5_photosystem_II.jpg." This file is combined with the previous annotation, creating "ostta_v1.2_go_annotation.tsv."

- old_otauri_package/**org.Otauri.eg.db** and **org.Otauriv2.eg.db**: These folders correspond to packages created from the previous and new annotation versions, respectively.

- **results**: This folder presents the project results, organized into subfolders with descriptive names:
  - **"plots_v1"** and **"plots_v2"** contain the results of barplots, cnetplots, dotplots, and emapplots for each dataset in both case studies. These results were generated using the old and new annotation packages, respectively.
  - **"revigo_v1"** and **"revigo_v2"** hold the results of GO term enrichment, generated using the old and new annotation packages, respectively. For each dataset in both case studies, these results include a functional enrichment treemap created with REVIGO, an R file for generating the graph, a text file with the GO terms of term enrichment, and a dataframe (_df.txt) containing the enrichment table.
  - **tables_figures**: This folder encompasses the results obtained with two barplots showing an increase in the number per ontological category for both GO terms (Figure_1.png) and genes (Figure_2.png). It also contains multipanel figures summarizing results from previous folders for representative datasets in each Case Study I (Figure_3.png) and Case Study II (Figure_4.png). Additionally, there is a representative summary table for the manual expansion ("Table 1.docx").
  - **Supplementary**: The "Supplementary" folder contains high-quality multipanel figures and tables related to both manual and programmatic expansion processes.

