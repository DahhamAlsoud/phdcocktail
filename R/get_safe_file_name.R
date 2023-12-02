#' Get a safe name to export a file without overwriting
#'
#' @param data The object to be exported.
#' @param name A desired name for the exported file. If no name is provided,
#' the file will inherit the object's name.
#' @param format The format of the exported file. Default is 'xlsx'.
#' @param overwrite A logical to indicate whether preexisting files
#' with identical names should be overwritten. Default is 'FALSE'.
#' @param time_in_name A logical to indicate whether a timestamp
#' should be included in the file's name.
#'
#' @return A safe name for exporting the file, as a "character string", and also indicated in a message.
#'
#' @examples
#' \donttest{
#' if (FALSE) {
#'   library(phdcocktail)
#'   get_safe_file_name(mtcars)
#' }
#' }
#'
#' @export
get_safe_file_name <- function(data, name = NULL, format = "xlsx", overwrite = FALSE, time_in_name = FALSE) {
  # Generate file name
  base_filename <- deparse(substitute(data))

  if (is.null(name)) {
    if (time_in_name) {
      timestamp <- format(Sys.time(), "%Y%m%d%H%M%S")
      full_filename <- paste0(base_filename, "_", timestamp, ".", format)
    } else {
      full_filename <- paste0(base_filename, ".", format)
    }
    safe_name <- full_filename

    # Generate a unique file name if overwrite is FALSE
    if (!overwrite) {
      if (file.exists(safe_name)) {
        index <- 1
        while (file.exists(safe_name)) {
          if (time_in_name) {
            timestamp <- format(Sys.time(), "%Y%m%d%H%M%S")
            index_filename <- paste0(base_filename, "_", timestamp, "-", sprintf("%02d", index), ".", format)
          } else {
            index_filename <- paste0(base_filename, "-", sprintf("%02d", index), ".", format)
          }
          safe_name <- index_filename
          index <- index + 1
        }

        message("File already exists. A new safe name for '", full_filename, "' will be suggested. If you wish instead to overwrite it, set 'overwrite = TRUE'.")
      }
    }

    # Return the safe file name
    message("A safe file name is: ", safe_name)
    return(safe_name)

  } else {
    if (time_in_name) {
      timestamp <- format(Sys.time(), "%Y%m%d%H%M%S")
      custom_filename <- paste0(name, "_", timestamp, ".", format)
    } else {
      custom_filename <- paste0(name, ".", format)
    }
    safe_name <- custom_filename
    # Check if the custom file name already exists
    if (!overwrite) {
      if (file.exists(safe_name)) {
        index <- 1
        while (file.exists(safe_name)) {
          if (time_in_name) {
            timestamp <- format(Sys.time(), "%Y%m%d%H%M%S")
            index_filename <- paste0(name, "_", timestamp, "-", sprintf("%02d", index), ".", format)
          } else {
            index_filename <- paste0(name, "-", sprintf("%02d", index), ".", format)
          }
          safe_name <- index_filename
          index <- index + 1
        }

        message("File already exists. A new safe name for '", custom_filename, "' will be suggested. If you wish instead to overwrite it, set 'overwrite = TRUE'.")
      }
    }
    # Return the safe file name
    message("A safe file name is: ", safe_name)
    return(safe_name)
  }
}
