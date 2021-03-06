### boxplot benchmark

require(ggplot2)
require(grid)
require(gridExtra)
library("reshape")
library("cowplot")
library("scales")
source("~/Uniquorn_rna_panel_project/Scripts/calculations_vis.R")
library("ggcorrplot")
library(ggplot2)
library(scales) # for muted function

colnames( benchmark_Sensitivity )  = c("Weight","Value","Seq_Type")
colnames( benchmark_F1 )  = c("Weight","Value","Seq_Type")
colnames( benchmark_PPV )  = c("Weight","Value","Seq_Type")

m_bench = as.data.frame( rbind(
  benchmark_Sensitivity,
  benchmark_F1,
  benchmark_PPV
))
m_bench$Parameter = c( rep("Sensitivity", nrow(benchmark_F1) ), rep("F1", nrow(benchmark_F1)), rep("PPV", nrow(benchmark_PPV) ) ) 
m_bench$Weight = as.character(m_bench$Weight)
m_bench$Seq_Type = as.character(m_bench$Seq_Type)
m_bench$Parameter = factor(m_bench$Parameter, levels = c("Sensitivity","F1","PPV"))
m_bench$Seq_Type = factor(m_bench$Seq_Type, levels = c("AVG","RNA","TruSight","ClearSight","Hotspot_v2"))
m_bench = m_bench[m_bench$Weight == "0.5",]
m_bench

# merged

g_bench = ggplot(
    data = ref_counts,
    aes( x = Library, y = log2(as.double(ref_counts$Count)), fill = Library)
)
g_bench = g_bench + geom_boxplot(size=1)
#g_bench = g_bench + theme(legend.position="top", legend.background = element_rect(fill="gray90", size =5 )  )
g_bench

g_bench + geom_segment(
  aes( x = 4.8,xend = 5,y = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "Hotspot_v2") )[4],2], 
  yend = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "Hotspot_v2") )[4],2]), size = 1.5)


# Sensitivity

g_sens = ggplot( data = benchmark_Sensitivity, aes( x = Seq_Type, y = Sensitivity))
g_sens = g_sens + geom_boxplot(aes(colour = Weight),size=1)
g_sens = g_sens + theme(legend.position="top", legend.background = element_rect(fill="gray90", size =5 )  )
g_sens = g_sens + geom_segment(aes( x = .8,xend = 1,
                                y = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "AVG") )[4],2], 
                                yend = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "AVG") )[4],2]), size = 1.5)
g_sens = g_sens + geom_segment(aes( x = 1.8,xend = 2,
                                y = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "RNA") )[4],2], 
                                yend = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "RNA") )[4],2]), size = 1.5)
g_sens = g_sens + geom_segment(aes( x = 2.8,xend = 3,
                                y = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "ClearSight") )[4],2], 
                                yend = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "ClearSight") )[4],2]), size = 1.5)
g_sens = g_sens + geom_segment(aes( x = 3.8,xend = 4,
                                y = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "TruSight") )[4],2], 
                                yend = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "TruSight") )[4],2]), size = 1.5)
g_sens = g_sens + geom_segment(aes( x = 4.8,xend = 5,
                                y = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "Hotspot_v2") )[4],2], 
                                yend = benchmark_Sensitivity[ which( (benchmark_Sensitivity[,1] == "0.5") & (benchmark_Sensitivity[,3] == "Hotspot_v2") )[4],2]), size = 1.5)
g_sens

# F1

g_F1 = ggplot( data = benchmark_F1, aes( x = Seq_Type, y = F1))
g_F1 = g_F1 + geom_boxplot(aes(colour = Weight),size=1)
g_F1 = g_F1 + theme(legend.position="top", legend.background = element_rect(fill="gray90", size =5 )  )
g_F1 = g_F1 + geom_segment(aes( x = .8,xend = 1,
                                  y = benchmark_F1[ which( (benchmark_F1[,1] == "0.5") & (benchmark_F1[,3] == "AVG") )[4],2], 
                                  yend = benchmark_F1[ which( (benchmark_F1[,1] == "0.5") & (benchmark_F1[,3] == "AVG") )[4],2]), size = 1.5)
g_F1 = g_F1 + geom_segment(aes( x = 1.8,xend = 2,
                                  y = benchmark_F1[ which( (benchmark_F1[,1] == "0.5") & (benchmark_F1[,3] == "RNA") )[4],2], 
                                  yend = benchmark_F1[ which( (benchmark_F1[,1] == "0.5") & (benchmark_F1[,3] == "RNA") )[4],2]), size = 1.5)
