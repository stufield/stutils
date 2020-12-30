#' Genetic Drift Simulation 2
#' 
#' Performs a simulation of genetic drift according to 
#' the one described in the
#' Evolution & Ecology Excel spreadsheets manuals.
#' 
#' @param p Numeric. Initial allelic frequency in for each of the simulations.
#' @param Gen Integer. Generations to run each simulation.
#' @param n Integer. Number of individuals in each of the trials.
#' @param trials Integer. Number of simulations to run.
#' @return A list containing:
#' \item{p_mat}{A matrix composed of the simulation of each of the
#'   drift simulations following the allelic frequency p.} 
#' \item{P_fix}{The proportion of the time the p allele becomes fixed 
#'   in the population. Should approach 0.5 when trials increases.}
#' @author Stu Field
#' @seealso [DriftSim()]
#' @examples
#' \dontrun{
#' set.seed(501)
#' DriftSim2(p = 0.5, Gen = 100, n = 10, trials = 20)
#' }
#' @importFrom graphics matplot grid box
#' @export
DriftSim2 <- function(p, Gen, n, trials) {

  for ( i in 1:trials ) {
    Gametes <- c(rep("A1", 2 * n * p), rep("A2", 2 * n * (1 - p))) 
    p_vec <- length(which(Gametes == "A1")) / (2 * n) 
    for ( j in 2:Gen ) {
      s <- sample(Gametes, 2 * n, replace = TRUE) 
      p_vec[j] <- length(which(s == "A1")) / (2 * n) 
      Gametes <- s
    }
    if ( i == 1 ) {
      p_mat <- p_vec 
    } else {
      p_mat <- cbind(p_mat, p_vec)
    }
  }

  # ------------------------- #
  # Plot Change over time
  # ------------------------- #
  matplot(p_mat, type = "n", ylim = c(0, 1), 
          xlim = c(1, Gen), 
          main = expression(paste("Frequency of ", italic(A)[1L], " over time")), 
          xlab = "Generation", 
          ylab = (expression(paste("Frequency of the ", italic(A)[1L], " allele"))), 
          sub = paste("n = ", format(n))) 
  grid(NA, NULL, lty = 1, lwd = 1, col = "gray90")
  box() 
  matplot(p_mat, type = "b", pch = c(2, 15:18), cex = 0.75, add = TRUE) 
  legend("topleft", legend=c("Pop1", "Pop2", "Pop3", "Pop4", "Pop5"), 
         pch = c(2, 15:18), lty = 1:5, col = 1:5, bg = "gray95",
         box.lty = 0, cex = 0.75) 

  P_fix <- length(which(p_mat[Gen, ] == 1.0)) / trials 
  list(p_mat = p_mat, P_fix = P_fix)
}
