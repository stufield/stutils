#' Net Reproductive Rate (Ro)
#' 
#' Calculate the Ro of a matrix, the basic reproductive ratio.
#' 
#' @param TM A matrix representing the transition matrix containing
#' survivorship probabilities (vital rates).
#' @param FM A matrix. The fecundity matrix. Typically non-zero 
#' entries in the first row.
#' @return The scalar Net Reproductive Rate (Ro).
#' @author Stu Field
#' @seealso [eigen()], [solve()]
#' @references Calculation of Ro from de-Camino-Beck & Lewis. 2007.
#' @examples
#' # Survivorship matrix
#' parS <- c(0.75, 0,   0,
#'           0.2,  0,   0,
#'           0.33, 0.4, 0)
#'
#' # Fecundity matrix
#' parF <- c(0, 0, 3,
#'           0, 0, 2,
#'           0, 0, 1)
#'
#' TM <- matrix(parS, 3, 3, byrow = TRUE)
#' TM
#' FM <- matrix(parF, 3, 3, byrow = TRUE)
#' FM
#' A <- TM + FM
#' A
#'
#' # Dominant eigenvalue of A
#' eigen(A)$values[1L]
#'
#' calcRo(TM, FM)
#' @export calcRo
calcRo <- function(TM, FM) {
  I  <- diag(ncol(TM))
  N  <- solve((I - TM), I)   # The fundamental matrix N
  R  <- FM %*% N             # The Next Generation matrix R
  Ro <- eigen(R)$values[1L]
  return(Ro)
}
