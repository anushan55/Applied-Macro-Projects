# TARGET: demonstrate basic table customizing (horizontal lines) framework ####
library(xtable)

# mwe data
data <- structure(list(l = c(NA, NA, NA), 
                       w = c(515, 75, 85), 
                       a = c(0.22, 0.45, 0.45), 
                       m = c(127.83, 33.75, 38.25)), class = "data.frame", row.names = c("x", "y", "z"))
xtab <- xtable(data)

hline <- c(-1,0,nrow(xtab)-1,nrow(xtab))
htype <- c("\\toprule ", "\\midrule ", "\\toprule ","\\bottomrule ")

print(xtab,add.to.row = list(pos = as.list(hline),
                             command = htype),
      hline.after = NULL)
