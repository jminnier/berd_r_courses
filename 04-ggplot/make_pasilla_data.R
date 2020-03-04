library("pasilla")
pasCts <- system.file("extdata",
                      "pasilla_gene_counts.tsv",
                      package="pasilla", mustWork=TRUE)
pasAnno <- system.file("extdata",
                       "pasilla_sample_annotation.csv",
                       package="pasilla", mustWork=TRUE)
cts <- as.matrix(read.csv(pasCts,sep="\t",row.names="gene_id"))
coldata <- read.csv(pasAnno, row.names=1)
coldata <- coldata[,c("condition","type")]


rownames(coldata) <- sub("fb", "", rownames(coldata))
all(rownames(coldata) %in% colnames(cts))
all(rownames(coldata) == colnames(cts))
cts <- cts[, rownames(coldata)]
all(rownames(coldata) == colnames(cts))

## ----matrixInput---------------------------------------------------------
library("DESeq2")
dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ condition)
dds

## ----addFeatureData------------------------------------------------------
featureData <- data.frame(gene=rownames(cts))
mcols(dds) <- DataFrame(mcols(dds), featureData)
mcols(dds)


## ----prefilter-----------------------------------------------------------
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

## ----factorlvl-----------------------------------------------------------
dds$condition <- factor(dds$condition, levels = c("untreated","treated"))

## ----relevel-------------------------------------------------------------
dds$condition <- relevel(dds$condition, ref = "untreated")

## ----droplevels----------------------------------------------------------
dds$condition <- droplevels(dds$condition)

## ----deseq---------------------------------------------------------------
dds <- DESeq(dds)
res <- results(dds)
res

vsd <- vst(dds, blind=FALSE)
rld <- rlog(dds, blind=FALSE)

vsd = as.data.frame(assay(vsd)) %>% rownames_to_column("gene")

## ----eval=FALSE---------------------------------------------

resultsNames(dds)
resLFC <- lfcShrink(dds, coef="condition_treated_vs_untreated", type="apeglm")
resLFC

## ----parallel, eval=FALSE------------------------------------------------
#  library("BiocParallel")
#  register(MulticoreParam(4))

## ----resOrder------------------------------------------------------------
resOrdered <- res[order(res$pvalue),]

restib <- as.data.frame(res) %>% rownames_to_column("gene") %>% as_tibble


pasilla_data = pasilla_data %>% filter(log10(padj) > -100)
pasilla_data = left_join(pasilla_data,vsd)
write_csv(pasilla_data, path = here::here("04-ggplot","data","gene_expr_pasilla_results.csv"))

