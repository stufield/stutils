
#' Linear Sensitivity Analysis
#' 
#' Sensitivity analysis of linear maps, all in one function.
#' 
#' @param A A projection matrix to be analyzed.
#' @return A list of the following:
#' \item{Matrix }{The original projection matrix (map)}
#' \item{Sensitivity }{Matrix of linear sensitivity based on
#' perturbations of parameters to lambda}
#' \item{Elasticity }{Matrix of linear elasticity (proportional change)
#' based on perturbations of parameters to lambda}
#' \item{lambda }{The dominant eigenvalue of A. Projection matrix population
#' "growth"}
#' \item{w }{The right eigenvector or stable stage distribution of the
#' population}
#' \item{v }{The left eigenvector or the reproductive "value" of each stage 
#' in the population}
#' @author Stu Field
#' @seealso \code{\link{analyzeProjectionMatrix}}, \code{\link{eigen}},
#' \code{\link[popbio]{eigen.analysis}}, \code{\link[popbio]{popbio}}
#' @references Caswell, H. Matrix Population Models. 2001. Sensitivity & Elasticity.
#' @examples
#' A <- diag(1:5 / 10)
#' A[cbind(2:5, 1:4)] <- 3:6 / 10
#' A[1, 5] <- 5
#' 
#' calcMatrixSensitivity(A)
#' @export calcMatrixSensitivity
calcMatrixSensitivity <- function(A) {

  w      <- Mod(eigen(A)$vectors[, 1])             # right eigenvector
  v      <- Mod(eigen(t(A))$vectors[, 1])          # left eigenvector
  lambda <- Mod(eigen(A, only.values = TRUE)$values[1])  # dominant eigenvalue
  dot    <- drop( t(v) %*% as.matrix(w) )          # dot product of eigenvectors

  # Sensitivity matrix
  S <- (as.matrix(v) %*% t(w)) / dot

  # Elasticity matrix
  E <- (1 / lambda) * S * A

  list(Matrix = A, Sensitivity = S, Elasticity = E,
       lambda = lambda, w = w, v = v)
}
