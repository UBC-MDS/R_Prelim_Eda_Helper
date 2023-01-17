library( tidyverse)
library( cowplot)

#' Create a histogram paired with a box plot.
#'
#' @param v_num Name of the column for the numeric variable.
#' @param v_cat Name of the column for the categorical variable.
#' @param data Target data frame for visualization.
#' @param title_hist Title for the histogram.
#' @param title_boxplot Title for the boxplot.
#' @param lab_num Axis label for the numeric variable.
#' @param lab_cat Axis label for the categorical variable.
#' @param num_on_x Whether the numeric variable is put on the x-axis in the boxplot.
#' @param stat Whether printing the test statistic and summary or not.
#'
#' @return A ggplot object consists of a histogram and a boxplot.
#' @export
#'
#' @examples
#' num_dist_by_catnum_dist_by_cat(
#'   v_num = num, v_cat = groups, data = data,
#'   title_hist = 'Distribution of X', title_boxplot = 'X Seperated by Group',
#'   lab_num = 'X', lab_cat = 'Group', num_on_x = True, stat = True)
num_dist_by_cat <- function( v_num, v_cat, data, title_hist = '', title_boxplot = '', lab_num = '', lab_cat = '', num_on_x = TRUE, stat = TRUE){
  hist <- data |>
    ggplot() +
    aes( x = {{v_num}}) +
    geom_histogram() +
    labs( title = title_hist, x = lab_num, y = 'Count')

  boxplot <- data |>
    ggplot() +
    aes( x = {{v_cat}}, y = {{v_num}}) +
    geom_violin() +
    geom_boxplot( width = 0.1) +
    labs( title = title_boxplot, x = lab_cat, y = lab_num)

  print( head( select( data, {{ v_cat}})))
  plot_grid( hist, boxplot, ncol = 2)
}

