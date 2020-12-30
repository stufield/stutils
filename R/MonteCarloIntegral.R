#' Monte-Carlo Integration
#'
#' Solving indefinite integrals via Monte-Carlo Monte-Carlo integration
#' of any unknown function of "x" via simulation. Calculates the area under
#' the curve by picking numerous points and deciding if that point falls
#' above or below the curve. This demo shows the method of Monte-Carlo
#' and how it can be used to estimate the integral (area under a function)
#' over a given interval of "x". Simulation mimics a random dart thrown
#' on a dartboard style algorithm.
#'
#' When `quick = TRUE`, a quicker implementation is used which uses
#' vectorized random number generation and optional plotting (plotting
#' is slow). This vectorized version is >100x faster than the "slow" version
#' when plotting turned off.
#'
#' @param n Integer. How many points to use in the estimation. Defaults to 10000
#' @param interval Range of "x" over which the function should be evaluated
#' @param FUN The function to integrate. Can be any function
#' @param force Logical. Should a brute force method be used to find
#' the maximum of "y". This can sometimes be useful to avoid missing
#' the global maximum via \code{\link[stats]{optimize}}, but is slower
#' since many points along the function are independently evaluated
#' @param quick Logical. Should a vectorized implementation be used?
#' @param plot Logical. Should the simulation be plotted upon completion?
#' This option is ignored if `quick = FALSE`.
#' @return Numeric estimation of the integral (area below the curve). If
#' `quick = FALSE`, a real-time plot of the function with randomly added
#' points colored by above and below the function is generated
#' @note This demo is for students to visually see how the Monte-Carlo
#' Integration works. Includes an iteration counter & a run time indicator.
#' @author Stu Field, William Black IV!
#' @seealso [optimize()]
#' @references put references to the literature/web site here
#' @examples
#' # set objective function to optimize
#'
#' mysteryFun <- function(x) {
#'   20*dnorm(x, mean = -1, sd = 5) +
#'     ifelse(x > -1.1,
#'     6 * dgamma(x = x + 1, shape = 2, scale = 0.5),
#'     1.5 * dgamma(x = -x, shape = 5,scale= 0.2)) +
#'     2* dgamma(x = 2.75 - x, shape = 3, scale = 0.25)
#' }
#'
#' # compare `quick =`
#'
#' \dontrun{
#' MonteCarloIntegral(n = 10000, interval = c(-2.98, 2.98), FUN = mysteryFun, quick = FALSE)
#' MonteCarloIntegral(n = 10000, interval = c(-2.98, 2.98), FUN = mysteryFun)
#' }
#'
#' # 1000 simulations; package object
#' head(MC_sims)
#' mean(MC_sims)
#'
#' # Plot histogram of 1000 estimates
#' hist(MC_sims, col = "gray75", prob = TRUE, xlab = "Area", main = "", breaks = 15)
#' box()
#' lines(density(MC_sims))
#' lines(density(MC_sims, adjust = 1.75), lty = "dotted", col = 2)
#' par <- density(MC_sims)$x[which.max(density(MC_sims)$y)]
#' abline(v = par, col = 4, lty = "dotted")
#' legend("topleft", legend=sprintf("Area Est ~ 0.3%f", par),
#'        bg = "gray75", cex = 0.75)
#'
#' # check that histogram sums to 1
#' H <- hist(MC_sims, plot = FALSE)
#' print(sum((H$breaks[2]-H$breaks[1]) * H$density), digits = 10)
#' @importFrom graphics points title curve abline par box
#' @importFrom stats runif optimize
#' @export MonteCarloIntegral
MonteCarloIntegral <- function(n = 10000, interval, FUN, force = FALSE,
                               quick = TRUE, plot = FALSE) {

  time1 <- Sys.time()                    # timer 1
  l     <- interval[1]
  r     <- interval[2]                   # left & right limits
  MaxY  <- stats::optimize(f = FUN, interval = interval, maximum = TRUE)$objective
  cols <- c("dodgerblue", "darkred")

  if ( force ) {
    MaxY <- max(FUN(seq(l, r, by = 0.0001))) # using brute force method
  }

  tot_area <- MaxY * (interval[2L] - interval[1L])  # total area (box)

  if ( quick ) {
    x <- runif(n, l, r)                 # random x between l & r
    y <- runif(n) * MaxY                # random y between 0 & 1
    f.x <- FUN(x)                       # y at random x (point on curve)
    p_hits <- length(which(y < f.x)) / n  # proportion hits
  } else {
    par(bg = "thistle")
    curve(FUN, from = l, to = r, ylim = c(0, MaxY), ylab = "f(x)",
          xlab = "", lwd = 1.5, col = "navy")
    abline(v = interval, lty = 2, lwd = 1.5)
    box()
    count <- 0                             # declare counter for hits below curve
    for ( i in 1:n ) {                     # Loop proposals ###
      if ( i %% 1000 == 0 ) {
        cat("* Iteration ...", i, "\n")
      }
      x   <- runif(1, l, r)                 # random x between l & r
      y   <- runif(1) * MaxY                # random y between 0 & 1
      f_x <- FUN(x)                       # y at random x (point on curve)
      if ( y < f_x ) {
        count <- count + 1               # count if below curve
        points(x, y, cex = 0.2, pch = 20, col = cols[1L])
      } else {
        points(x, y, cex = 0.2, pch = 20, col = cols[2L])
      }
    }
    p_hits   <- count / n                  # proportion hits
    title(main = sprintf("Integral (Area) = %0.4f", tot_area * p_hits),
          font.lab = 4, cex.lab = 1.5)
  }

  runTime  <- Sys.time() - time1            # timer 2
  usethis::ui_done("Run Time = {runTime} seconds")

  if ( plot && quick ) {
    par(bg = "thistle")
    curve(FUN, from = l, to = r, ylim = c(0, MaxY),
          ylab = "f(x)", xlab = "", lwd = 1.5, col = "navy")
    abline(v = interval, lty = 2, lwd = 1.5)
    box()
    points(x[which(y < f_x)], y[which(y < f_x)], cex = 0.2, pch = 20, col = cols[1L])
    points(x[which(y > f_x)], y[which(y > f_x)], cex = 0.2, pch = 20, col = cols[2L])
    title(main = sprintf("Integral (Area) = %0.4f", tot_area * p_hits),
          font.lab = 4, cex.lab = 1.5)
  }
  # return area under curve (integral)
  return(tot_area * p_hits)
}
