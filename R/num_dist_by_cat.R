library( tidyverse)
library( cowplot)

df = tibble(
  cat_1group = c( 1, 1, 1, 1, 1, 1),
  cat_2groups = c( 1, 1, 1, 2, 2, 2),
  cat_3groups = c( 1, 1, 2, 2, 3, 3),
  num_constant = c( 20, 20, 20, 20, 20, 20),
  num_0_within_group_variance = c( 20, 20, 21, 22, 23, 24),
  num = c( 10, 20, 50, 100, 200, 300)
)

df <-

hist <- df |>
  ggplot() +
  aes( x = num) +
  geom_histogram() +
  labs( title = '', x = '', y = '')

# Check data type
boxplot <- df |>
  ggplot() +
  aes( x = cat_2groups, y = num) +
  geom_violin() +
  geom_boxplot() +
  labs( title = '', x = '', y = '')

plot_grid( hist, boxplot, n_col = 2)
