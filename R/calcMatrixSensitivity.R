#' 
#' Linear Sensitivity Analysis
#' 
#' Sensitivity analysis of linear maps, all in one function.
#' 
#' %% ~~ If necessary, more details than the description above ~~
#' 
#' @param A Projection matrix to be analyzed.
#' @return A list of the following:
#' \item{Matrix }{The original projection matrix (map).}
#' \item{Sensitivity }{Matrix of linear sensitivity based on
#' perturbations of parameters to Lambda.}
#' \item{Elasticity }{Matrix of linear elasticity (proportional change)
#' based on perturbations of parameters to Lambda.}
#' @note %% ~~further notes~~
#' @author Stu Field
#' @seealso \code{\link{analyzeProjectionMatrix}}, \code{\link{eigen}},
#' \code{\link[popbio]{eigen.analysis}}, \code{\link[popbio]{popbio}}
#' @references Caswell, H. Matrix Population Models. 2001. Sensitivity & Elasticity.
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' A <- diag(1:5 / 10)
#' A[cbind(2:5, 1:4)] <- 3:6 / 10
#' A[1, 5] <- 5
#' 
#' calcMatrixSensitivity(A)
#' 
#' @export calcMatrixSensitivity
calcMatrixSensitivity <- function(A) {

   w <- as.double(eigen(A)$vectors[, 1])         # right eigenvector; SSD
   v <- as.double(eigen(t(A))$vectors[, 1])      # left eigenvector; RV
   lambda <- as.double(eigen(A)$values[1])       # dom. eigenvalue
   dot <- w %*% v                                # dot product of w & v

   if (sum(which(round(A%*%w, 4) == round(lambda*w, 4))) < ncol(A))
      stop("Problem: A%*%w != lambda*w")
   if (sum(which(round(v%*%A, 4) == round(lambda*v, 4))) < ncol(A))
      stop("Problem: v%*%A != lambda*v")

   ### Elasticity matrix
   E <- diag(0, ncol(A))

   for (i in 1:length(v)) {
      for (j in 1:length(w)) {
         E[i,j] <- A[i,j] / lambda * v[i] * w[j] / dot
      }
   }

   ### Sensitivity matrix
   S <- diag(0, ncol(A))

   for (i in 1:length(v)) {
      for (j in 1:length(w)) {
         if (E[i,j] == 0) {
            S[i,j] = 0
         } else if (E[i,j] != 0) {
            S[i,j] <- v[i] * w[j] / dot
         }
      }
   }
   list(Matrix=A, Sensitivity=S, Elasticity=E)
}

