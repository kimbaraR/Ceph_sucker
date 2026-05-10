llibrary(tximport)
library(DESeq2)
library(pheatmap)
library(RColorBrewer)

dir.create("Ses/deseq2/oab", recursive=TRUE, showWarnings=FALSE)

samples <- read.table(
  "Ses/metadata/sample_list_oab.txt",
  stringsAsFactors=FALSE
)$V1

files <- file.path("Ses/salmon", samples, "quant.sf")
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
  "Ses/metadata/conditions_oab.tsv",
  header=TRUE,
  row.names=1
)

dds <- DESeqDataSetFromMatrix(
  countData=count,
  colData=coldata,
  design=~condition
)

dds <- dds[rowSums(counts(dds)) >= 10,]

dds$condition <- relevel(dds$condition, ref="Ab")

dds <- DESeq(dds)

res <- results(dds)

write.csv(
  as.data.frame(res[order(res$padj),]),
  "Ses/deseq2/oab/DESeq2_O_vs_Ab.csv"
)

deg <- subset(as.data.frame(res), padj < 0.05)

oral <- subset(deg, log2FoldChange > 0)
aboral <- subset(deg, log2FoldChange < 0)

write.table(
  rownames(oral),
  "Ses/deseq2/oab/oral_genes.txt",
  quote=FALSE,
  row.names=FALSE,
  col.names=FALSE
)

write.table(
  rownames(aboral),
  "Ses/deseq2/oab/aboral_genes.txt",
  quote=FALSE,
  row.names=FALSE,
  col.names=FALSE
)


############################
# sample distance heatmap
############################

vsd <- vst(dds, blind = FALSE)

sampleDists <- dist(t(assay(vsd)))

sampleDistMatrix <- as.matrix(sampleDists)

rownames(sampleDistMatrix) <- vsd$condition
colnames(sampleDistMatrix) <- vsd$condition

colors <- colorRampPalette(
  rev(brewer.pal(9, "Blues"))
)(255)

png("oab_sample_distance_heatmap.png")

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

png("oab_PCA.png")

plotPCA(
  vsd,
  intgroup = c("condition")
)

dev.off()
