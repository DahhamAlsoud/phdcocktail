#' Restart R session
#'
#' @return A clean R session
#'
#' @examples
#' try(start_fresh())
#'
#' @export
start_fresh <- function() {
  rstudioapi::executeCommand("restartR")
}
