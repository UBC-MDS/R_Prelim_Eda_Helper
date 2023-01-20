#' Create concatenated charts showing the heatmap of two categorical variables and the barcharts for occurrance of these variables. 
#' Heatmap will be on the left and the two barcharts will be on the right in the same column.
#'
#' @param cat_1 Name of the column name for the first categorical variable.
#' @param cat_2 Name of the column name for the second categorical variable.
#' @param data Target data frame for visualization.
#' @param title Title for the chart.
#' @param lab_1 Axis label for the first categorical variable (x-axis).
#' @param lab_2 Axis label for the second categorical variable (y-axis).
#' @param heatmap Whether to include a heatmap plot or not.
#' @param barchart Whether to include the barchart or not.
#'
#' @return A concatenated ggplot chart consists of a heatmap and 2 barcharts.
#' @export
#'
#' @examples
#' cat_dist_heatmap(
#'   cat_1 = school_type, cat_2 = program_type, data = data,
#'   title = 'School Type vs Program Type',
#'   lab_1 = 'School type', param = 'Program type', heatmap = True, barchart = True)
cat_dist_heatmap <- function(cat_1, cat_2, data, title = '', lab_1 = '', lab_2 = '', heatmap = TRUE, barchart = TRUE){
}

