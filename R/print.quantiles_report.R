#' Define a custom print method for the quantiles_report class and make it a global function
#'
#' @param summary_data
#'
#' @return
#' @export
#'
#' @examples
print.quantiles_report <- function(summary_data) {
  cat(summary_data$report, sep = "\n") # Print the report column
}
