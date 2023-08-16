#' Plot % of outcomes as bars
#'
#' @param data
#' @param outcome_columns
#' @param bar_order
#' @param outcome_names
#' @param x_axis_name
#' @param y_axis_name
#' @param legend_title
#' @param na_to_zero
#' @param bar_fill
#' @param show_numbers
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
plot_outcome_bars <- function(data, outcome_columns, bar_order = NULL,
                              outcome_names = NULL, x_axis_name = NULL,
                              y_axis_name = "% Patients", legend_title = "Outcome",
                              na_to_zero = TRUE, bar_fill = "Greys",
                              show_numbers = "all", ...) {

  # If bar_order is provided, number and names of columns should be identical to outcome_columns
  if (!is.null(bar_order)) {
    if (!all(bar_order %in% outcome_columns) || length(bar_order) != length(outcome_columns)) {
      stop("Length and names of bar_order and outcome_columns should be identical!")
    }
  }


  # If outcome_names is provided, number of names should be identical to number of outcome_columns
  if (!is.null(outcome_names) && length(outcome_names) != length(outcome_columns)) {
    stop("Length of outcome_names and outcome_columns is not identical! Each outcome column should have ONE name!!")
  }

  # Check if any of the specified outcome_columns exist in the dataframe
  valid_columns <- intersect(outcome_columns, colnames(data))
  invalid_columns <- setdiff(outcome_columns, colnames(data))

  if (length(valid_columns) == 0) {
    stop("None of the specified columns exist! Please check the column's names!!")
  } else if (length(invalid_columns) > 0) {
    warning(paste0("Invalid column(s): '", paste(invalid_columns, collapse = " & "),
                   "' not found in the dataframe. Plotting with available columns!"))

    if (!is.null(outcome_names)) {
      outcome_names <- outcome_names[which(outcome_columns %in% colnames(data))]
    }

    outcome_columns <- valid_columns

    if (!is.null(bar_order)) {
      bar_order <- bar_order[bar_order %in% outcome_columns]
    }

  }

  # Replace NAs with 0 if na_to_zero is TRUE
  if (na_to_zero) {
    data[, outcome_columns][is.na(data[, outcome_columns])] <- 0
  }

  # Calculate the percentages of outcomes
  outcome_percentages <- sapply(data[, outcome_columns, drop = FALSE], function(col) sum(col == 1) / sum(!is.na(col)))

  # Prepare the data in a long format for ggplot
  outcome_data <- data.frame(
    outcome_type = names(outcome_percentages),
    percentage = outcome_percentages,
    numerator = sapply(data[, outcome_columns, drop = FALSE], function(col) sum(col == 1)),
    denominator = sapply(data[, outcome_columns, drop = FALSE], function(col) sum(!is.na(col)))
  )

  # If outcome_names is provided, use it to replace outcome_type names based on position
  if (!is.null(outcome_names)) {
    outcome_data$outcome_type <- outcome_names
  }


  # If bar_order is provided, use it to reorder the bars
  if (!is.null(bar_order)) {
    bar_order <- outcome_data$outcome_type[match(bar_order, row.names(outcome_data))]
    outcome_data$outcome_type <- factor(outcome_data$outcome_type, levels = bar_order, ordered = TRUE)
  } else {
    outcome_data <- outcome_data[order(outcome_data$percentage, decreasing = T), ]
    outcome_data$outcome_type <- factor(outcome_data$outcome_type, levels = outcome_data$outcome_type, ordered = TRUE)
  }


  # Create the bar plot using ggplot2
  plot <- ggplot2::ggplot(outcome_data, ggplot2::aes(x = outcome_type, y = percentage, fill = outcome_type)) +
    ggplot2::geom_col() +
    ggplot2::scale_y_continuous(labels = scales::label_percent(), limits = c(0,1), breaks = seq(0, 1, 0.1), expand = c(0,0)) +
    ggplot2::scale_fill_brewer(palette = bar_fill, direction = - 1) +
    ggplot2::labs(y = y_axis_name, fill = legend_title, x = x_axis_name) +
    ggplot2::theme(axis.ticks = ggplot2::element_blank(),
          axis.text.x = ggplot2::element_blank(),
          axis.title.x = ggplot2::element_blank(),
          panel.background = ggplot2::element_blank(),
          axis.title = ggplot2::element_text(face = "bold"),
          axis.text.y = ggplot2::element_text(face = "bold", hjust = 1.3),
          legend.title = ggplot2::element_text(face = "bold"))

  # Add percentage labels, numerator, and denominator based on show_numbers setting
  if (show_numbers == "all") {
    plot <- plot + ggplot2::geom_text(ggplot2::aes(label = paste0(percentage * 100, "%\n", "(", numerator, "/", denominator, ")")), vjust = -0.2, size = 3.2, fontface = "bold")
  } else if (show_numbers == "percentage") {
    plot <- plot + ggplot2::geom_text(ggplot2::aes(label = paste0(percentage * 100, "%")), vjust = -0.5, size = 3.2, fontface = "bold")
  } else if (show_numbers == "fraction") {
    plot <- plot + ggplot2::geom_text(ggplot2::aes(label = paste0(numerator, "/", denominator)), vjust = -0.5, size = 3.2, fontface = "bold")
  }

  # Do nothing (no geom_text) if show_numbers is "none"
  print(plot)
}
