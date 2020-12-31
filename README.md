
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis Build
Status](https://travis-ci.org/stufield/stutils.svg?branch=master)](https://travis-ci.org/stufield/stutils)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/stufield/stutils?branch=master&svg=true)](https://ci.appveyor.com/project/stufield/stutils)
[![CRAN\_Status](http://www.r-pkg.org/badges/version/stutils)](https://cran.r-project.org/package=stutils)
[![codecov](https://codecov.io/gh/stufield/stutils/branch/master/graph/badge.svg)](https://codecov.io/gh/stufield/stutils)

-----

# The `stutils` library

## Overview

Small suite of useful functions and utilities used for data manipulation
and coding in the R environment.

-----

## Installation

To install the latest `development` version of `stutils` from
**GitHub**, first install the
[devtools](https://CRAN.R-project.org/package=devtools) package and run:

``` r
devtools::install_github("stufield/stutils", build = TRUE)
```

If you specify a tag, you can install a GitHub release.

``` r
devtools::install_github("stufield/stutils@v1.0.0", build = TRUE)
```

### Datasets

  - **test\_data**
      - A quick sample `tibble` for running examples and checking
        functions acting upon data frames. See `?tibble`.
      - The format of `test_data` is:

|      Column | Definition                                                                    |
| ----------: | :---------------------------------------------------------------------------- |
|         pid | `sprintf("%02i", 1:40)`                                                       |
|         Pop | `rep(head(LETTERS, 10), 4)`                                                   |
|      Sample | `factor(sample(c("small", "medium", "large"), 40, replace = TRUE))`           |
|   TimePoint | `factor(rep(c("baseline", "6 months", "12 months", "24 months"), each = 10))` |
|           a | `round(rnorm(40, mean = 25, sd = 3.5), 0)`                                    |
|           b | `sample(0:6, 40, replace = TRUE)`                                             |
| seq.1234.56 | `rnorm(40, 25, 3.5)`                                                          |
| seq.6969.42 | `rnorm(40, 25, 1.5)`                                                          |
|           x | `rnorm(40, mean = 5, sd = 3)`                                                 |
|           y | `round(runif(40, 10, 20), 0)`                                                 |
|           z | `round(rnorm(40, mean = 1, sd = 0.5), 3))`                                    |
|    Response | `factor(sample(c("control", "disease"), 40, replace = TRUE)))`                |

  - **tree\_data**
      - Sala et. al.
  - **Ri\_data**
      - Coefficient Interclass Correlation Data Example from Sokal &
        Rohlf (Biometry; 3rd ed.), pages 210-214.
  - **InfectionByCounty**
      - Infection data describing the infections count data of an
        infectious disease by geographic position for 3082 individual
        cases.
      - Source: Dylan George, EEID 2008
  - **nyflights13**
      - New York city airport flight data from 2013 (**must install**)
      - install with `install.packages("nyflights13",
        repos="http://cran.rstudio.com")`

-----

# Tutorial

The [online package
vignette](https://github.com/stufield/stutils/blob/master/vignettes/stutils.Rmd)
has a complete tutorial. You can load the compiled version from an R
session.

``` r
vignette("stutils")
```

# Links

## Hadley Wickham

[R for Data Science](http://r4ds.had.co.nz/) [Advanced
R](https://adv-r.hadley.nz/) [R Packages](https://r-pkgs.org/)

## What is the `tidyverse`?

  - The [tidyverse](https://www.tidyverse.org/)
  - The tidyverse [packages](https://www.tidyverse.org/packages/)
  - Converting to the
    [tidyverse](http://www.significantdigits.org/2017/10/switching-from-base-r-to-tidyverse/)

## RStudio Cheatsheets:

  - [Cheat sheet
    webpage](https://www.rstudio.com/resources/cheatsheets/)
  - [GitHub Cheatsheet PDFs](https://github.com/rstudio/cheatsheets)

## Vignettes:

  - [`dplyr`](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)
  - [`tidyr`](http://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)

## Fitting Distributions

<img width="669" alt="fitting_distns" src="https://user-images.githubusercontent.com/25203086/39655576-b7d5595a-4fb7-11e8-9f1a-01714d304afd.png">

-----

## LICENSE

This package (suite of programs) is free software; you can redistribute
it and/or modify it under the terms of the MIT License. See please see
the [LICENSE](LICENSE). By using in this package you agree to abide by
its terms.

-----

Created by [Rmarkdown](https://github.com/rstudio/rmarkdown) (v2.6) and
R version 3.6.3 (2020-02-29).
