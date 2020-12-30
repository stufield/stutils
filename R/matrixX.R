#' Matrix Multiplication
#' 
#' Mimic of proper matrix multiplication without
#' using the R syntax of %*%.
#' 
#' For matrix multiplication, the ncol(A) must equal nrow(B)! and you get a
#' nrow(A) x ncol(B) matrix as a result. Must be matrices not vectors. If
#' vector is desired, use 1 row/col matrix.
#' 
#' @param A The pre-multiplied matrix.
#' @param B The post-multiplied matrix.
#' @return A matrix (or vector) result of matrix multiplication.
#' @author Stu Field
#' @seealso \code{\%*\%}
#' @examples
#' M <- diag(1:4)
#' N <- matrix(1:16, ncol = 4)
#'
#' # Standard R syntax
#' M%*%N            
#'
#' matrixProd(M, N) # using function
#'
#' # Hadamard Product
#' M * N            
#' @export matrixProd
matrixProd <- function(A, B) {
  if ( ncol(A) != nrow(B) ) {
    usethis::ui_stop(
      "You can't multiply those together ... bad dimensions!"
    )
  }
  Mat <- matrix(0, nrow(A), ncol(B))
  for ( a in 1:nrow(A) ) {
    for ( b in 1:ncol(B) ) {
      sum <- 0
      for (c in 1:ncol(A)) {
        product <- A[a, c] * B[c, b]
        sum     <- sum + product
      }
      Mat[a, b] <- sum
    }
  }
  return(Mat)
}
