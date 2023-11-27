#' Plot % of outcomes as bars
#'
#' @param data A data frame containing outcomes data.
#' @param outcome Variable containing outcomes to be plotted.
#' @param proportion Variable containing proportion of patients who achieved the outcome.
#' @param percentage_labelled Variable containing percentage of patients who achieved the outcome,
#' suffixed with '%' label.
#' @param achieved Variable containing number of patients who achieved the outcome.
#' @param total Variable containing total number of patients.
#' @param x_axis_title Title of the x-axis.
#' @param y_axis_title Title of the y-axis.
#' @param legend_title Title of the legend.
#' @param bar_fill Fill color of the bars.
#' @param grouping Faceting variable.
#'
#' @return A bar plot of outcome percentages.
#'
#' @examples
#' \donttest{
#' if (FALSE) {
#' library(phdcocktail)
#' data(ibd_outcomes, package = "phdcocktail")
#' plot_bars(ibd_outcomes)
#'   }
#' }
#'
#' @export
plot_bars <- function(data, outcome, proportion, percentage_labelled, achieved, total,
                      x_axis_title = NULL, y_axis_title = "% Patients", legend_title = "Outcome",
                      bar_fill = "Greys", grouping = NULL) {
  plot <- ggplot2::ggplot(data = data, ggplot2::aes(x = {{ outcome }}, y = {{ proportion }}, fill = {{ outcome }})) +
    ggplot2::geom_col() +
    ggplot2::geom_text(ggplot2::aes(label = paste0({{ percentage_labelled }}, "\n", "(", {{ achieved }}, "/", {{ total }}, ")")),
      vjust = -0.18, size = 3, fontface = "bold"
    ) +
    ggplot2::facet_grid(rows = NULL, cols = ggplot2::vars({{ grouping }}), switch = "x") +
    ggplot2::scale_y_continuous(labels = scales::label_percent(), limits = c(0, 1), breaks = seq(0, 1, 0.1), expand = c(0, 0)) +
    ggplot2::scale_fill_brewer(palette = bar_fill, direction = -1) +
    ggplot2::labs(y = y_axis_title, fill = legend_title, x = x_axis_title) +
    ggplot2::theme(
      axis.ticks = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_blank(),
      axis.title.x = ggplot2::element_blank(),
      panel.background = ggplot2::element_blank(),
      strip.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(face = "bold"),
      axis.title = ggplot2::element_text(face = "bold"),
      axis.text.y = ggplot2::element_text(face = "bold", hjust = 1.3),
      legend.title = ggplot2::element_text(face = "bold")
    )

  print(plot)
}
