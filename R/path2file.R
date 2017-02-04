
#' Determine Path to File
#' 
#' Determine the path of a defined file via brute force search of root
#' directory and optionally change the R working directory to the directory
#' containing that file. Useful in setting the WD prior to a
#' \code{\link{read.csv}} call.
#'
#' If the file in \code{filename} is not found, function is
#' stopped and warning printed.
#'
#' @param file Character string of the desired file, typically \code{"*.R"}
#' or \code{"*.csv"}
#' @param root.dir The path of the root directory. The higher 
#' up the root to travel the longer the search will take
#' If you narrow down the path, more specific, it will take less 
#' time. The default is a Mac/Unix formulation. For Windows/PC machines, 
#' \code{root.dir} must be specified
#' @param switchDir Logical. Set the working directory to the path of the file in
#' \code{file}, if found. Uses setwd().
#' @return The path of the file specified in \code{file}
#' @author Stu Field, Steven Mosher
#' @seealso \code{\link{list.files}}, \code{\link{setwd}}
#' @references Assistance from Steven Mosher via StackOverflow
#' @examples
#' 
#' \dontrun{
#' filename <- "TreeData.csv"
#' path2file(filename)
#' path2file(filename, switchDir=TRUE)
#' read.csv(filename)
#' }
#' 
#' @export path2file
path2file <- function(file, root.dir=Sys.getenv("HOME"),
                      switchDir=FALSE) {

   fullpath <- list.files(path=root.dir, pattern=file,
                          full.names=TRUE, recursive=TRUE)

   path <- dirname(fullpath)

   if ( length(fullpath)==0 )
      stop("File not found!", call.=FALSE)

   if ( switchDir ) {
      if ( getwd()==path ) 
         warning("Path is already the R working directory ... staying put", call.=FALSE)
      cat("Changing R Working Directory to:", "\n")
      setwd(path)
   }

   return(path)

}