g_F1 = g_F1 + geom_segment(aes( x = 2.8,xend = 3,
                                  y = benchmark_F1[ which( (benchmark_F1[,1] == "0.5") & (benchmark_F1[,3] == "ClearSight") )[4],2], 
                                  yend = benchmark_F1[ which( (benchmark_F1[,1] == "0.5") & (benchmark_F1[,3] == "ClearSight") )[4],2]), size = 1.5)
g_F1 = g_F1 + geom_segment(aes( x = 3.8,xend = 4,
                                  y = benchmark_F1[ which( (benchmark_F1[,1] == "0.5") & (benchmark_F1[,3] == "TruSight") )[4],2], 
                                  yend = benchmark_F1[ which( (benchmark_F1[,1] == "0.5") & (benchmark_F1[,3] == "TruSight") )[4],2]), size = 1.5)
g_F1 = g_F1 + geom_segment(aes( x = 4.8,xend = 5,
                                  y = benchmark_F1[ which( (benchmark_F1[,1] == "0.5") & (benchmark_F1[,3] == "Hotspot_v2") )[4],2], 
                                  yend = benchmark_F1[ which( (benchmark_F1[,1] == "0.5") & (benchmark_F1[,3] == "Hotspot_v2") )[4],2]), size = 1.5)
g_F1

# PPV

g_PPV = ggplot( data = benchmark_PPV, aes( x = Seq_Type, y = PPV))
g_PPV = g_PPV + geom_boxplot(aes(colour = Weight),size=1)
g_PPV = g_PPV + theme(legend.position="top", legend.background = element_rect(fill="gray90", size =5 )  )
g_PPV = g_PPV + geom_segment(aes( x = .8,xend = 1,
  y = benchmark_PPV[ which( (benchmark_PPV[,1] == "0.5") & (benchmark_PPV[,3] == "AVG") )[4],2], 
  yend = benchmark_PPV[ which( (benchmark_PPV[,1] == "0.5") & (benchmark_PPV[,3] == "AVG") )[4],2]), size = 1.5)
g_PPV = g_PPV + geom_segment(aes( x = 1.8,xend = 2,
  y = benchmark_PPV[ which( (benchmark_PPV[,1] == "0.5") & (benchmark_PPV[,3] == "RNA") )[4],2], 
  yend = benchmark_PPV[ which( (benchmark_PPV[,1] == "0.5") & (benchmark_PPV[,3] == "RNA") )[4],2]), size = 1.5)
g_PPV = g_PPV + geom_segment(aes( x = 2.8,xend = 3,
  y = benchmark_PPV[ which( (benchmark_PPV[,1] == "0.5") & (benchmark_PPV[,3] == "ClearSight") )[4],2], 
  yend = benchmark_PPV[ which( (benchmark_PPV[,1] == "0.5") & (benchmark_PPV[,3] == "ClearSight") )[4],2]), size = 1.5)
g_PPV = g_PPV + geom_segment(aes( x = 3.8,xend = 4,
  y = benchmark_PPV[ which( (benchmark_PPV[,1] == "0.5") & (benchmark_PPV[,3] == "TruSight") )[4],2], 
  yend = benchmark_PPV[ which( (benchmark_PPV[,1] == "0.5") & (benchmark_PPV[,3] == "TruSight") )[4],2]), size = 1.5)
g_PPV = g_PPV + geom_segment(aes( x = 4.8,xend = 5,
  y = benchmark_PPV[ which( (benchmark_PPV[,1] == "0.5") & (benchmark_PPV[,3] == "Hotspot_v2") )[4],2], 
  yend = benchmark_PPV[ which( (benchmark_PPV[,1] == "0.5") & (benchmark_PPV[,3] == "Hotspot_v2") )[4],2]), size = 1.5)
g_PPV

# prow

prow = plot_grid(
    g_sens + theme(legend.position="none") + theme( axis.text.x = element_text(angle=45, vjust = .5), axis.title.x = element_blank() ),
    g_F1   + theme(legend.position="none") + theme( axis.text.x = element_text(angle=45, vjust = .5), axis.title.x = element_blank() ),
    g_PPV  + theme(legend.position="none") + theme( axis.text.x = element_text(angle=45, vjust = .5), axis.title.x = element_blank() ), 
    labels=c("A", "B","C"), 
    ncol = 3,
    nrow = 1
)

legend_b = get_legend( g_F1 )
p = plot_grid( 
    legend_b,
    prow,
    ncol = 1, rel_heights = c( .05, 1)
)

