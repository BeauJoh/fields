# fields, Tools for spatial data
# Copyright 2004-2007, Institute for Mathematics Applied Geosciences
# University Corporation for Atmospheric Research
# Licensed under the GPL -- www.gpl.org/licenses/gpl.html
"make.surface.grid" <- function(grid.list) {
    #
    # the old fields version of make.surface.grid was complicated
    # and we believe rarely used.
    # this current function
    # is essentially a single line replacement
    #
    # but adds an attribute for the grid matrix to carry
    # and carries along the names of the grid.list variables.
    # along the information as to how it was created.
    # see as.surface
    temp <- as.matrix(expand.grid(grid.list))
    # wipe out row names
    dimnames(temp) <- list(NULL, names(grid.list))
    # set attribute
    attr(temp, "grid.list") <- grid.list
    temp
}