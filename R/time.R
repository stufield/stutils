#' 
#' Determine Time from Seconds (vice versa)
#' 
#' \code{\link{time2seconds}} and \code{\link{seconds2time}} determine the
#' time (format="hh:mm:ss.ss") from the value in seconds or vice versa. Two
#' digit hour precision optional.
#' 
#' @aliases time2seconds seconds2time
#' @param x Character. Of the form \code{"hh:mm:ss.ss"} with 2 decimal point
#' precision on the seconds to convert to seconds, OR\cr Numeric. Representing
#' seconds to convert to a character string of the form \code{"hh:mm:ss.ss"}.
#' @return Either number of seconds (\code{numeric} or the time format
#' (\code{string}) in "hh:mm:ss.ss".
#' @note %% ~~further notes~~
#' @author Stu Field
#' @seealso \code{\link[base]{strsplit}}, \code{\link[base]{gsub}},
#' \code{\link[base]{grepl}}, \code{\link[base]{sprintf}}
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' seconds2time(159.72)
#' time2seconds("3:44:12.04")
#' time2seconds("15:44:12.04")
#' 
#' @export seconds2time
seconds2time <- function(x) {

   hours <- x %/% 3600
   mins <- (x %% 3600) %/% 60
   secs <- ((x %% 60) %% 60) %% 60
   decimals <- gsub(".*[0-9][.]","",sprintf("%.2f",secs))
   #print(list(hours,mins,secs,decimals))
   sprintf("%01d:%02d:%02d.%s", hours, mins, round(secs,0), decimals)

}
 


#' @rdname seconds2time
#' @export time2seconds
time2seconds <- function(x) {

   format.check <- grepl("^[0-9]{1,2}:[0-9]{2}:[0-9]{2}[.][0-9]{1,2}$", x)
   if ( !format.check )
		stop("Incorrect time format ... check time format is 'hh:mm:ss.ss'", call.=FALSE)
	char.split <- strsplit(x, split=":", fixed=TRUE)[[1]]
	convert <- as.numeric(char.split)
	hr <- convert[1]
	min <- convert[2]
	sec <- convert[3]
	return(hr*60 + min*60 + sec)

}
