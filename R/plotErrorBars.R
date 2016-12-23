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
#' @param pad Additional spacing (as a percent) to pad the y-axis limits
#' @param ylims The y-axis limits to pass to \code{plotfun}
#' @param ... Additional arguments passed to either \code{\link[graphics]{barplot}}
#' , \code{\link[graphics]{plot}}, or \code{\link[graphics]{plot}}
#' @return A plot with error bars plotted on top defined by \code{up} and
#' \code{lo}.
#' @author Stu Field
#' @seealso \code{\link[gplots]{plotCI}}, \code{\link[graphics]{barplot}}, \code{\link[graphics]{plot}}, \code{\link[graphics]{lines}}
#' @references Michael Crowley. The R Book. 2007.
#' @examples
#' 
#' x <- rnorm(10)
#' plotErrorBars(x, lo=x-sd(x), up=x+sd(x))
#' 
#' @export plotErrorBars
plotErrorBars <- function(x, lo, up, plotfun=graphics::barplot, bar.col=1, ylims=NULL,
								  bar.lty=1, bar.cex=0.33, bar.lwd=1, pad=0.05, ...) {

	if ( length(x) != length(lo) || length(x) != length(up) )
		stop("Lengths of values and confidence intervals must all be equal", call.=FALSE)

	if ( is.null(ylims) )
		ylims <- range(c(lo, up)) * (1+pad)

	if ( grepl("barplot$",deparse(substitute(plotfun))) ) {
		ylims[1] <- min(0, ylims[1])
		xlims <- NULL
		y <- plotfun(x, ylim=ylims, plot=FALSE, ...)
		g <- bar.cex * mean(diff(as.numeric(y)))/2
	} else {
		y <- seq_along(x)
		g <- bar.cex * 0.2
		xlims <- c(0.75, length(x)+0.25)
	} 

	plotfun(x, ylim=ylims, xlim=xlims, ...)

	for ( i in seq_along(y) ) {
		lines(c(y[i], y[i]), c(up[i], lo[i]), col=bar.col, lty=bar.lty, lwd=bar.lwd)			# error bar
		lines(c(y[i]-g, y[i]+g), c(up[i], up[i]), col=bar.col, lty=bar.lty, lwd=bar.lwd)		# top bar
		lines(c(y[i]-g, y[i]+g), c(lo[i], lo[i]), col=bar.col, lty=bar.lty, lwd=bar.lwd)		# bottom bar
	}
}


##############################################
### Produce necessary arguments for error.bars
##############################################
# f <- factor(rep(LETTERS[1:4],each=20))
# x <- runif(80)
# data <- data.frame(x,f)
# N <- as.numeric(table(data$f))
# FactorMeans <- tapply(data$x, data$f, mean)
# sd <- tapply(data$x, data$f, sd)
# sem <- sd/sqrt(N)
# ci <- (FactorMeans + (sem * 1.96)) - (FactorMeans - (sem * 1.96))
# labels <- as.factor(levels(data$f))


##################################################
### Make the Barplot with Error Bars (SEMs & CIs)
##################################################
#par(mfrow=c(1,2))
# error.bars(FactorMeans, sem, labels, axis=2); title("Barplot with SEM bars")
#error.bars(FactorMeans, ci, labels, bcol=c(1,8), lcol=2, type=4, w=50); title("Barplot with CI95 bars")




##############################
### Points with Error Bars
##############################
#require(gplots)
#f <- factor(rep(LETTERS[1:4], each=20))
#x <- runif(length(f))
#data <- data.frame(x,f)
#N <- as.numeric(table(data$f))
#Means <- tapply(data$x, data$f, mean)
#sd <- tapply(data$x, data$f, sd)
#sem <- sd/sqrt(N)
#ci <- (Means + (sem * 1.96)) - (Means - (sem * 1.96))
#Treatments <- c(A=1,B=2,C=3,D=4)
#
#par(mfrow=c(1,2))
#plotCI(Treatments, Means, uiw=sem, pch=19, xaxt='n'); axis(1, 1:length(Treatments), LETTERS[1:length(Treatments)])
#plotCI(Treatments, Means, uiw=ci, pch=19, xaxt='n'); axis(1, 1:length(Treatments), LETTERS[1:length(Treatments)])
