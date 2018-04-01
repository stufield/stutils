 
#' Assign Rdata Contents to a Variable
#' 
#' Assigns the contents of a binary \code{*.Rdata} or \code{*.rda} 
#' file to a variable rather than loading it directly into the 
#' global environment. Useful for avoiding unexpected collisions 
#' with variables in the current global environment.
#' 
#' @param file The character path to an \code{*.Rdata} or \code{*.rda} file.
#' @return If the binary Rdata file only contains a single object then
#' this object is returned. If the file contains more than one object,
#' a named list is returned.
#' @author Mike Mehan
#' @seealso \code{\link{load}}.
#' @examples
#' 
#' \dontrun{
#' assignRData("path/to/myfile.rda")
#' }
#' 
#' @export assignRData
assignRData <- function(file) {
  e <- new.env()
  load(file, envir=e)
  out <- as.list(e)
  if ( length(out) == 1 ) {
    out <- out[[1]]
  }
  return(out)
}

