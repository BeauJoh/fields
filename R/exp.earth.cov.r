# fields, Tools for spatial data
# Copyright 2004-2007, Institute for Mathematics Applied Geosciences
# University Corporation for Atmospheric Research
# Licensed under the GPL -- www.gpl.org/licenses/gpl.html

"Exp.earth.cov" <-
function (x1, x2, theta = 1) 
{
    exp(-rdist.earth(x1, x2)/theta)
}