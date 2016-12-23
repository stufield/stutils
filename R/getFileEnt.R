#' 
#' Get File Extension
#' 
#' Function to return the file extension of a character string given a path
#' name to a file.
#' 
#' %% ~~ If necessary, more details than the description above ~~
#' 
#' @param x Character. String of the file name. Can be absolute or relative
#' path, or just the basename.
#' @return A string containing the extension of the file name passed in
#' \code{x}.
#' @note %% ~~further notes~~
#' @author Stu Field
#' @seealso \code{\link[base]{regexpr}}, \code{\link[base]{substring}}
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' 
#' getFileExt("file.pdf")
#' getFileExt("/home/full/path/to/file.pdf")
#' 
#' 
#' @export getFileExt
getFileExt <- function(x) {
	y   <- basename(x)
	pos <- regexpr("\\.([[:alnum:]]+)$", y)
	ifelse(pos > -1L, substring(y, pos + 1L), "")
}
