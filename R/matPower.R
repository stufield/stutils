
#' Matrix Power
#' 
#' Calculate the result of exponentiation of a matrix of 
#' the form X^n, where X is a matrix and n is an integer.
#' 
#' This technique is referred to the Power Method and is sometimes
#' used to estimate Lambda, the growth rate of a projection matrix.
#' 
#' @param X A matrix to be multiplied.
#' @param n An integer to place in the exponent (power).
#' @return A matrix, the result of X^n.
#' @author Stu Field
#' @references Stolen from somewhere online.
#' @examples
#' M <- diag(c(1.3, 0.4, 0.5, 0.9))
#' matPower(M, 10)
#' @export matPower
matPower <- function(X, n) {

  if ( n != round(n) ) {
	  n <- round(n)
		warning("rounding exponent n to", n, call. = FALSE)
  }

  if ( n == 0 ) {
    return(diag(nrow = nrow(X)))
  }

	n   <- n - 1
	phi <- X

	## pot <- X # the first power of the matrix.

	while ( n > 0 ) {
		if ( n %% 2 ) phi <- phi %*% X
		if ( n == 1 ) break
		n <- n %/% 2
		X <- X %*% X
	}
	return(phi)
}
