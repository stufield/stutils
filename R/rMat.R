
#' Create Random Matrix
#' 
#' Generate a matrix with random numbers in its entries.
#' 
#' @param m Numeric. Row dimension of the matrix to be produced.
#' @param n Numeric. Column dimension of the matrix to be produced.
#' @param min Numeric. Minimum random number in range.
#' @param max Numeric. Maximum random number in range.
#' @param replace Logical. Should the sampled numbers be repeated?
#' @param ... Additional arguments passed to \code{\link{matrix}}.
#' @return A matrix with m x n dimensions full of random numbers
#' on the interval \verb{[min, max]}.
#' @note Never know when you need a matrix of random numbers!
#' @author Stu Field
#' @seealso \code{\link[base]{sample}}
#' @examples
#' 
#' rMat(5, 6, 35, 75)
#' rMat(5, 6, 35, 75, replace = TRUE)
#' 
#' @export rMat
rMat <- function(m, n, min, max, replace = FALSE, ...) {
  s <- sample(min:max, size = m * n, replace = replace)
  if ( m * n != length(s) )
    stop("Incorrect dimensions or min/max length", call. = FALSE)
  matrix(s, nrow = m, ncol = n, ...)
}
