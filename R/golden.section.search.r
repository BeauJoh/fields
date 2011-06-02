# fields, Tools for spatial data
# Copyright 2004-2011, Institute for Mathematics Applied Geosciences
# University Corporation for Atmospheric Research
# Licensed under the GPL -- www.gpl.org/licenses/gpl.html
"golden.section.search" <- function(ax, bx, cx, f, 
    niter = 25, f.extra = NA, tol = 1e-05, gridx=NA) {
  
# check if an initial grid has been passed if so then do a
# search for the minimum on this grid first.
    gridx<- sort(gridx)
    NG<- length( gridx)
    fgrid<- rep( NA,NG)  
    if(!is.na(gridx[1])){
      gridx<- sort(gridx)
      NG<- length( gridx)
      fgrid<- rep( NA,NG)
      for(k in 1:NG){
        fgrid[k]<- f( gridx[k], f.extra)}
       ind.bx<- which.min(fgrid)
# if minimum is at grid boundary print warning and return      
      if( (ind.bx==1)|ind.bx==NG) {
         warning("grid search gives minimun at boundary")
         return( list(x = gridx[ind.bx], fmin = fgrid[ind.bx],
                 iter = 0,tol=tol,
                 coarse.search=cbind( gridx, fgrid,deparse.level=1)) )}
# use grid results for initial values of golden section search      
      ax<- gridx[ind.bx-1]
      bx<- gridx[ind.bx]
      cx<- gridx[ind.bx+1]}
   else{
# if no grid search, sanity check on starting points      
     f1<- f(ax, f.extra)
     f2<- f(bx, f.extra)
     f3<- f(cx, f.extra)
     if( (f2> f1)| (f2>f3)) stop("starting values not convex")}
     
          
    r <- 0.61803399
    con <- 1 - r
    x0 <- ax
    x3 <- cx
    if (abs(cx - bx) > abs(bx - ax)) {
        x1 <- bx
        x2 <- bx + con * (bx - ax)
    }
    else {
        x2 <- bx
        x1 <- bx - con * (bx - ax)
    }
    f1 <- f(x1, f.extra)
    f2 <- f(x2, f.extra)
    iter <- niter
    for (k in 1:niter) {
        #cat( x1,f1, x2,f2, fill=TRUE)
        if (f2 < f1) {
            x0 <- x1
            x1 <- x2
            x2 <- r * x1 + con * x3
            f0 <- f1
            f1 <- f2
            f2 <- f(x2, f.extra)
        }
        else {
            x3 <- x2
            x2 <- x1
            x1 <- r * x2 + con * x0
            f3 <- f2
            f2 <- f1
            f1 <- f(x1, f.extra)
        }
        if (abs(f2 - f1) < tol) {
            iter <- k
            break
        }
    }
    if (f1 < f2) {
        golden <- f1
        xmin <- x1
    }
    else {
        golden <- f2
        xmin <- x2
    }

  if( iter == niter){ warning("Maximum iterations reached")}
    
  list(x = xmin, fmin = golden, iter = iter,tol=tol,
         coarse.search=cbind( gridx, fgrid,deparse.level=1))
}