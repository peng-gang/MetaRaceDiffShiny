library(ggplot2)
library(effsize)

load("www/Cd.RData")

makeList <- function(x){
  rlt <- list()
  for(i in 1:length(x)){
    rlt[[i]] <- i
  }
  names(rlt) <- x
  rlt
}


cdPlot <- function(idxRace1, idxRace2, idxDataSet){
  idx1 <- race_info$race_detail == raceAll[idxRace1]
  idx2 <- race_info$race_detail == raceAll[idxRace2]
  if(idxDataSet == 1){
    cdAll <- NULL
    confLow <- NULL
    confHigh <- NULL
    for(i in 1:41){
      tmp <- cohen.d(control_unique[which(idx1 & flagSelC9), 7+i], control_unique[which(idx2 & flagSelC9), 7+i])
      cdAll <- c(cdAll, tmp$estimate)
      confLow <- c(confLow, tmp$conf.int[1])
      confHigh <- c(confHigh, tmp$conf.int[2])
    }
    idx <- order(cdAll)
    
    dplot <- data.frame(
      meta = colnames(control_unique)[8:48][idx],
      cd = cdAll[idx],
      confLow = confLow[idx],
      confHigh = confHigh[idx],
      stringsAsFactors = FALSE
    )
    dplot$meta <- factor(dplot$meta, levels = dplot$meta)
    
    gp <- ggplot(dplot, aes(x=meta, y=cd)) + 
      geom_hline(yintercept = 0, color = "grey", linetype = "dashed") + 
      geom_point() + 
      geom_errorbar(aes(ymin=confLow, ymax=confHigh), width = 0.4) + 
      labs(x = "", y = "Cohen's d") + 
      scale_y_continuous(limits = c(-2.5, 2.5), breaks = c(-2, -1.2, -0.8, -0.5, -0.2, 0, 0.2 ,0.5, 0.8, 1.2, 2)) + 
      theme_classic() + 
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    
    return(gp)
  } else {
    cdAll <- NULL
    confLow <- NULL
    confHigh <- NULL
    for(i in 1:41){
      tmp <- cohen.d(control_unique[which(idx1 & flagSelAll), 7+i], control_unique[which(idx2 & flagSelAll), 7+i])
      cdAll <- c(cdAll, tmp$estimate)
      confLow <- c(confLow, tmp$conf.int[1])
      confHigh <- c(confHigh, tmp$conf.int[2])
    }
    idx <- order(cdAll)
    
    dplot <- data.frame(
      meta = colnames(control_unique)[8:48][idx],
      cd = cdAll[idx],
      confLow = confLow[idx],
      confHigh = confHigh[idx],
      stringsAsFactors = FALSE
    )
    dplot$meta <- factor(dplot$meta, levels = dplot$meta)
    
    gp <- ggplot(dplot, aes(x=meta, y=cd)) + 
      geom_hline(yintercept = 0, color = "grey", linetype = "dashed") + 
      geom_point() + 
      geom_errorbar(aes(ymin=confLow, ymax=confHigh), width = 0.4) + 
      labs(x = "", y = "Cohen's d") + 
      scale_y_continuous(limits = c(-2.5, 2.5), breaks = c(-2, -1.2, -0.8, -0.5, -0.2, 0, 0.2 ,0.5, 0.8, 1.2, 2)) + 
      theme_classic() + 
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    
    return(gp)
  }
}
