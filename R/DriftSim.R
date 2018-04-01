
#' Genetic Drift Simulation
#' 
#' Performs an illustrative simulation of genetic drift.
#' 
#' @param p.star Initial allelic frequency of the p allele.
#' @param n Integer. Number of individuals in the population.
#' @param nsim Integer. Number of simulations to perform.
#' @param plot Plot both histogram and drift with time (default) or just
#' histogram ("h") or just line graph ("l").
#' @return A plot of the simulation is returned.
#' @note Simulation written for FEScUE class
#' @author Stu Field
#' @seealso \code{\link{DriftSim2}}
#' @references Department of Biology, Colorado State University,
#' Fort Collins, CO 80523-1878.
#' @examples
#' 
#' \dontrun{
#' DriftSim()
#' }
#' 
#' @importFrom graphics hist legend plot
#' @importFrom stats median
#' @export DriftSim
DriftSim <- function(p.star = 0.5, n = 50, nsim = 50, plot = "b") {

  time1 <- Sys.time()
  pMat <- matrix(NA, nrow = 5000, ncol = nsim)

  # Run the simulation
  for ( i in 1:nsim ) {
    Gametes <- c(rep("A", 2 * n * p.star), rep("a", 2 * n * (1 - p.star))) 
    p     <- p.star
    p.vec <- p.star
    while ( p > 0 && p < 1 ) {
      s <- sample(Gametes, 2*n, replace = TRUE)
      p <- length(which(s == "A")) / (2 * n) 
      p.vec <- c(p.vec, p)
      Gametes <- s
    }
    pMat[1:length(p.vec), i] <- p.vec
  }

  # Mean time to fixation/extinction
  # vector of fix.ext times
  Fit.Ext   <- apply(pMat, 2, function(x) min(which(x == 0 | x == 1)))
  MeanFix   <- mean(Fit.Ext)
  MedianFix <- median(Fit.Ext)

  ##############################
  ### Clip off matrix at point #
  ### where alleles are ########
  ### either fixed or extinct ##
  ##############################
  clip <- max(Fit.Ext)
  pMat <- pMat[1:clip, ]

  runTime <- Sys.time() - time1
  cat("Sim Time =", runTime, "s", "\n")
  ######################################
  ### Plot simulations #################
  ######################################
  ### Histogram of the time to fixation
  ######################################
  if ( plot == "h" || plot == "b" ) {
    hist(Fit.Ext, col="gray75",
         xlab = "Time (generations)",
         main = "Time to fixation/extinction via Drift")
    legend("topright",
           legend = c(paste("Mean", format(MeanFix)), 
                      paste("Median", format(MedianFix))), 
           lwd = 2, ncol=2, col = c("navy", 2),
           bg = "gray95", box.lty = 0, cex = 0.85)
    abline(v = MeanFix, col = "navy", lwd = 2, lty = 2)
    abline(v = MedianFix, col = 2, lwd = 2, lty = 2)
  }

  # Plotting drift of the p-allele by simulation
  if ( plot == "l" || plot == "b" ) {
    plot(1:clip, pMat[,1], type = "n", ylab = "Allele Frequency (p)",
         xlab = "time", ylim = c(0, 1), main = "Genetic Drift Simulation",
         sub = paste("nsim =", format(nsim)))
    for ( n in 1:nsim ) {
      lines(1:clip, pMat[, n], col = n)
    }
  }

}

