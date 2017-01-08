
#' Tree Data
#' 
#' Data set containing tree characteristic metric data, that has been blinded
#' and anonymized from its original source. Used heavily in the \code{R}
#' tutorial and for general data frame usage (e.g. package testing).
#' 
#' @name TreeData
#' @docType data
#' @format A data frame containing 20 cases and numerous random variables
#' @references Originally from Sala et al., but heavily modified to be
#' unrecognizable and used as the main example data set for the R tutorial.
#' @source Stu Field
#' @examples
#' head(TreeData)
#' apply(TreeData[,5:ncol(TreeData)], 2, mean)
#' @keywords R_tutorial
NULL

#' 6 Class Population Projection
#' 
#' This data set it the data produced by the projection for the 6 class example
#' used in the R tutorial
#' 
#' @name popdata
#' @aliases popdata
#' @docType data
#' @format A matrix of the 6-class population projection with classes
#' as columns and the map/step solutions as the rows
#' @references Stu Field, The R Tutorial.
#' @source Stu Field
#' @examples
#' head(popdata, 10)
#' @keywords R Tutorial
NULL

#' Coefficient Interclass Correlation Data Example
#' 
#' Coefficient Interclass Correlation Data Example from Sokal & Rolff
#' (Biometry; 3rd ed.), pages 210-214.
#' 
#' @name Ri_data
#' @docType data
#' @format A data frame of data with treatments as columns and rows as
#' cases
#' @references Sokal & Rolff (Biometry; 3rd ed.), p. 210-214.
#' @source Stu Field
#' @examples
#' Ri_data
#' @keywords Ri
NULL

#' Monte-Carlo Integration Simulation
#' 
#' Vector containing 1000 simulation estimates of the 
#' Monte-Carlo integral estimate (area under curve) for a 
#' given function. The simulation is time greedy so these 
#' data are saved as an object.
#' 
#' @name MC_sims
#' @aliases MC_sims
#' @docType data
#' @format Vector containing the estimates of the Monte-Carlo simulation of the
#' integral of a given function
#' @references Stu Field
#' @source Bill Black
#' @examples
#' head(MC_sims)
#' tail(MC_sims)
#' mean(MC_sims)
#' hist(MC_sims)
#' @keywords Student Demo
NULL

#' Infection data by US County
#' 
#' Infection data describing the infections count data of an infectious disease
#' by geographic position. Includes the following headings: \cr
#' CountyNo \cr
#' CountyName \cr
#' State \cr
#' Fips \cr
#' Site \cr
#' Lat \cr
#' Long \cr
#' Population \cr
#' Area \cr
#' Density \cr
#' Infected
#' 
#' @name InfectionByCounty
#' @docType data
#' @format A data frame containing over 3000 individual cases
#' @references Infection data originally from Dylan George and 
#' used for an exercise data set in the EEID R tutorial. 
#' @source Stu Field
#' @examples
#' head(InfectionByCounty)
#' @keywords R tutorial
NULL


