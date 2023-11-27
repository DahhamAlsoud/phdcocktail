#' A custom print method for the 'quantiles_report' class
#'
#' @param x A data frame of the class 'quantiles_report'.
#' @param ... Other argument that can be passed to 'print'.
#'
#' @return The function displays the content of the column 'report'
#' in separate lines.
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
print.quantiles_report <- function(x, ...) {
  cat(x$report, sep = "\n") # Print the report column
}
