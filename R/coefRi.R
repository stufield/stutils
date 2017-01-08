
#' Calculate Interclass Correlation Coefficient (ICC)
#' 
#' The Intraclass correlation coefficient (r_i; aka ICC) can be used to
#' estimate the repeatability of a method. The value 0 -> 1. Depending on how
#' the groups are set up, you want all your variation to be among groups
#' (individuals), not within groups (repeats) so you want this value to be high
#' if individuals are your groups, and low if your repeated measurements are
#' the groups. When ICC is high, it means most of the variation is
#' \emph{between} treatment groups.
#' 
#' %% ~~ If necessary, more details than the description above ~~
#' 
#' @param x A matrix or data frame containing the raw data of the various
#' treatments you are testing in the ANOVA
#' @param groups A vector of the factor groupings for x
#' @param do.log Should data be performed on log10-transformed?
#' @return A list containing:
#' \item{model }{Resulting ANOVA table}
#' \item{ICC }{The intraclass correlation coefficient, the measure of
#' similarity among individuals \emph{within} a treatment
#' group relative to the differences found \emph{among} groups}
#' @note %% ~~further notes~~
#' @author Stu Field
#' @seealso \code{\link{aov}}
#' @references Sokal & Rohlf (Biometry; 3rd ed.) 210-214. Sokal & Rohlf
#' (Biometry; 2rd ed.) 211-216.
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' head(Ri_data)    # internal data
#' x <- as.vector(as.matrix(Ri_data))[ !is.na(as.vector(as.matrix(Ri_data))) ]
#' coefRi(x, groups=rep(names(Ri_data), c(8, 10, 13, 6)))
#' 
#' @importFrom stats aov
#' @importFrom magrittr '%<>%' '%>%'
#' @export coefRi
coefRi <- function(x, groups, do.log=TRUE) {

   groups <- factor(groups)

   if ( do.log )
      x %<>% log10

   model <- summary(aov(x ~ groups))

   # Calculate average sample size
   n_i <- table(groups)
   n_o <- (1 / (length(n_i)-1)) * ( sum(n_i) - (sum(n_i^2) / sum(n_i)) )

   # Calculate r_i
   MS.among  <- model[[1]][1, "Mean Sq"]
   MS.within <- model[[1]][2, "Mean Sq"]
   s.Asq <- (MS.among - MS.within) / n_o
   r_i <- s.Asq / (MS.within + s.Asq)
   list(Model=model, ICC=r_i)

}

