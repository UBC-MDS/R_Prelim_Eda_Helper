#' Create a distribution plot of the numeric variable
#'  in general and statistical summary  of the feature .
#' In addition, the  correlation values of the input
#' variable with other features based on a threshold will also be returned
#'
#' @param col_name A string  with the name of the column
#' @param data A dataframe , target DataSet for visualization
#' @param title A string , Title for chart , default =''
#' @param label_x A string,  X-axis label for numeric column
#' @param thresh_corr Number Threshold value for correlation
#' @param stat  Boolean, whether to show statistic information or not
#' @export
#' @return plot and dataframe to display summary statistics and correlation values
num_dist_summary <- function(col_name,  data, title = '', label_x = '',   thresh_corr = 0.0, stat = TRUE) {

}
