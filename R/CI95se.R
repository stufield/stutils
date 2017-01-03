#######################################

#' Calculate SEM 95\% Confidence Intervals
#' 
#' Uses standard error (of the mean) calculation to determine the 95% CI 
#' of a vector of data.  Does not use a bootstrapping of empirical data, 
#' but the Gaussian approximation.
#' 
#' @param x Numeric. A vector of data to calculate the CI95
#' @return A vector with 3 entries: 1) the lower CI95, 2) the arithmetic mean,
#' 3) the upper CI95.
#' @author Stu Field
#' @seealso \code{\link{bootstrap}} to create CI95 via bootstrapping method.
#' @references %% ~put references to the literature/web site here ~
#' @examples
#' 
#' CI95se(rnorm(100))
#' 
#' @importFrom stats sd
#' @export CI95se
CI95se <- function(x) {
   sem   <- sd(x) / sqrt(length(x))
	shift <- 1.96 * sem
   c(lower=mean(x)-shift, mean=mean(x), upper=mean(x)+shift)
}

