
#' Rotate a Matrix
#' 
#' Function rotates a matrix 90 degrees. Direction can be either
#' clockwise or counter-clockwise
#' 
#' @param x A matrix object
#' @param direction Character. Which direction to rotate 90 degrees.
#' Partial matching allowed
#' @return A matrix rotated 90 degrees from the original matrix
#' @author Stu Field
#' @seealso \code{\link{match.arg}}, \code{\link{t}}
#' @examples
#' m <- matrix(1:9, ncol=3)
#' m
#' rotateMatrix(m, "clock")
#' rotateMatrix(m, "counter")
#' @export rotateMatrix
rotateMatrix <- function(x, direction = c("clock", "counter-clock")) {
  stopifnot(inherits(x, "matrix"))
  direction <- match.arg(direction)
  if ( direction == "clock" ) {
    t(x)[, nrow(x):1]
  } else {
    t(x[, ncol(x):1])
  }
}
