#' 
#' Normal Distribution Histogram
#' 
#' Describes a Gaussian (Normal) distribution given various
#' arguments and plots them in
#' a histogram along with a line composed by dnorm().
#' 
#' Neat function for making histogram with density line as well
#' 
#' @param n Numeric. The number of observations
#' @param mu Numeric. A vector of means
#' @param sd Numeric. A vector of standard deviations
#' @param bks How to set the breaks for plotting the histogram
#' @param ... Additional argumnets passed to \code{\link{hist}}
#' @return A histogram with the random observations produced in rnorm() with a
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
#' @importFrom stats density dnorm rnorm
#' @importFrom graphics hist lines
#' @export NormFun
NormFun <- function(n=1000, mu=400, sd=25, bks=25, ...) {

	Y <- rnorm(n, mean=mu, sd=sd)
	H <- hist(Y, main="", xlab="", prob=TRUE, col="gray88", breaks=bks, ...)
	x <- seq(min(Y), max(Y), length=100)
	y <- dnorm(x, mean=mu, sd=sd)
	lines(x, y, lwd=1.5, col="navy")
	lines(density(Y), col=2, lty="dotted")
   box()

}
