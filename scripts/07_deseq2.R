library(tximport)
library(DESeq2)

samples <- read.table("../metadata/sample_list.txt", stringsAsFactors=FALSE)$V1

files <- file.path("../salmon", samples, "quant.sf")
names(files) <- samples

txi <- tximport(files, type="salmon", txOut=TRUE)

tx2gene <- data.frame(
  TXNAME = rownames(txi$counts),
  GENEID = sub("\\..*", "", rownames(txi$counts))
)

gene_exp <- summarizeToGene(txi, tx2gene, countsFromAbundance="scaledTPM")

count <- round(gene_exp$counts)

coldata <- read.table("../metadata/conditions.tsv", header=TRUE, row.names=1)

dds <- DESeqDataSetFromMatrix(countData=count, colData=coldata, design=~condition)
dds <- dds[rowSums(counts(dds)) >= 10,]

dds <- DESeq(dds)

res <- results(dds, contrast=c("condition","D","P"))
write.csv(as.data.frame(res), "DESeq2_D_vs_P.csv")
