#' 
#' Plot Error Bars
#' 
#' Produce a barplot (or points) containing plot error bars.
#' 
#' @param x Summary data to plot into a barplot, typically a vector of the bar
#' heights or points
#' @param lo Numeric. A vector of heights of the \emph{lower} error bars to be drawn.
#' Must be computed externally and passed into the function
#' @param up Numeric. A vector of heights of the \emph{upper} error bars to be drawn.
#' Must be computed externally and passed into the function
#' @param plotfun Currently one of: \code{barplot, points, or plot}. Note:
#' plot or points produce the same output
#' @param bar.col Colour of the error bars and lines
#' @param bar.lty Line type for the error bars. Argument is passed eventually
#' to \code{\link[graphics]{lines}}, \code{options=1:5}
#' @param bar.cex Character expansion for the width of the error bars
#' (hat/base) in units of \emph{bar widths}
#' @param bar.lwd Line width for the error bars (\code{=lwd}) passed to
#' \code{\link[graphics]{lines}}
#' @param pad Additional spacing, as a proportion of the y-value range, 
#' to pad the y-axis limits
#' @param ylims The y-axis limits to pass to \code{plotfun}
#' @param ... Additional arguments passed to either \code{\link[graphics]{barplot}}
#' , \code{\link[graphics]{plot}}, or \code{\link[graphics]{plot}}
#' @return A plot with error bars plotted on top defined by \code{up} and
#' \code{lo}.
#' @author Stu Field
#' @seealso \code{\link[gplots]{plotCI}}, \code{\link[graphics]{barplot}}, \code{\link[graphics]{plot}}, \code{\link[graphics]{lines}}
#' @references Heavily modified from The R Book. 2007. Michael Crowley.
#' @examples
#' 
#' x <- rnorm(10)
#' plotErrorBars(x, lo=x-sd(x), up=x+sd(x))
#' 
#' # Barplot with Error Bars (SEMs & CIs)
#' set.seed(101)
#' f <- factor(rep(LETTERS[1:4], each=20))
#' x <- runif(80)
#' data <- data.frame(x, f)
#' GroupMeans <- tapply(data$x, data$f, mean)
#' GroupSD <- tapply(data$x, data$f, sd)
#' sem <- GroupSD / sqrt(length(GroupMeans))
#' ci <- (GroupMeans + (sem * 1.96)) - (GroupMeans - (sem * 1.96))
#'
#' par(mfrow=c(1,2))
#' plotErrorBars(GroupMeans, lo=GroupMeans-sem, up=GroupMeans+sem)
#' plotErrorBars(GroupMeans, lo=GroupMeans-ci, up=GroupMeans+ci)
#' 
#' # Points with Error Bars
#' plotErrorBars(GroupMeans, lo=GroupMeans-sem, up=GroupMeans+sem, plotfun=plot,
#'               bar.col=2, bar.lwd=2, pch=21, bg=4, cex=2)
#' 
#' @importFrom graphics lines barplot plot
#' @export plotErrorBars
plotErrorBars <- function(x, lo, up, plotfun=graphics::barplot, bar.col=1, ylims=NULL,
								  bar.lty=1, bar.cex=0.33, bar.lwd=1, pad=0.05, ...) {

	if ( length(x) != length(lo) || length(x) != length(up) )
		stop("Lengths of values and confidence intervals must all be equal", call.=FALSE)

	if ( is.null(ylims) ) {
		rng <- range(c(lo, up))
      stretch <- diff(rng) * pad
		ylims <- rng + stretch * c(-1,1)
   }

	if ( grepl("barplot$", deparse(substitute(plotfun))) ) {
		ylims[1] <- min(0, ylims[1])
		xlims <- NULL
		y <- plotfun(x, ylim=ylims, plot=FALSE, ...)
		g <- bar.cex * mean(diff(as.numeric(y))) / 2
	} else {
		y <- seq_along(x)
		g <- bar.cex * 0.2
		xlims <- c(0.75, length(x) + 0.25)
	} 

	plotfun(x, ylim=ylims, xlim=xlims, ...)

	for ( i in seq_along(y) ) {
		lines(c(y[i], y[i]), c(up[i], lo[i]), col=bar.col, lty=bar.lty, lwd=bar.lwd)			# error bar
		lines(c(y[i]-g, y[i]+g), c(up[i], up[i]), col=bar.col, lty=bar.lty, lwd=bar.lwd)		# top bar
		lines(c(y[i]-g, y[i]+g), c(lo[i], lo[i]), col=bar.col, lty=bar.lty, lwd=bar.lwd)		# bottom bar
	}
}