#jpeg("~/Dropbox/Uniquorn_project/Figures/performance.jpg", width = 1024,height = 512)
    p
#dev.off()

### Confusion matrices

#i_table = read.table("~/Uniquorn_data/benchmark_vcf_files/Finished/Results/Conf_35_top1/0_5_Benchmark_identification_result.tab",sep="\t", header = T)
i_table = read.table("~/Uniquorn_data/benchmark_vcf_files/0_5_Benchmark_identification_result.tab",sep="\t", header = T)
i_table[1:5,1:5]

# confusion_matrix

confusion_matrix <<- matrix(integer(), ncol= 5, nrow = 0)

sapply(library_names, FUN = function(lib){
    
    index = grep(i_table$Query, pattern = lib)
    false_neg = sapply( library_names , function(vec){
        
        return(
          sum( str_count(i_table$False_negative[index], pattern = vec) )
        )
    })
    
    confusion_matrix <<- rbind( confusion_matrix, false_neg)
})
rownames(confusion_matrix) = library_names

# exp_matrix

exp_matrix <<- matrix(integer(), ncol= 5, nrow = 0)

sapply(library_names, FUN = function(lib){
  
  index = grep(i_table$Query, pattern = lib)
  exp_tp = sapply( library_names , function(vec){
    
    return(
      sum( str_count(i_table$Expected[index], pattern = vec) )
    )
  })
  
  exp_matrix <<- rbind( exp_matrix, exp_tp)
})
rownames(exp_matrix) = library_names

# FN_matrix

FN_matrix <<- matrix(integer(), ncol= 5, nrow = 0)

sapply(library_names, FUN = function(lib){
  
  index = grep(i_table$Query, pattern = lib)
  FN_FN = sapply( library_names , function(vec){
    
    return(
      sum( str_count(i_table$False_negative[index], pattern = vec) )
    )
  })
  
  FN_matrix <<- rbind( FN_matrix, FN_FN)
})
rownames(FN_matrix) = library_names
FN_matrix = round( (FN_matrix / exp_matrix) * 100, 1 )

# FP_matrix

FP_matrix <<- matrix(integer(), ncol= 5, nrow = 0)

sapply(library_names, FUN = function(lib){
  
  index = grep(i_table$Query, pattern = lib)
  FP_FP = sapply( library_names , function(vec){
    
    return(
      sum( str_count(i_table$False_positive[index], pattern = vec) )
    )
  })
  
  FP_matrix <<- rbind( FP_matrix, FP_FP)
})
rownames(FP_matrix) = library_names
FP_matrix = round( (FP_matrix / exp_matrix) * 100, 1 )

# tp_matrix

tp_matrix <<- matrix(integer(), ncol= 5, nrow = 0)

sapply(library_names, FUN = function(lib){
  
  index = grep(i_table$Query, pattern = lib)
  tp_tp = sapply( library_names , function(vec){
    
    return(
      sum( str_count(i_table$True_positive[index], pattern = vec) )
    )
  })
  
  tp_matrix <<- rbind( tp_matrix, tp_tp)
})
rownames(tp_matrix) = library_names
TP_matrix = round( (tp_matrix / exp_matrix) * 100, 1 )

# PPV

PPV_matrix = round( TP_matrix / (TP_matrix + FP_matrix) * 100, 1 )
F1_matrix = round( 2 * ( TP_matrix * 99.9  ) / ( TP_matrix + 99.9) , 1 )

# rel_fn_mat

new_mat = confusion_matrix / exp_matrix

# gold mat

gold_std = read.table("~/Dropbox/Uniquorn_project/Misc/Goldstandard.tsv",sep ="\t", header = T)
gold_matrix <<- matrix(integer(), ncol= 5, nrow = 0)

sapply(library_names, FUN = function(lib){
  
  index = grep(gold_std$CL, pattern = lib)
  pos_TP = sapply( library_names , function(vec){
    
    return(
      sum( str_count(gold_std$Merged[index], pattern = vec) )
    )
  })
  
  gold_matrix <<- rbind( gold_matrix, pos_TP)
})
rownames(gold_matrix) = library_names
new_mat = confusion_matrix / gold_matrix

