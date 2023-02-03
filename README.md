
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RPrelimEdaHelper

<!-- badges: start -->
![ci-cd](https://github.com/UBC-MDS/prelim_eda_helper/actions/workflows/ci-cd.yml/badge.svg) [![codecov](https://codecov.io/gh/UBC-MDS/R_Prelim_Eda_Helper/branch/main/graph/badge.svg?token=7BpWZihHxW)](https://codecov.io/gh/UBC-MDS/R_Prelim_Eda_Helper)
<!-- badges: end -->

This package is a preliminary exploratory data analysis (EDA) tool to
make useful feature EDA plots and provide relevant information to
simplify an otherwise tedious EDA step of any data science project.
Specifically this package allows users to target any two features,
whether they are numeric or categorical, and create visualization plots
supplemented with useful summary and test statistics.

This package provides a streamlined and easy to use solution for basic
EDA tasks that would otherwise require significant amount of coding to
achieve.

`R_prelim_eda_helper` enables user to write quick visualization queries.
At the same time, as we understand visually strong effects on graphs are
not necessarily statistically meaningful, `prelim_eda_helper` is
designed to combine graphic visualizations with preliminary statistical
test results. We aim to create a helper package to really help
researchers to get a quick sense of how our data look like, without
making charts and doing tests separately in earlier stages of projects.
While existing packages for plotting and statistical tests already exist
(e.g., `ggplot2`(<https://ggplot2.tidyverse.org/reference/ggplot.html>)
in `tidyverse`), we believe the combination of graphical and statistical
output is what makes `prelim_eda_helper` a unique yet handy helper
package.

To achive this goal, `R_prelim_eda_helper` creates charts with the
visualization library
[`ggplot2`](https://ggplot2.tidyverse.org/reference/ggplot.html) and
conducts statistical tests with [`scipy`](https://scipy.org/).

## Usage

### Installation

The development version of the package can be installed with the code
below.

``` r
devtools::install_github( 'UBC-MDS/R_prelim_eda_helper')
```

### `num_dist_by_cat`

Creates a pair of plots showing the distribution of the numeric variable
when grouped by the categorical variable. Output includes a histogram
and boxplot. In addition, basic test statistics will be provided for
user reference.

``` r
num_dist_by_cat(
  num = x, group = classes, data = data,
  title_hist = 'Distribution of X', title_boxplot = 'X Seperated by Group',
  lab_num = 'X', lab_group = 'Group', num_on_x = TRUE, stat = TRUE)
```

### `num_dist_scatter`

Creates a scatter plot given two numerical variables. The plot can
provide regression trendline and include confidence interval bands.
Spearman and Pearson’s correlation will also be returned to aid the user
to determining feature relationship.

``` r
num_dist_scatter(
  num1 = 'num1', num2 = 'num2', data = df, title = 'num1 v num2',
  stat = FALSE, trend = FALSE)
```

### `cat_dist_heatmap`

Creates concatenated charts showing the heatmap of two categorical
variables and a bar chart for occurrence of these variables.

``` r
cat_dist_heatmap(
  cat1 = 'group1', cat2 = 'group2', data = df, title = 'Group1 & Group2 Distribution', 
  heatmap = TRUE, barchart = TRUE)
```

### `num_dist_summary`

Creates a distribution plot of the given numeric variable and provides a
statistical summary of the feature. In addition, the correlation values
of the variable with other numeric features will be provided based on a
given threshold.

``` r
num_dist_summary(
  col_name = num1, data = df, title = 'num_col1', label_x = 'distribution of num1',
  thresh_corr = 0.0, stat = TRUE)
```

## Contributing

Please check the [contributing
guidelines](https://github.com/UBC-MDS/R_Prelim_Eda_Helper/blob/main/.github/CONTRIBUTING.md)
if you are interested in contributing. As the project is released with a
[Code of
Conduct](https://github.com/UBC-MDS/R_Prelim_Eda_Helper/blob/main/CODE_OF_CONDUCT.md),
you will agree to follow the terms if you wish to contribute.

## License

`prelim_eda_helper` was created by Mehwish Nabi, Morris Chan, Xinry LU,
Austin Shih. It is licensed under the terms of the MIT license.
