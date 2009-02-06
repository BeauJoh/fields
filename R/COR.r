# fields, Tools for spatial data
# Copyright 2004-2007, Institute for Mathematics Applied Geosciences
# University Corporation for Atmospheric Research
# Licensed under the GPL -- www.gpl.org/licenses/gpl.html

"COR" <-
function (dat) 
{
    m <- ncol(dat)
    M <- nrow(dat)
    ntemp <- !is.na(dat)
    ntemp <- t(ntemp) %*% (ntemp)
    hold.mean <- apply(dat, 2, "mean", na.rm = TRUE)
    temp <- (dat - matrix(c(hold.mean), ncol = m, byrow = TRUE, 
        nrow = M))
    temp[is.na(temp)] <- 0
    temp <- ifelse(ntemp > 1, t(temp) %*% (temp)/(ntemp - 1), 
        NA)
    sd <- sqrt(diag(temp))
    list(cor = t(t(temp)/sd)/sd, N = ntemp, sd = sd, mean = hold.mean)
}