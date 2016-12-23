#' 
#' Genetic Drift Simulation 2
#' 
#' Performs a simulation of genetic drift according to the one described in the
#' Evolution & Ecology Excel spreadsheets manuals
#' 
#' If necessary, more details than the description above
#' 
#' @param p Numeric. Initial allelic frequency in for each of the simulations
#' @param Gen Numeric. How many generations to run each simulation
#' @param n Integer. Number of individuals in each of the trials
#' @param trials Integer. Number of simulations to run
#' @return A list containing:
#' \item{p.mat }{A matrix composed of the simulation of each of the
#' drift simulations following the allelic frequency p.} 
#' \item{P.fix }{The proportion of the time the p allele becomes fixed 
#' in the population. Should approach 0.5 when trials increases.}
#' @note %% ~~further notes~~
#' @author Stu Field
#' @seealso \code{\link{DriftSim}}
#' @references Evolutionary Ecology Tutorials in Excel - Workbook.
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' \dontrun{
#' set.seed(501)
#' DriftSim2(p=0.5, Gen=100, n=10, trials=20)
#' }
#' 
#' @export DriftSim2
DriftSim2 <- function(p, Gen, n, trials) {

   for (i in 1:trials) {
      Gametes <- c(rep("A1", 2*n*p), rep("A2", 2*n*(1-p))) 
      p.vec <- length(which(Gametes=="A1")) / (2*n) 
      for (j in 2:Gen) {
         s <- sample(Gametes, 2*n, replace=TRUE) 
         p.vec[j] <- length(which(s=="A1")) / (2*n) 
         Gametes <- s
      }
      if (i==1) {
         p.mat <- p.vec 
      } else {
         p.mat <- cbind(p.mat, p.vec)
      }
   }

   # ------------------------- #
   ## Plot Change over time
   # ------------------------- #
   matplot(p.mat, type="n", ylim=c(0,1), 
           xlim=c(1, Gen), 
           main=expression(paste("Frequency of ",italic(A)[1]," over time")), 
           xlab="Generation", 
           ylab=(expression(paste("Frequency of the ",italic(A)[1]," allele"))), 
           sub=paste("n = ",format(n))) 
   grid(NA, NULL, lty=1, lwd=1, col="gray90")
   box() 
   matplot(p.mat,
           type="b",
           pch=c(2, 15:18),
           cex=0.75, add=TRUE) 
   legend("topleft", 
      legend = c("Pop1","Pop2","Pop3","Pop4","Pop5"), 
      pch = c(2,15:18), 
      lty = 1:5, 
      col = 1:5, 
      bg = "gray95", 
      box.lty = 0, 
      cex = 0.75) 
   # ---------- #
   # output
   # ---------- #
   P.fix <- length(which(p.mat[Gen,]==1.0)) / trials 
   list(p.mat=p.mat, P.fix=P.fix)
}


