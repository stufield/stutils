
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis Build
Status](https://travis-ci.org/stufield/stuRpkg.svg?branch=master)](https://travis-ci.org/stufield/stuRpkg)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/stufield/stuRpkg?branch=master&svg=true)](https://ci.appveyor.com/project/stufield/stuRpkg)
[![CRAN\_Status](http://www.r-pkg.org/badges/version/stuRpkg)](https://cran.r-project.org/package=stuRpkg)
[![codecov](https://codecov.io/gh/stufield/stuRpkg/branch/master/graph/badge.svg)](https://codecov.io/gh/stufield/stuRpkg)

-----

# The R `stuRpkg` library

## Overview

Small suite of useful functions, subroutines, and data objects for data
set manipulation and analysis in R.

-----

## Installation

To install the latest `development` version of `stuRpkg` from
**GitHub**:

``` r
devtools::install_github("stufield/stuRpkg")
```

### Datasets

  - **nyflights13**
      - new york city airport flight data from 2013 (**must install**)
      - install with `install.packages("nyflights13",
        repos="http://cran.rstudio.com")`
  - **TreeData**
      - Sala et. al.
  - **popdata**
      - This data set it the data produced by the projection for the 6
        class example used in the EEID R tutorial.
  - **Ri\_data**
      - Coefficient Interclass Correlation Data Example from Sokal &
        Rohlf (Biometry; 3rd ed.), pages 210-214.
  - **MC\_sims**
      - Vector containing 1000 simulation estimates of the Monte-Carlo
        integral estimate (area under curve) for a given function. The
        simulation is time greedy so these data are saved as an object.
  - **InfectionByCounty**
      - Infection data describing the infections count data of an
        infectious disease by geographic position for 3082 individual
        cases.
      - Source: Dylan George, EEID 2008
  - **test\_data**
      - A quick sample tibble data frame for running examples and
        checking data frame functionalities. See `?tibble`.
      - The format of `test_data`
is:

|         Column | Definition                                                                    |
| -------------: | :---------------------------------------------------------------------------- |
|            pid | `1041:1080`                                                                   |
|            Pop | `rep(head(LETTERS, 10), 4)`                                                   |
|         Sample | `factor(sample(c("small", "medium", "large"), 40, replace = TRUE))`           |
|      TimePoint | `factor(rep(c("baseline", "6 months", "12 months", "24 months"), each = 10))` |
|              a | `round(rnorm(40, mean = 25, sd = 3.5), 0)`                                    |
|              b | `sample(0:6, 40, replace = TRUE)`                                             |
| ABCD.1234.56.8 | `rnorm(40, 25, 3.5)`                                                          |
|  XYZZ.6969.4.7 | `rnorm(40, 25, 1.5)`                                                          |
|              x | `rnorm(40, mean = 5, sd = 3)`                                                 |
|              y | `round(runif(40, 10, 20), 0)`                                                 |
|              z | `round(rnorm(40, mean = 1, sd = 0.5), 3))`                                    |
|       Response | `factor(sample(c("control", "disease"), 40, replace = TRUE)))`                |

-----

## Links

### Hadley Wickham Book

[R for Data Science](http://r4ds.had.co.nz/)

### RStudio Cheatsheets:

  - [Cheat sheet
    webpage](https://www.rstudio.com/resources/cheatsheets/)
  - [GitHub Cheatsheet
PDFs](https://github.com/rstudio/cheatsheets)

### Fitting Distributions

<img width="669" alt="fitting_distns" src="https://user-images.githubusercontent.com/25203086/39655576-b7d5595a-4fb7-11e8-9f1a-01714d304afd.png">

### Vignettes:

  - [dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)
  - [tidyr](http://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)

### What is the Tidyverse?

  - The [tidyverse](https://www.tidyverse.org/)
  - The tidyverse [packages](https://www.tidyverse.org/packages/)
  - Converting to the
    [Tidyverse](http://www.significantdigits.org/2017/10/switching-from-base-r-to-tidyverse/)

-----

## LICENSE

This package (suite of programs) is free software; you can redistribute
it and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
Public License (GPL-3) for more details.

See [GNU licenses](http://www.gnu.org/licenses/) for a copy of the GNU
General Public License.

-----

Created on 2019-02-11 by
[Rmarkdown](https://github.com/rstudio/rmarkdown) (v1.11) and R version
3.5.2 (2018-12-20).
