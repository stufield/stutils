
#' Matrix Multiplication
#' 
#' Mimic of proper matrix multiplication without using the R syntax of %*%.
#' 
#' For matrix multiplication, the ncol(A) must equal nrow(B)! and you get a
#' nrow(A) x ncol(B) matrix as a result. Must be matrices not vectors. If
#' vector is desired, use 1 row/col matrix.
#' 
#' @param A The pre-multiplied matrix.
#' @param B The post-multiplied matrix.
#' @return A matrix (or vector) result of matrix multiplication.
#' @note This is a mimic of the MatLab version of matrix multiplication, A * B,
#' where here is it is \code{matrixX(A, B)}.
#' @author Stu Field
#' @seealso \code{\%*\%}
#' @examples
#' 
#' M <- diag(1:4)
#' N <- matrix(1:16, ncol = 4)
#' M%*%N            # R syntax
#' matrixX(M, N)    # using function
#' M * N            # Hadamard Product
#' 
#' @export matrixX
matrixX <- function(A, B) {

  if ( ncol(A) != nrow(B) )
    stop("You can't multiply those together ... wrong dimensions!")

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
