#' 
#' Remove Column Containing Given Entry(s)
#' 
#' Remove an entire column of a matrix of data frame whose entries contain a
#' given value. Created in SNP analysis data and is similar to the \code{na.omit()}
#' function except we index (and remove) over the columns rather than the rows.
#' 
#' @param X A matrix or data frame
#' @param index Which index to search across, rows (1) or columns (2)
#' @param search Numeric or character. The search parameter for exact match.
#' If contained within any column, that column will be removed
#' @return Matrix or data frame minus column(s) removed as a result of matching
#' \code{index}
#' @note Used in SNP analysis to remove nucleotide positions containing a given
#' character
#' @author Stu Field
#' @seealso \code{\link{na.omit}}
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' M <- matrix(1:25, ncol=5)
#' rm.col(M, index=2, search=20)
#' M <- as.data.frame(M)
#' M[4, 4] <- "A"
#' rm.col(M, index=2, search=c("A", 17))
#' 
#' @export rm.col
rm.col <- function(X, index, search){ 

   rm.cols <- apply(X, index, function(x) any(x %in% search))
   cat(sprintf("Removing col/row:\n", which(rm.cols)))

   if ( index==1 ) {
      X[!rm.cols, ]
   } else {
      X[, !rm.cols] 
   }

}

