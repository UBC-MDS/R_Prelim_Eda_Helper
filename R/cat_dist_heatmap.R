#' Create concatenated charts showing the heatmap of two categorical variables and the barcharts for occurrance of these variables.
#' Heatmap will be on the left and the two barcharts will be on the right in the same column.
#'
#' @param cat_1 Name of the column name for the first categorical variable.
#' @param cat_2 Name of the column name for the second categorical variable.
#' @param data Target data frame for visualization.
#' @param title Title for the chart.
#' @param heatmap Whether to include a heatmap plot or not.
#' @param barchart Whether to include the barchart or not.
#' @export
#' @return A concatenated ggplot chart consists of a heatmap and 2 barcharts.
#'  @examples
#' cat_dist_heatmap(
#'   cat_1 = school_type, cat_2 = program_type, data = data,
#'   title = 'School Type vs Program Type',
#'   lab_1 = 'School type', lab_2 = 'Program type', heatmap = True, barchart = True)
cat_dist_heatmap <- function(cat_1, cat_2, data, title = '', heatmap = TRUE, barchart = TRUE){
  # Sanity check
  n_rows = nrow(data)
  if (n_rows < 1) {
    stop("Dataset must have at least one row of data.")
  }
  if ( length( unique(data[[cat_1]])) == n_rows) {
    stop("It does not appear to be a valid categorical column. Please double check the input.")
  }
  if ( length( unique(data[[cat_2]])) == n_rows) {
    stop("It does not appear to be a valid categorical column. Please double check the input.")
  }

  plot_heatmap <- data |>
    ggplot2::ggplot(ggplot2::aes(x = data[[cat_1]],
                                 y = data[[cat_2]])) +
    ggplot2::geom_bin_2d()+
    ggplot2::labs( title = title,
                   x = cat_1,
                   y = cat_2)

  plot_barchart <- data |>
    ggplot2::ggplot() +
    ggplot2::aes(y = data[[cat_1]],
                 fill = data[[cat_2]]) +
    ggplot2::geom_bar(stat = 'count', position = 'dodge') +
    ggplot2::labs( title = title,
                   y = cat_1) +
    ggplot2::guides(fill=ggplot2::guide_legend(title=cat_2))
  if (heatmap == TRUE && barchart == TRUE) {
    cowplot::plot_grid( plot_heatmap, plot_barchart, align='v', nrow = 2)
  } else if (heatmap == TRUE) {
    heatmap
  } else if (barchart == TRUE) {
    barchart
  } else {
    stop( 'At least one of the plot options (heatmap or barchart) needs to be selected (set to TRUE).\n')
  }
}
