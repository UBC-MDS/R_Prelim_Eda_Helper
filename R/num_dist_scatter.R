#' num_dist_scatter
#' Creates a scatter plot given two numerical features
#' Plot can provide regression trendline and highlight outliers.
#' Spearman and Pearson's correlation will also be returned as options
#'
#' @param num1 Name of the column for the first numeric feature.
#' @param num2 Name of the column for the second numeric feature.
#' @param data Target data frame for visualization.
#' @param title Title for the chart.
#' @param lab_num1 Axis label for the first numeric feature.
#' @param lab_num2 Axis label for the second numeric feature.
#' @param trend Type of trend line. Options are: FALSE, 'lin', 'poly'.
#' @param band Whether to include 95% confidence interval band.
#'
#' @return A ggplot scatter plot object
#' @export
#'
#' @examples
#' num_dist_scatter(
#'   num1=num_col1, num2=num_col2, data=df, title='num_col1 v num_col2', lab_num1='num_col1', lab_num2='num_col2', trend='lin', band=TRUE
#' )
num_dist_scatter <- function(num1, num2, data, title = '', lab_num1 = '', lab_num2 = '', trend = FALSE, band = FALSE){

}
