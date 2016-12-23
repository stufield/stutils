#' 
#' Linear Matrix Analysis
#' 
#' A quick & dirty function for the analysis of a projection matrix. Includes
#' sensitivity and elasticity of a linear matrix model.
#' 
#' %% ~~ If necessary, more details than the description above ~~
#' 
#' @param A A projection matrix.
#' @param initial A vector of the initial stage structured population. Must be
#' the same length as the number of columns of A.
#' @param Gen An integer of the number of generations to run the projection in
#' calculating matrix solutions.
#' @param key.cut Cutoff for how to limit most influential parameters. Based on
#' Elasticities.
#' @param plots Should plots be included with the output?
#' @return A list containing:
#' \item{Matrix }{The projection matrix.}
#' \item{Projection }{The population projection of solutions.}
#' \item{Stage_Proportions }{The proportion each stage of the total population.}
#' \item{Lambda }{The dominant eigenvalue corresponding to the 
#' growth rate of the population.}
#' \item{SDD }{The Stable Stage Distribution corresponding to the 
#' right eigenvector of the dominant eigenvalue.} 
#' \item{ReproValue }{Reproductive value corresponding to the left eigenvector
#' of the dominant eigenvalue.} 
#' \item{DampingRatio }{Ratio of the dominant eigenvalue to the sub-dominant
#' eigenvalue.}
#' \item{Time2Eqm }{How long does it take for the population to
#' reach equilibrium, defined as when the dominant eigenvalue is 20x the
#' sub-dominant eigenvalue.}
#' \item{Sensitivities }{Entry-wise sensitivities of each of the matrix
#' parameter entries, the absolute change in lambda with
#' changes in the parameter.}
#' \item{Elasticities }{Entry-wise elasticities of each of the matrix
#' parameter entries, the proportional change in lambda with
#' changes in the parameter.}
#' \item{Top.pars }{Which parameters have Elasticities greater than 
#' the argument determined by \code{key.cut}, sorted by decreasing "values".
#' Theta is the vector of model parameters.}
#' @note %% ~~further notes~~
#' @author Stu Field
#' @seealso \code{\link{calcMatrixSensitivity}}, \code{\link{eigen}}, \code{\link[popbio]{eigen.analysis}}, \code{\link[popbio]{popbio}}
#' @references Caswell, H. Matrix Population Models. 2001.
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' A <- diag(1:5 / 10)
#' A[cbind(2:5, 1:4)] <- 3:6 / 10
#' A[1, 5] <- 5
#' analyzeProjectionMatrix(A, initial=c(1,3,5,2,1), Gen=100)
#' analyzeProjectionMatrix(A, initial=c(1,3,5,2,1), key.cut=0.05, Gen=25, plots=FALSE)
#' 
#' @export analyzeProjectionMatrix
analyzeProjectionMatrix <- function(A, initial, Gen=25, key.cut=0.1, plots= TRUE) {

   m   <- nrow(A)
   Mx1 <- matrix(0, nrow= Gen, ncol= m, 
                dimnames= list(paste("Gen",1:Gen),paste("Class",1:m)))
   Mx2     <- Mx1
   Mx1[1,] <- initial
   
   for (i in 2:Gen) {             # project the population
      Mx1[i, 1:m] <- A %*% Mx1[i-1, 1:m]
   } 
   
   Total <- rowSums(Mx1)
   Mx1   <- cbind(Mx1,Total)

   for (i in 1:Gen) {
      for (j in 1:m)
         Mx2[i,j] <- Mx1[i,j] / Total[i]
   }
   
   lambda <- max(Mod(eigen(A)$values))
   SSD <- Mod(eigen(A)$vectors[,1]) / sum(Mod(eigen(A)$vectors[,1]))
   tA <- t(A)
   RV <- Mod(1/eigen(tA)$vectors[1,1]) * Mod(eigen(tA)$vectors[,1])
   rho <- Mod(eigen(A)$values[1]) / Mod(eigen(A)$values[2])
   tEqm <- log(20) / log(rho)
   S <- (RV %*% t(SSD)) / c(t(RV) %*% SSD)
   E <- (1/lambda) * S * A
   ################################
   theta <- which(E > key.cut)
   values <- E[which(E > key.cut)]
   keypars <- cbind(theta,values)
   keypars <- keypars[rev(order(keypars[,"values"])),]
   
   if ( plots ) {
      matplot(1:Gen, Mx1[,1:ncol(Mx1)-1], 
         type="l", 
         main="Population Projection by Stage", 
         ylab="No. of Individuals", 
         ylim=range(Mx1),
         xlab="Generations", 
         lwd=1.5)
      lines(1:Gen, Mx1[,ncol(Mx1)], type="b", lwd=1.5, col=1)
      legend("topleft", legend= "Total", lwd=1.5, pch=21, 
             lty=1, col=1, bg="gray95")

      matplot(1:Gen, Mx2, 
         type="l",
         main="Stable Stage Distribution", 
         ylab="Proportion of Population", 
         xlab="Generations", 
         ylim=range(Mx2),
         lwd=1.5)
      legend("topright", legend= rep("class", ncol(Mx2)),
             lty= 1:5, col= 1:6, lwd= 1, bg= "gray95", cex= 0.5)
   }
   
   list(Matrix=A, 
        Projection=round(Mx1,5), 
        Stage_Proportions=round(Mx2,5), 
        Lambda=lambda,
        SSD=SSD,
        ReproValue=RV, 
        DampingRatio=rho, 
        Time2Eqm=tEqm, 
        Sensitivities=round(S, 5), 
        Elasticities=round(E, 5), 
        Top.pars=keypars)
}

