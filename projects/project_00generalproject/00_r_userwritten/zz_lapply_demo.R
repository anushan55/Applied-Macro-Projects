# TARGET: demonstrate basic lapply framework ####

l = list('meeerse','robbinchen')
l2 = list(meerse = 1:10, robbin = 1:10)
dft <- CREATEREGINPUTS(10)
ldft <- LISTDEFINE(dfx=dft,dfxreturn=T,pattlinput='z|x')

#EITHER
lapply(l, function(x){
  print(x)
}
)

#OR: 
robbbas <- function(x){
  print(x)
}
lapply(l, FUN=robbbas)


#printing content vs. name of main elements ####

#EITHER
lapply(seq_along(l2), function(i,lx=l2) {
  print(lx[[i]])
  print(names(lx)[[i]])
}
)
#OR
robbbas <- function(i,lx){
  print(lx[[i]])
  print(names(lx)[[i]])
}
lapply(seq_along(l2), lx=l2, FUN=robbbas) 
lapply(seq_along(ldft), lx=ldft, FUN=robbbas) #works on df as well as on list input


#printing names of sub elements ####
x=l2
lapply(seq_along(x), function(y, n, i) { paste(n[[i]], y[[i]]) }, y=x, n=names(x))
