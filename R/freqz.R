#' 
#' Allelic Frequencies
#' 
#' Calculate allele frequencies (p, q) from population count
#' data. Number of individuals must be in the form c(AA, Aa, aa).
#' 
#' If necessary, more details than the description above
#' 
#' @param x Vector containing the counts for each of the three
#' genotypes: AA, Aa, aa
#' @return A vector of length 2 in the form c(p, q) or c(freq.A, freq.a).
#' @note further notes
#' @author Stu Field
#' @references Hardy-Weinberg and many others...
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' pop <- c(AA=123, Aa=45, aa=88)
#' freqz(pop)
#' 
#' @export freqz
freqz <- function(x) {
   A <- unname((2*(x[1]) + x[2]) / (sum(x)*2))
   a <- unname((2*(x[3]) + x[2]) / (sum(x)*2))
   c(A=A, a=a)
}
