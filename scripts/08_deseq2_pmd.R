##################################################
# Run from: 
# Ceph_sucker/ 
# 
# Example: 
# Rscript scripts/07_deseq2_pmd.R 
##################################################

library(tximport)
library(DESeq2)
library(pheatmap)
library(RColorBrewer)

##################################################
# directories
##################################################

BASE_DIR <- path.expand("~/data/Ses_bulk_RNA-seq_2nd-arm")

SALMON_DIR <- file.path(BASE_DIR, "salmon")

dir.create(
  "Ses/deseq2/pmd",
  recursive=TRUE,
  showWarnings=FALSE
)

##################################################
# sample list
##################################################

samples <- read.table(
  "../metadata/sample_list_pmd.txt",
  stringsAsFactors=FALSE
)$V1

##################################################
# salmon quant files
##################################################
files <- file.path(
  SALMON_DIR,
  samples,
  "quant.sf"
)

names(files) <- samples

txi <- tximport(files, type="salmon", txOut=TRUE)

tx2gene <- data.frame(
  TXNAME = rownames(txi$counts),
  GENEID = rownames(txi$counts)
)

gene_exp <- summarizeToGene(
  txi,
  tx2gene,
  countsFromAbundance="scaledTPM"
)

count <- round(gene_exp$counts)

coldata <- read.table(
  "Ses/metadata/conditions_pmd.tsv",
  header=TRUE,
  row.names=1
)

dds <- DESeqDataSetFromMatrix(
  countData=count,
  colData=coldata,
  design=~condition
)

dds <- dds[rowSums(counts(dds)) >= 10,]

dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds, fitType = c("local"))
dds <- nbinomWaldTest(dds)


##################################################
# D vs P
##################################################

res_DP <- results(dds, contrast=c("condition","D","P"))

write.csv(
  as.data.frame(res_DP[order(res_DP$padj),]),
  "Ses/deseq2/pmd/DESeq2_D_vs_P.csv"
)

deg_DP <- subset(as.data.frame(res_DP), padj < 0.05)

distal_DP <- subset(deg_DP, log2FoldChange > 0)
proximal_DP <- subset(deg_DP, log2FoldChange < 0)

write.table(
  rownames(distal_DP),
  "Ses/deseq2/pmd/distal_DP_genes.txt",
  quote=FALSE,
  row.names=FALSE,
  col.names=FALSE
)

write.table(
  rownames(proximal_DP),
  "Ses/deseq2/pmd/proximal_DP_genes.txt",
  quote=FALSE,
  row.names=FALSE,
  col.names=FALSE
)

##################################################
# M vs P
##################################################

res_MP <- results(dds, contrast=c("condition","M","P"))

write.csv(
  as.data.frame(res_MP[order(res_MP$padj),]),
  "Ses/deseq2/pmd/DESeq2_M_vs_P.csv"
)

deg_MP <- subset(as.data.frame(res_MP), padj < 0.05)

middle_MP <- subset(deg_MP, log2FoldChange > 0)
proximal_MP <- subset(deg_MP, log2FoldChange < 0)

write.table(
  rownames(middle_MP),
  "Ses/deseq2/pmd/middle_MP_genes.txt",
  quote=FALSE,
  row.names=FALSE,
  col.names=FALSE
)

write.table(
  rownames(proximal_MP),
  "Ses/deseq2/pmd/proximal_MP_genes.txt",
  quote=FALSE,
  row.names=FALSE,
  col.names=FALSE
)

##################################################
# D vs M
##################################################

res_DM <- results(dds, contrast=c("condition","D","M"))

write.csv(
  as.data.frame(res_DM[order(res_DM$padj),]),
  "Ses/deseq2/pmd/DESeq2_D_vs_M.csv"
)

deg_DM <- subset(as.data.frame(res_DM), padj < 0.05)

distal_DM <- subset(deg_DM, log2FoldChange > 0)
middle_DM <- subset(deg_DM, log2FoldChange < 0)

write.table(
  rownames(distal_DM),
  "Ses/deseq2/pmd/distal_DM_genes.txt",
  quote=FALSE,
  row.names=FALSE,
  col.names=FALSE
)

write.table(
  rownames(middle_DM),
  "Ses/deseq2/pmd/middle_DM_genes.txt",
  quote=FALSE,
  row.names=FALSE,
  col.names=FALSE
)

##################################################
# clustering analysis
##################################################

# variance stabilizing transformation
vsd <- vst(dds, blind = FALSE)

############################
# sample distance heatmap
############################

sampleDists <- dist(t(assay(vsd)))

sampleDistMatrix <- as.matrix(sampleDists)

rownames(sampleDistMatrix) <- vsd$condition
colnames(sampleDistMatrix) <- vsd$condition

colors <- colorRampPalette(
  rev(brewer.pal(9, "Blues"))
)(255)

png("Ses/deseq2/pmd/pmd_sample_distance_heatmap.png")

pheatmap(
  sampleDistMatrix,
  clustering_distance_rows = sampleDists,
  clustering_distance_cols = sampleDists,
  col = colors
)

dev.off()

############################
# PCA plot
############################

png("Ses/deseq2/pmd/pmd_PCA.png")

plotPCA(
  vsd,
  intgroup = c("condition")
)

dev.off()
