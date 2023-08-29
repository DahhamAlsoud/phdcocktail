#' Restart R session
#'
#' @return A clean R session
#'
#' @examples
#' \dontrun{
#' start_fresh()
#' }
#'
#' @export
start_fresh <- function() {
  rstudioapi::executeCommand("restartR")
}
