"periodic.cov.cyl" <-
function (x1, x2, a = 0, b = 365, theta = 1) 
{
    cov.per1d <- periodic.cov.1d(x1[, 1], x2[, 1], a, b)
    cov.vert <- Exp.cov(x1[, 2], x2[, 2], theta = theta)
    cov <- cov.per1d * cov.vert
    return(cov)
}
