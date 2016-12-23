#' 
#' Net Reproductive Rate (Ro)
#' 
#' Calculate the Ro of a matrix, the basic reproductive ratio.
#' 
#' %% ~~ If necessary, more details than the description above ~~
#' 
#' @param TM Matrix. The transition matrix, separated transition & survivorship
#' probabilities (vital rates)
#' @param FM Matrix. The fecundity matrix, typically non-zero entries in the first row
#' @return The scalar Net Reproductive Rate (Ro)
#' @note %% ~~further notes~~
#' @author Stu Field
#' @seealso \code{\link{eigen}}, \code{\link{solve}}
#' @references Calculation of Ro from de-Camino-Beck & Lewis 2007
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' parS <- c(0.75, 0,   0,
#'           0.2,  0,   0,
#'           0.33, 0.4, 0)
#' parF <- c(0, 0, 3,
#'           0, 0, 2,
#'           0, 0, 1)
#' TM <- matrix(parS, 3, 3, byrow= TRUE)
#' TM
#' FM <- matrix(parF, 3, 3, byrow= TRUE)
#' FM
#' A <- TM + FM
#' A
#' eigen(A)$values[1]   # Dom. eigenvalue of A
#' calcRo(TM, FM)
#' 
#' @export calcRo
calcRo <- function(TM, FM) {

   I  <- diag(ncol(TM))
   N  <- solve((I - TM), I)   # The fundamental matrix N
   R  <- FM %*% N             # The Next Generation matrix R
   Ro <- eigen(R)$values[1]
   return(Ro)

}
