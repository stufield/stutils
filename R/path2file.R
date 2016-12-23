#' 
#' Determine Path to File
#' 
#' Determine the path of a defined file via brute force search of root
#' directory and optionally change the R working directory to the directory
#' containing that file. Useful in setting the WD prior to a
#' \code{\link{read.csv}} call.
#' 
#' @param filename Character string of the desired file, typically \code{"*.R"}
#' or \code{"*.csv"}.
#' @param root.dir The path of the root directory. The higher up the root to
#' travel the longer the search will take. If you narrow down the path, more
#' specific, it will take less time. The default is a Mac/Unix formulation. For
#' Windows/PC machines, ROOT must be specified.
#' @param setdir Logical. Set the working directory to the path of the file in
#' \code{filename}, if found. Uses setwd().
#' @return The path of the file declared in "filename".
#' @note %% ~~further notes~~
#' @section Warning! : If the file in \code{filename} is not found, function is
#' stopped and warning printed.
#' @author Stu Field, Steven Mosher
#' @seealso \code{\link{list.files}} \cr \code{\link{setwd}}
#' @references %% ~put references to the literature/web site here ~
#' @keywords ~kwd1 ~kwd2
#' @examples
#' 
#' \dontrun{
#' filename <- "TreeData.csv"
#' path2file(filename)
#' path2file(filename, setdir=TRUE)
#' read.csv(filename)
#' }
#' 
#' @export path2file
path2file <- function(filename, root.dir= "~/Dropbox/r_scripts", setdir=FALSE) {

   fullpath <- list.files(root.dir, full.names=TRUE,
                          recursive=TRUE, pattern=filename)
   path <- dirname(fullpath)

   if ( length(fullpath)==0 ) 
      stop("File not found!")

   if ( setdir ) {
      if ( getwd()==path ) 
         stop("Stop! Path is already the R working directory!")
      cat("Changing R Working Directory to:", "\n")
      setwd(path)
   }

   path

}

