
#' Linear Matrix Analysis
#' 
#' A quick and dirty function for the analysis of a projection
#' matrix. Includes sensitivity and elasticity of a linear 
#' (projection) matrix model.
#' 
#' @param A A population projection matrix
#' @param initial A numeric vector of the initial stage structured population.
#' Must be the same length as the number of columns of \code{A}
#' @param Gen An integer of the number of generations to run the projection in
#' calculating matrix solutions
#' @param key.thresh Numeric. The cutoff for how to limit most influential 
#' parameters. Based on Elasticities
#' @param plots Should plots be included with the output?
#' @return A list containing:
#' \item{Matrix }{The projection matrix}
#' \item{Projection }{The population projection of solutions}
#' \item{StageProportions }{The proportion each stage of the total population}
#' \item{lambda }{The dominant eigenvalue corresponding to the 
#' growth rate of the population}
#' \item{SDD }{The Stable Stage Distribution corresponding to the 
#' right eigenvector of the dominant eigenvalue} 
#' \item{RV }{The reproductive value corresponding to the left eigenvector
#' of the dominant eigenvalue} 
#' \item{DampingRatio }{Ratio of the dominant eigenvalue to the sub-dominant
#' eigenvalue}
#' \item{Time2Eqm }{How long does it take for the population to
#' reach equilibrium, defined as when the dominant eigenvalue is 20x the
#' sub-dominant eigenvalue}
#' \item{Sensitivity }{Entry-wise sensitivities of each of the matrix
#' parameter entries, the absolute change in lambda with
#' changes in the parameter}
#' \item{SensitivityZero }{Entry-wise sensitivities as above, for \emph{only} 
#' non-zero entries with respect to \code{A}, i.e. parameters with an actual 
#' value in the projection matrix}
#' \item{Elasticity }{Entry-wise elasticities of each of the matrix
#' parameter entries, the proportional change in lambda with
#' changes in the parameter}
#' \item{KeyPars }{Which parameters have Elasticities greater than 
#' the argument determined by \code{key.thresh}, sorted by decreasing "values".
#' Theta is the vector of model parameters}
#' @author Stu Field
#' @seealso \code{\link{calcMatrixSensitivity}}, \code{\link{eigen}}, \code{\link[popbio]{eigen.analysis}}, \code{\link[popbio]{popbio}}
#' @references Caswell, H. Matrix Population Models. 2001.
#' @examples
#' 
#' A <- diag(1:5 / 10)
#' A[cbind(2:5, 1:4)] <- 3:6 / 10
#' A[1, 5] <- 5
#' analyzeProjectionMatrix(A, initial=c(1,3,5,2,1), Gen=100)
#' analyzeProjectionMatrix(A, initial=c(1,3,5,2,1), key.thresh=0.05, Gen=25, plots=FALSE)
#' 
#' @importFrom graphics matplot legend
#' @export analyzeProjectionMatrix
analyzeProjectionMatrix <- function(A, initial, Gen=25, key.thresh=0.1, plots=TRUE) {

   m   <- nrow(A)
   Mx1 <- Mx2 <- matrix(0, nrow=Gen, ncol=m,
                        dimnames=list(paste0("Gen", 1:Gen), paste0("Class", 1:m)))
   Mx1[1, ] <- initial
   
   for ( i in 2:Gen ) {             # project the population
      Mx1[i, 1:m] <- A %*% Mx1[i-1, 1:m]
   } 
   
   Total <- rowSums(Mx1)
   Mx1   <- cbind(Mx1, Total)

   for ( i in 1:Gen ) {
      for ( j in 1:m )
         Mx2[i, j] <- Mx1[i, j] / Total[i]
   }
   
   pars    <- calcMatrixSensitivity(A)
   lambda  <- max(Mod(eigen(A)$values))
   SSD     <- pars$w / sum(pars$w)       # stable stage distribution
   RV      <- 1/pars$v[1] * pars$v       # reproductive value
   rho     <- pars$lambda / Mod(eigen(A, only.values=TRUE)$values[2])
   tEqm    <- log(20) / log(rho)
   S       <- (RV %*% t(SSD)) / c(t(RV) %*% SSD)
   E       <- pars$Elasticity
   theta   <- which(E > key.thresh)
   values  <- E[which(E > key.thresh)]
   keypars <- cbind(theta, values)
   keypars <- keypars[rev(order(keypars[,"values"])),]
   
   if ( plots ) {
      par(mgp=c(2.0,0.75,0.0), mar=c(3,4,3,1))
      par(mfrow=c(2,1))
      matplot(1:Gen, Mx1[,1:ncol(Mx1)-1], 
              type="l", lwd=1.5,
              main="Population Projection by Stage", 
              ylab="No. of Individuals", 
              ylim=range(Mx1),
              xlab="Generations")
      lines(1:Gen, Mx1[,ncol(Mx1)], type="b", lwd=1.5,
            pch=21, bg=2, col=1)
      legend("topleft", legend="Total", lwd=1.5, pch=21, 
             lty=1, col=1, pt.bg=2, bg="gray95")

      matplot(1:Gen, Mx2, type="l", lwd=1.5,
              ylim=range(Mx2),
              main="Stable Stage Distribution", 
              ylab="Proportion of Population", 
              xlab="Generations")
      legend("topleft", legend=paste0("class", 1:ncol(Mx2)),
             lty=1:5, col=1:6, lwd=1, bg="gray95", cex=0.75)
   }
   
   list(Matrix=A,
        Projection=round(Mx1, 5),
        StageProportions=round(Mx2, 5),
        lambda=lambda,
        SSD=SSD,
        RV=RV,
        DampingRatio=rho,
        Time2Eqm=tEqm,
        Sensitivity=pars$Sensitivity,
        SensitivityZero=pars$Sensitivity * as.numeric(A!=0),
        Elasticity=pars$Elasticity,
        KeyPars=keypars)
}
