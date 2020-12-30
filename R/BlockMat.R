#' Create a Block Matrix
#' 
#' Assembles a block matrix from sub-matrices mimicking 
#' coding capabilities of `Matlab`.
#' 
#' @param x A list of the sub-matrices written in order
#' they are to appear by row.
#' @param b Numeric. The number of "block" columns. The list
#' `length(x)` must be a multiple of `b`.
#' @return The assembled block matrix.
#' @note Combine sub-Matrices into larger matrix; a
#' mimic of `Matlab`. Matrices *must* be as a list.
#' @author Stu Field
#' @examples
#' A <- diag(1:4)
#' A
#' B <- diag(9:12)
#' B
#' I <- diag(4)
#' I
#' blocks <- list(A, B, A * B, B - I)
#' blocks
#' BlockMat(blocks, b = 2)
#' BlockMat(blocks, b = 4)
#' @importFrom purrr map
#' @importFrom usethis ui_stop
#' @export BlockMat
BlockMat <- function(x, b) {
  L <- length(x)
  if ( L %% b != 0 ) {
    usethis::ui_stop("List length `x` must be multiple of: {b}")
  }
  hi <- seq(b, L, b)
  lo <- hi - (b - 1)
  purrr::map(1:(L / b), ~ do.call(cbind, x[lo[.x]:hi[.x]])) %>%
    do.call(rbind, .)
}
