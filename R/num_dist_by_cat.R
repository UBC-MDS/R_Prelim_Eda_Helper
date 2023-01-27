#' Create a histogram paired with a box plot.
#'
#' @param num Name of the column for the numeric variable.
#' @param group Name of the column for the categorical variable.
#' @param data Target data frame for visualization.
#' @param title_hist Title for the histogram.
#' @param title_boxplot Title for the boxplot.
#' @param lab_num Axis label for the numeric variable.
#' @param lab_group Axis label for the categorical variable.
#' @param num_on_x Whether the numeric variable is put on the x-axis in the boxplot.
#' @param stat Whether printing the test statistic and summary or not.
#'
#' @return A ggplot object consists of a histogram and a boxplot.
#' @export
#'
#' @examples
#' data <- data.frame( num = c( 1, 2, 3, 4), classes = c( 1, 1, 2, 2))
#' num_dist_by_cat(
#'   num = num, group = classes, data = data,
#'   title_hist = 'Distribution of X', title_boxplot = 'X Seperated by Group',
#'   lab_num = 'X', lab_group = 'Group', num_on_x = TRUE, stat = TRUE)
num_dist_by_cat <- function( num, group, data, title_hist = '', title_boxplot = '', lab_num = '', lab_group = '', num_on_x = TRUE, stat = TRUE){

  # Ensure group is a factor
  data <- dplyr::mutate( data, {{group}} := as.factor( {{group}}))

  # Histogram
  hist <- data |>
    ggplot2::ggplot() +
    ggplot2::aes( x = {{num}}) +
    ggplot2::geom_histogram( bins = 30) +
    ggplot2::labs( title = title_hist, x = lab_num, y = 'Count')

  # Boxplot
  boxplot <- data |>
    ggplot2::ggplot() + {
    if ( num_on_x)
      ggplot2::aes( y = {{group}}, x = {{num}})
    else
      ggplot2::aes( x = {{group}}, y = {{num}})
    } +
    ggplot2::geom_violin() +
    ggplot2::geom_boxplot( width = 0.1) + {
    if ( num_on_x)
      ggplot2::labs( title = title_boxplot, x = lab_num, y = lab_group)
    else
      ggplot2::labs( title = title_boxplot, x = lab_group, y = lab_num)
    }

  # Number of groups
  group_list <- levels( unlist( dplyr::select( data, {{group}})))
  n_group = length( group_list)

  if (n_group == 0){
    stop( 'Please use a data frame with data inside.\n')
  } else if (n_group == 1){
    stop( 'Please consider using prelim_eda_helper.num_dist_summary when only 1 class is used.\n')
  } else if ( stat == TRUE){
    if (n_group == 2){
      if (var( dplyr::select( data, {{ group}})) == 0){
        stop( 'A t test is not performed as the total variance is 0.\n')
      } else {
        group_a <- data |>
          dplyr::filter( {{group}} == group_list[ 1])
        group_b <- data |>
          dplyr::filter( {{group}} == group_list[ 2])
        t_eq_result <- t.test( x = dplyr::select( group_a, {{num}}),
                               y = dplyr::select( group_b, {{num}}),
                               var.equal = TRUE)
        t_w_result <- t.test( x = dplyr::select( group_a, {{num}}),
                              y = dplyr::select( group_b, {{num}}),
                              var.equal = FALSE)
        t_eq = t_eq_result$statistic
        p_eq = t_eq_result$p.value
        t_w = t_w_result$statistic
        p_w = t_w_result$p.value
        table = data.frame( Test = c( 'Equal var. assumed', 'Equal var. not asumed'),
                               t = c( t_eq, t_w),
                               p = c( p_eq, p_w))
        print( table)
      }
    } else if( n_group > 2){
      aov_result <- aov( as.formula( paste( deparse( substitute( num)), '~', deparse( substitute( group)))), data = data)
      F_score <- summary( aov_result)[[1]]$`F value`[[1]]
      p <- summary( aov_result)[[1]]$`Pr(>F)`[[1]]
      table = data.frame( Test = c( 'One-way ANOVA'),
                          `F` = F_score,
                          p = p)
      print( table)
    }
  }
  cowplot::plot_grid( hist, boxplot, ncol = 2)
}

