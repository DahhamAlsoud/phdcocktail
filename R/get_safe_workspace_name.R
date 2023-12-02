#' Get a safe name to save current workspace without overwriting
#'
#' @param name A desired name for the saved workspace. If no name is provided,
#' the name will be 'analysis'.
#' @param time_in_name A logical to indicate whether a timestamp
#' should be included in the workspace's name.
#'
#' @return A safe name for exporting the workspace, as a "character string", and also indicated in a message.
#'
#' @examples
#' \donttest{
#' if (FALSE) {
#'   library(phdcocktail)
#'   get_safe_workspace_name()
#' }
#' }
#'
#' @export
get_safe_workspace_name <- function(name = "analysis", time_in_name = TRUE) {
  # Generate a safe name with optional timestamp
  timestamp <- if (time_in_name) format(Sys.time(), "%Y%m%d%H%M%S") else ""
  safe_name <- paste0(name, "_", timestamp, ".RData")

  # Check if the safe name already exists and handle overwriting
  index <- 1
  while (file.exists(safe_name)) {
    safe_name <- paste0(name, "_", timestamp, "-", sprintf("%02d", index), ".RData")
    index <- index + 1
  }

  # Return the safe workspace name
  message("A safe workspace name is: ", safe_name)
  return(safe_name)
}