melted_cormat <- melt(confusion_matrix, na.rm = TRUE, as.is = T)
#colnames( melted_cormat ) = c("")
melted_cormat$X1 = as.character(melted_cormat$X1); melted_cormat$X2 = as.character(melted_cormat$X2)
melted_cormat$X1[ melted_cormat$X1 == "COSMIC" ] = "CGP" 
melted_cormat$X2[ melted_cormat$X2 == "COSMIC" ] = "CGP"
melted_cormat$X1[ melted_cormat$X1 == "EGA" ] = "Klijn"
melted_cormat$X2[ melted_cormat$X2 == "EGA" ] = "Klijn"
colnames(confusion_matrix)[colnames(confusion_matrix) == "COSMIC"] = "CGP"
colnames(confusion_matrix)[colnames(confusion_matrix) == "EGA"] = "Klijn"
rownames(confusion_matrix)[rownames(confusion_matrix) == "COSMIC"] = "CGP"
rownames(confusion_matrix)[rownames(confusion_matrix) == "EGA"] = "Klijn"
colnames(new_mat)[colnames(new_mat) == "COSMIC"] = "CGP"
colnames(new_mat)[colnames(new_mat) == "EGA"] = "Klijn"
rownames(new_mat)[rownames(new_mat) == "COSMIC"] = "CGP"
rownames(new_mat)[rownames(new_mat) == "EGA"] = "Klijn"
new_mat = new_mat[c("CELLMINER","GDC","CCLE","CGP","Klijn"),c("Klijn","CELLMINER","CCLE","GDC","CGP")]

# reorder

library("gridGraphics")
grab_grob <- function(){
  grid.echo()
  grid.grab()
}

#tiff("~/Dropbox/Uniquorn_project/Figures/5_FN_Abs.tif")#, width = 624,height = 512)
mat = confusion_matrix
abs_plot = corrplot::corrplot(
  # reset the margins
  par(mar=c(5,4,4,2)),
  method = "square",
  #col = c(rep("green",5),rep("yellow",2),rep("red",1)),
  p.mat = confusion_matrix,
  is.corr = FALSE,
  insig = "p-value",
  #tl.pos = "ld",
  tl.srt = 45,
  cl.lim = c(0,max(confusion_matrix)), mar = c(0, 0, 0, 0)
)+ theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))
#dev.off()

g <- grab_grob()
col2 <- colfunc<-colorRampPalette(c("red","yellow","springgreen","royalblue"))
#tiff("~/Dropbox/Uniquorn_project/Figures/5_FN_Rel.tif")#, width = 624,height = 512)
par(cex = 1.3)
rel_plot = corrplot::corrplot(
    new_mat,
    method = "square",
    p.mat = new_mat,
    is.corr = FALSE,
    col = rev(c( col2(50), col2(50) )),
    sig.level = -1,
    insig = "p-value",
    tl.srt = 45,
    tl.cex = .7,
    cl.cex = .7
) + theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))

#dev.off()

g2 <- grab_grob()
library(gridExtra)
grid.newpage()
grid.arrange( g,g2, nrow = 1 )
plot_grid(g, g2,  scale = .75,labels = c("A","B"), align = "h", mar = c(0, 0, 0, 0),align="v")

### heatmap

draw_colnames_45 <- function (coln, gaps, ...) {coord = pheatmap:::find_coordinates(length(coln), gaps);x = coord$coord - 0.5 * coord$size;  res = textGrob(coln, x = x, y = unit(1, "npc") - unit(3,"bigpts"), vjust = 0.5, hjust = 1, rot = 45, gp = gpar(...));  return(res)}
assignInNamespace(x="draw_colnames", value="draw_colnames_45",ns=asNamespace("pheatmap"))

vis_mat_fn = round(new_mat*100,0)

vis_mat = rbind(
  colMeans(FP_matrix),
  colMeans(TP_matrix),
  colMeans(FN_matrix),
  colMeans(F1_matrix),
  colMeans(PPV_matrix)
)
rownames( vis_mat ) = c("FP","TP","FN","F1", "PPV")

melt_vis_mat = reshape2::melt(vis_mat)
colnames(melt_vis_mat) =  c("Parameter","Library","Value")

clust_mat = vis_mat[c(1,3),]
clust_mat = clust_mat[, order(clust_mat[1,], decreasing = T)]

meta_data = data.frame(
  "SNPs_unfiltered" = c("Yes","Yes","No","No","No"),
  "Contained_CCLs" = c(675,937,1020,60,994)
)
rownames(meta_data) = colnames(clust_mat)

pheatmap::pheatmap(
  clust_mat,
  cluster_rows = F,
  cluster_cols = F,
  display_numbers = 1,
  fontsize_number = 20,
  treeheight_row =  0,
  treeheight_col = 0,
  number_format = "%.0f",
  annot_col = meta_data
)
