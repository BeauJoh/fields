# fields, Tools for spatial data
# Copyright 2004-2011, Institute for Mathematics Applied Geosciences
# University Corporation for Atmospheric Research
# Licensed under the GPL -- www.gpl.org/licenses/gpl.html
"print.qsreg" <- function(x, ...) {
    digits <- 4
    c1 <- "Number of Observations:"
    c2 <- (x$N)
    c1 <- c(c1, "Effective degrees of freedom:")
    c2 <- c(c2, format(round(x$trace[x$ind.cv.ps], 1)))
    c1 <- c(c1, "Residual degrees of freedom:")
    c2 <- c(c2, format(round(x$N - x$trace[x$ind.cv.ps], 1)))
    c1 <- c(c1, "Log10(lambda) ")
    lambda <- x$cv.grid[, 1]
    c2 <- c(c2, format(round(log10(lambda[x$ind.cv.ps]), 2)))
    sum <- cbind(c1, c2)
    dimnames(sum) <- list(rep("", dim(sum)[1]), rep("", dim(sum)[2]))
    cat("Call:\n")
    dput(x$call)
    print(sum, quote = FALSE)
    invisible(x)
}
