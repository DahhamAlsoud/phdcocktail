#' Restart R session
#'
#' @return A clean R session
#'
#' @examples
#' \donttest{
#' if (FALSE) {
#' library(phdcocktail)
#' start_fresh()
#'   }
#' }
#'
#' @export
start_fresh <- function() {
  rstudioapi::executeCommand("restartR")
}
