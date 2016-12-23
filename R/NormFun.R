#' 
#' Normal Distribution Histogram
#' 
#' Describes a Gaussian (Normal) distribution given various
#' arguments and plots them in
#' a histogram along with a line composed by dnorm().
#' 
#' Neat function for making histogram with density line as well
#' 
#' @param n Number of observations.
#' @param mu Vector of means.
#' @param sdv Vector of standard deviations.
#' @param bks How to set the breaks for plotting the histogram.
#' @return A Histogram with the random observations produced in rnorm() with a
#' line produced with dnorm().
#' @note Used as an example to demo how to create functions in the R tutorial.
#' @author Stu Field
#' @seealso \code{\link{hist}}, \code{\link{rnorm}}, \code{\link{dnorm}}, \code{\link{curve}}
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' NormFun()
#' 
#' @export NormFun
NormFun <- function(n=1000, mu=400, sdv=25, bks=25) {

	Y <- rnorm(n, mu, sdv)
	H <- hist(Y, main="", xlab="", prob=TRUE, col="gray88", breaks=bks)
	x <- seq(min(Y), max(Y), length=100)
	y <- dnorm(x, mu, sdv)
	lines(x, y, lwd=1.5, col="navy")
	lines(density(Y), col=2, lty="dotted")
   box()

}
