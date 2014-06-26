my4cols <- c("black", "green", "blue", "red")
my4labels <- c("disease 1", "disease 2", "disease 3", "disease4")
polygonFun <- function(time, poly1, poly2, poly3, poly4){
  mm <- c(time, rev(time))
  poly1a <- c(rep(0, length(time)), rev(poly1))
  poly2a <- c(rep(0, length(time)), rev(poly2))
  poly3a <- c(rep(0, length(time)), rev(poly3))
  poly4a <- c(rep(0, length(time)), rev(poly4))

aa <- c(poly1, rev(poly1))
bb <- c(poly2+poly1, rev(poly1))
cc <- c(poly3+poly2+poly1, rev(poly2+poly1))
dd <- c(poly4+poly3+poly2+poly1, rev(poly3+poly2+poly1))

  plot(time, poly1, xaxt="n", type="n", ylim=c(0,max(dd, na.rm=TRUE)))
  axis(side=1, at=time, labels=time,
       tick=FALSE, line=1, cex=0.6)
  polygon(mm, poly1a, col=my4cols[1], border=NA)
  polygon(mm, bb, col=my4cols[2], border=NA)
  polygon(mm, cc, col=my4cols[3], border=NA)
  polygon(mm, dd, col=my4cols[4], border=NA)  
  legend(x="topleft", fill=my4cols, 
         legend=my4labels,
         border=FALSE, bty="n", cex=0.75)
}

polygonFun(time= comp$week,
           poly1= comp$iliStudents,
           poly2= comp$iliTeachers,
           poly3= comp$suspectStudents,
           poly4= comp$suspectTeachers)

