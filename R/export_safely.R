#' Export files to the output folder
#'
#' @param data
#' @param name
#' @param folder
#' @param format
#' @param overwrite
#' @param time_in_name
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
export_safely <- function(data, folder = "output/data", name = NULL, format = "xlsx", overwrite = FALSE, time_in_name = FALSE, ...) {
  # Create the output folder if it does not exist yet
  folder <- here::here(folder)
  if (!dir.exists(folder)) {
    dir.create(folder, recursive = TRUE)
  }

  # Generate file name and a path
  base_filename <- deparse(substitute(data))

  if (is.null(name)) {
    if (time_in_name) {
      timestamp <- format(Sys.time(), "%Y%m%d%H%M%S")
      full_filename <- paste0(base_filename, "_", timestamp, ".", format)
    } else {
      full_filename <- paste0(base_filename, ".", format)
    }
    path <- file.path(folder, full_filename)

    # Generate a unique file name if overwrite is FALSE
    if (!overwrite) {
      if (file.exists(path)) {
        index <- 1
        while (file.exists(path)) {
          if (time_in_name) {
            timestamp <- format(Sys.time(), "%Y%m%d%H%M%S")
            index_filename <- paste0(base_filename, "_", timestamp, "-", sprintf("%02d", index), ".", format)
          } else {
            index_filename <- paste0(base_filename, "-", sprintf("%02d", index), ".", format)
          }
          path <- file.path(folder, index_filename)
          index <- index + 1
        }

        message("File already exists. A new indexed version of '", full_filename, "' has been created. If you wish instead to overwrite it, set 'overwrite = TRUE'.")
      }
    }

    # Export the file with a unique name
    rio::export(data, file = path, ...)

    message("File exported successfully: ", path)
  } else {
    if (time_in_name) {
      timestamp <- format(Sys.time(), "%Y%m%d%H%M%S")
      custom_filename <- paste0(name, "_", timestamp, ".", format)
    } else {
      custom_filename <- paste0(name, ".", format)
    }
    custom_path <- file.path(folder, custom_filename)
    # Check if the custom file name already exists
    if (!overwrite) {
      if (file.exists(custom_path)) {
        index <- 1
        while (file.exists(custom_path)) {
          if (time_in_name) {
            timestamp <- format(Sys.time(), "%Y%m%d%H%M%S")
            index_filename <- paste0(name, "_", timestamp, "-", sprintf("%02d", index), ".", format)
          } else {
            index_filename <- paste0(name, "-", sprintf("%02d", index), ".", format)
          }
          custom_path <- file.path(folder, index_filename)
          index <- index + 1
        }
        if (custom_filename == base_filename) {
          message("File already exists. A new indexed version of '", custom_filename, "' has been created. If you wish instead to overwrite it, set 'overwrite = TRUE'.")
        } else {
          message("The custom filename '", custom_filename, "' already exists. A new indexed version of '", custom_filename, "' has been created. If you wish instead to overwrite it, set 'overwrite = TRUE'.")
        }
      }
    }
    # Export the file with a unique custom name
    rio::export(data, file = custom_path, ...)

    message("File exported successfully: ", custom_path)
  }
}
