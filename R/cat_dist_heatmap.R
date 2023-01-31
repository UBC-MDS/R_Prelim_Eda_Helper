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
#' @export
#' @return A concatenated ggplot chart consists of a heatmap and 2 barcharts.
#'  @examples
#' cat_dist_heatmap(
#'   cat_1 = school_type, cat_2 = program_type, data = data,
#'   title = 'School Type vs Program Type',
#'   lab_1 = 'School type', lab_2 = 'Program type', heatmap = True, barchart = True)
cat_dist_heatmap <- function(cat_1, cat_2, data, title = '', lab_1 = '', lab_2 = '', heatmap = TRUE, barchart = TRUE){
  # Sanity check
  n_rows = nrow(data)
  if (n_rows < 1) {
    stop("Dataset must have at least one row of data.")
  }
  if ( length( unique(dplyr::select(data, {{cat_1}}))) == n_rows) {
    # stop(paste(cat_1, " does not appear to be a valid categorical column. Please double check the input."))
    stop("It does not appear to be a valid categorical column. Please double check the input.")
  }
  if ( length( unique(dplyr::select(data, {{cat_2}}))) == n_rows) {
    # stop(paste(cat_2, " does not appear to be a valid categorical column. Please double check the input."))
    stop("It does not appear to be a valid categorical column. Please double check the input.")
  }

  data <- dplyr::mutate(data,
                        {{cat_1}} := as.factor( {{cat_1}}),
                        {{cat_2}} := as.factor( {{cat_2}}),
  )

  plot_heatmap <- data |>
    dplyr::count( {{cat_1}}, {{cat_2}}) |>
    ggplot2::ggplot() +
    ggplot2::aes(x = {{cat_1}},
                 y = {{cat_2}},
                 fill = n) +
    geom_tile() +
    ggplot2::labs( title = title, x = lab_1, y = lab_2)
  plot_barchart <- data |>
    ggplot2::ggplot() +
    ggplot2::aes(y = {{cat_1}},
        fill = {{cat_2}}) +
    ggplot2::geom_bar(stat = 'count', position = 'dodge') +
    ggplot2::labs( title = title, x = lab_1, y = lab_2)
  if ({{heatmap}} == TRUE && {{barchart}} == TRUE) {
    cowplot::plot_grid( plot_heatmap, plot_barchart)
  } else if ({{heatmap}} == TRUE) {
    heatmap
  } else if ({{barchart}} == TRUE) {
    barchart
  } else {
    stop( 'At least one of the plot options (heatmap or barchart) needs to be selected (set to TRUE).\n')
  }
}
