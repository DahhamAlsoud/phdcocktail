#' Restart r session
#'
#' @return
#' @export
#'
#' @examples
start_fresh <- function() {
  rstudioapi::executeCommand("restartR")
}
