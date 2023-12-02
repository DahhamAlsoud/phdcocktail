#' Identify the most recent saved R workspace
#'
#' @param folder The folder in which the workspace need to be identified.
#'
#' @return The most recent saved workspace, as a "character string", and also indicated in a message.
#'
#' @examples
#' \donttest{
#' library(phdcocktail)
#' if (FALSE) {
#'   identify_recent_workspace()
#' }
#' }
#'
#' @export
identify_recent_workspace <- function(folder = "output") {
  # Stop if the output folder does not exist
  folder <- here::here(folder)
  if (!dir.exists(folder)) {
    stop("The source folder does not exist!!")
  }

  # Get a list of all .RData files in the output folder
  rdata_files <- list.files(path = folder, pattern = "*.RData$", full.names = TRUE, recursive = TRUE)

  # Check if any .RData files are found
  if (length(rdata_files) == 0) {
    stop("No .RData files found in the source folder!")
  }

  # Extract the timestamps from the file names
  timestamps <- gsub("^.*_(\\d{14}).*RData$", "\\1", basename(rdata_files))
  timestamps <- as.POSIXct(timestamps, format = "%Y%m%d%H%M%S")

  # Find the most recent timestamp
  latest_timestamp <- max(timestamps)

  # Filter the files with the most recent timestamp
  latest_file <- rdata_files[which(timestamps == latest_timestamp)]

  # check whether multiple numeric indexes exist for the most recent timestamp. If so, select the highest one
  if (length(latest_file) > 1) {
    latest_file <- latest_file[grepl("-", latest_file)]

    numeric_indexes <- gsub("^.*-(\\d{1,}).*RData$", "\\1", basename(latest_file))
    numeric_indexes <- as.numeric(numeric_indexes)
    highest_numeric_index <- max(numeric_indexes)

    latest_file <- latest_file[which(numeric_indexes == highest_numeric_index)]
  }

  # Return the most recent .RData file
  message("The most recent saved workspace is: ", latest_file)
  return(latest_file)
}
