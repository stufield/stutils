#' 
#' Packing Punnett Map Solutions (FEScUE)
#' 
#' Used to pack and unpack the "Punnett Square" formulation for Tribolium model
#' in FEScUE. Each slice of the 3D array is a "punnett square" that is:\cr [AA
#' Aa \cr aA aa]
#' 
#' %% ~~ If necessary, more details than the description above ~~
#' 
#' @param x The object to be packed into an array. Typically a vector of length
#' = nallele^2 * nstages.
#' @param nallele Number of alleles
#' @param nstages Number of base stages.
#' @return A 3-dim array with dim = c(nallele, nallele, nstages)
#' @note Based on the Jesse Drendel formulation of the Tribolium model in
#' FEScUE for the Tribolium Project.
#' @author Stu Field, Jesse Drendel
#' @seealso %% ~~objects to See Also as \code{\link{help}}, ~~~
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' PunnettPack(1:24, nallele=2, nstages=6)
#' 
#' @export PunnettPack
PunnettPack <- function(x, nallele, nstages) {

   if ( length(x) != nallele^2*nstages ) # dim check
      stop("Error in dimensions")

   A  <- array(0, dim=c(nallele, nallele, nstages))    # empty array
   lo <- seq(1, length(x) - nallele^2 + 1, nallele^2)  # lower vector
   hi <- seq(nallele^2, length(x), nallele^2)          # upper vector

   for (i in 1:nstages) {
      A[,,i] <- x[lo[i]:hi[i]]
   }

   A
}

