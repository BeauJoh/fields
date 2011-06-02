# fields, Tools for spatial data
# Copyright 2004-2011, Institute for Mathematics Applied Geosciences
# University Corporation for Atmospheric Research
# Licensed under the GPL -- www.gpl.org/licenses/gpl.html
"set.panel" <- function(m = 1, n = 1, relax = FALSE) {
    temp <- par()
    single.plot <- (temp$mfg[3] == 1 & temp$mfg[4] == 1)
    if (!relax | single.plot | ((m == 1) & (n == 1))) {
        par(mfrow = c(m, n))
        cat("plot window will lay out plots in a", m, "by", n, 
            "matrix ", fill = TRUE)
    }
    invisible()
}
