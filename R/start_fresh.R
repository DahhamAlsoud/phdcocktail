#' Restart R session
#'
#' @return A clean R session
#'
#' @examples
#' \dontrun{
#' library(phdcocktail)
#' start_fresh()
#' }
#'
#' @export
start_fresh <- function() {
  rstudioapi::executeCommand("restartR")
}
