# fields, Tools for spatial data
# Copyright 2004-2011, Institute for Mathematics Applied Geosciences
# University Corporation for Atmospheric Research
# Licensed under the GPL -- www.gpl.org/licenses/gpl.html
"describe.bplot" <- function(temp, style = "tukey", 
    outlier = TRUE) {
    obj <- list()
    temp <- temp[!is.na(temp)]
    obj$N <- length(temp)
    obj$out <- numeric(0)
    obj$style <- style
    obj$bb <- NA
    if (obj$N < 1) {
        obj$range <- NA
        return(obj)
    }
    obj$range <- range(temp)
    if (style == "quantile") {
        quant <- c(0.05, 0.25, 0.5, 0.75, 0.95)
        obj$bb <- bb <- quantile(temp, quant, na.rm = TRUE)
        if ((length(temp) > 5) & outlier) {
            obj$out <- temp[(temp < bb[1]) | (temp > bb[5])]
        }
        else obj$out <- temp
    }
    if (style == "tukey") {
        quant <- c(0.05, 0.25, 0.5, 0.75, 0.95)
        obj$bb <- bb <- quantile(temp, quant, na.rm = TRUE)
        iqr <- bb[4] - bb[2]
        bb[1] <- min(temp[temp >= bb[2] - 1.5 * iqr])
        bb[5] <- max(temp[temp <= bb[4] + 1.5 * iqr])
        obj$bb <- bb
        if ((length(temp) > 5) & outlier) {
            obj$out <- temp[(temp < bb[2] - 3 * iqr) | (temp > 
                bb[4] + 3 * iqr)]
        }
        else obj$out <- temp
    }
    obj
}
