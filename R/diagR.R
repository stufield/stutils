
#' Create Matrix from Vector
#' 
#' Matlab mimic function for producing matrices with vectors 
#' along the sub- or super-diagonal.
#' 
#' @param x Numeric. A Vector to be placed into entries 
#' of a matrix along a diagonal.
#' @param k Numeric. The offset from the diagonal.
#' +1 = super-diagonal, -1 = sub-diagonal.
#' Default = 0, which reverts to \code{\link[base]{diag}}.
#' @return A matrix with vector "x" along a diagonal, or the
#' sub- super-diagonal if `k != 0`.
#' @note Matlab style matrix diag()
#' @author Stu Field
#' @seealso \code{\link{diag}}, \code{\link{zeros}}
#' @examples
#' diagR(1:7, k = -1)     # sub-diagonal
#' diagR(1:15, k = 0)     # same as diag()
#' vec <- seq(15, 30, by = 3)
#' diagR(vec, 1)          # super-diagonal
#' @export diagR
diagR <- function(x, k = 0) {
  n <- length(x) + abs(k)
  A <- matrix(0, n, n)
  r <- (1 - min(0, k)):(n - max(0, k))
  c <- (1 + max(0, k)):(n + min(0, k))
  A[cbind(r, c)] <- x
  return(A)
}
