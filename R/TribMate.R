#' 
#' Tribolium Mating Subrouting
#' 
#' A sub-routine used to determine the number of offspring produced by the
#' current population according to Hardy-Weinberg predictions. Used in
#' \code{Tribolium9()} where only the top class (adults) mates.
#' 
#' @param Y A matrix containing an intermediate population with the classes as
#' rows & genotypes as cols. Columns should be ordered AA, Aa, aa. Only the
#' final class mates.
#' @param f Integer representing the fecundity (i.e. egg production) of the
#' female mating partner. Number of offspring produced per reproductive adult.
#' @return A matrix of identical dimensions to Y containing non-zero entries in
#' the first row only representing the newly produced offspring (eggs) in the
#' population. This matrix can then simply be added to the current, or
#' intermediate, solution to obtain the current solution.
#' @note Used in FEScUE for \code{Tribolium9()}.
#' @author Stu Field, Jesse Drendel
#' @references Tribolium Example from Caswell (2008); pg 71 \cr Perturbation
#' analysis of nonlinear matrix popn models \cr Demographic Research 18: 59-116
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' ### See Tribolium9() ###
#' 
#' @export TribMate
TribMate <- function(Y, f) {

   Offspring <- matrix(0, nrow=nrow(Y), ncol=ncol(Y))
   nAA <- Y[3, 1]
   nAa <- Y[3, 2]
   naa <- Y[3, 3]
   Total <- nAA + nAa + naa        # total number of reproductive adults

   if ( Total > 0 ) {
      p <- (nAa + 2 * nAA) / (2 * Total)
      q <- (nAa + 2 * naa) / (2 * Total)
      # ---------------------------
      fnAA <- f * nAA
      fnAa <- f * nAa
      fnaa <- f * naa
      # ---------------------------
      FAA <- p * (fnAa / 2 + fnAA)
      FAa <- q * (fnAa / 2 + fnAA) + p * (fnAa / 2 + fnaa) # heterozygotes
      Faa <- q * (fnAa / 2 + fnaa)
      # ---------------------------
      Offspring[1,] <- c(FAA, FAa, Faa)
   }

   return(Offspring)

}
