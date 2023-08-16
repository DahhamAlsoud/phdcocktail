#' Delete files from output folder
#'
#' @param folder
#' @param extensions
#' @param which
#'
#' @return
#' @export
#'
#' @examples
delete_output <- function(folder = "output", extensions = c("xlsx", "xls"), which = NULL) {
  valid_which <- c("except-r", "all", "extensions")

  if (is.null(which) || !which %in% valid_which) {
    which <- "except-r" # Set default value to "except-r" if which is NULL or invalid
    message("Invalid or missing 'which' option. Defaulting to 'except-r'. Other valid options are 'all' to\ndelete all files, or 'extensions' to delete only specified extensions\n")
  }

  # Get a list of all files in the directory
  folder <- here::here(folder)
  files_list <- list.files(folder, full.names = TRUE, recursive = TRUE)

  # Filter files based on which option
  if (which == "except-r") {
    # Keep only R script and data files
    files_list <- files_list[!tools::file_ext(files_list) %in% c("R", "rdata", "RData", "rds")]
  } else if (which == "all") {
    # Delete all files
    files_list <- files_list
  } else if (which == "extensions") {
    # Delete only specified extensions
    files_list <- files_list[tools::file_ext(files_list) %in% extensions]
  }

  # Delete files
  if (length(files_list) > 0) {
    # Delete files and store their names
    deleted_files <- basename(files_list)
    file.remove(files_list)
    cat("Deleted ", length(deleted_files), " file(s) from ", folder, ":\n", sep = "")
    cat(deleted_files, sep = "\n")
    cat("\n")
  } else {
    message(paste("No files found in", folder, "to delete!!\n", sep = " "))
  }
}
