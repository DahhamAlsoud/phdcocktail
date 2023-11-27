#' Report median-quantiles summaries
#'
#' @param data A data frame including numeric variables to be summarized.
#' @param summary_vrs A character vector specifying the numeric variables to be summarized.
#' @param grouping_vrs A character vector specifying the grouping variables, if any.
#'
#' @return A dataframe of the class 'quantiles_report', containing a
#' 'report' column, which report the 'median (quartile 1-quartile 3)'
#' combinations for each specified numeric variable, at each grouping
#' key.
#'
#' @examples
#' \donttest{
#' if (FALSE) {
#' library(phdcocktail)
#' summary_data <- report_quantiles(mtcars, summary_vrs = "mpg")
#' print(summary_data)
#'   }
#' }
#'
#' @export
report_quantiles <- function(data, summary_vrs, grouping_vrs = NULL) {
  simple_quantiles <- function(data, summary_vrs) {
    # Check if the specified summary columns exist
    non_existing_sum_vrs <- setdiff(summary_vrs, names(data))
    if (length(non_existing_sum_vrs) == length(unique(summary_vrs))) {
      stop("None of the specified summary columns exist")
    } else if (length(non_existing_sum_vrs) > 0) {
      warning(paste0("These summary columns were not found: ", paste(non_existing_sum_vrs, collapse = ", ")))
    }

    # identify the existing summary columns
    existing_sum_vrs <- intersect(summary_vrs, names(data))
    working_df <- data[, existing_sum_vrs, drop = FALSE]

    # Check if all existing specified summary columns are numeric
    non_numeric_sum_vrs <- names(working_df)[!sapply(working_df, is.numeric)]
    if (length(non_numeric_sum_vrs) > 0) {
      stop(paste0("Non-numeric columns found: ", paste(non_numeric_sum_vrs, collapse = ", ")))
    }

    # Compute the median, IQR, Q1, and Q3 for each numeric existing summary column
    summary_data <- data.frame(
      summary_variable = existing_sum_vrs,
      median = round(apply(working_df, 2, stats::median, na.rm = TRUE), 1),
      q1 = round(apply(working_df, 2, stats::quantile, probs = 0.25, na.rm = TRUE), 1),
      q3 = round(apply(working_df, 2, stats::quantile, probs = 0.75, na.rm = TRUE), 1),
      row.names = NULL
    )

    # Create 'report' column with the format: median (IQR) sum_var was x (x-x)
    summary_data$report <- with(summary_data, paste0(
      "median (IQR) ", summary_variable, " was ", median, " (", q1, "-", q3, ")"
    ))


    # Create a custom S3 class for quantiles_report output
    class(summary_data) <- c("quantiles_report", class(summary_data))

    return(summary_data)
  }


  # If grouping_vrs is provided, split the data frame and apply the simple_quantiles function to each subset
  if (!is.null(grouping_vrs)) {
    # Check if the specified grouping columns exist
    non_existing_group_vrs <- setdiff(grouping_vrs, names(data))
    if (length(non_existing_group_vrs) == length(unique(grouping_vrs))) {
      stop("None of the specified grouping columns exist")
    } else if (length(non_existing_group_vrs) > 0) {
      warning(paste0("These grouping columns were not found: ", paste(non_existing_group_vrs, collapse = ", ")))
    }

    # identify the exisiting columns
    existing_group_vrs <- intersect(grouping_vrs, names(data))


    grouping_string <- paste0("list(", paste0(deparse(substitute(df)), "$", existing_group_vrs, collapse = ", "), ")")
    grouped_data <- split(data, eval(parse(text = grouping_string)))
    summary_list <- lapply(grouped_data, function(df) {
      simple_quantiles(df, summary_vrs)
    })

    summary_data <- do.call(rbind, summary_list)

    grouping_key <- sub("\\.[^\\.]*$", "", row.names(summary_data))
    grouping_key <- gsub("\\.", " & ", grouping_key)

    summary_data <- cbind(summary_data[, "summary_variable", drop = FALSE], grouping_key, summary_data[, -1])

    summary_data <- summary_data[order(summary_data$summary_variable), ]

    row.names(summary_data) <- NULL
    summary_data$report <- NULL
    summary_data$report1 <- NULL

    # Create 'text' column to include grouping keys in the report
    summary_data$report <- with(summary_data, paste0(
      "median (IQR) ", summary_variable, " in the '", grouping_key, "' group was ", median, " (", q1, "-", q3, ")"
    ))

    # Create a custom S3 class for quantiles_report output
    class(summary_data) <- c("quantiles_report", class(summary_data))

    return(summary_data)
  } else {
    simple_output <- simple_quantiles(data, summary_vrs)
    return(simple_output)
  }
}
