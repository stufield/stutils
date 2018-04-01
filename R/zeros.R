
#' Diagonal Matrix of Zeros
#' 
#' Produce a matrix of zeros of dimensions determined by the
#' diagonal argument.
#' 
#' Mimic of the MatLab function of a similar name.
#' 
#' @param x Numeric. The dimensions (m x n) for the square matrix to 
#' be produced, or the length of the diagonal of the square matrix
#' @return A square matrix of zeros with \code{m x n} dimensions 
#' where both equal \code{x}
#' @note Mimic of MatLab, even though MatLab is bullshit.
#' @author Stu Field
#' @seealso \code{\link{diag}}, \code{\link{diagR}}
#' @examples
#' 
#' zeros(7)
#' zeros(15)
#' zeros(c(3, 5))
#' 
#' @export zeros
zeros <- function(x) diag(0, x) 
