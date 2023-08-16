#' Save global objects to the output folder
#'
#' @param folder
#' @param name
#' @param objects_to_save
#' @param time_in_name
#'
#' @return
#' @export
#'
#' @examples
save_work <- function(folder = "output/Rdata", name = "analysis", objects_to_save = NULL,
                      time_in_name = TRUE) {
  # Create the output folder if it doesn't exist yet
  folder <- here::here(folder)
  if (!dir.exists(folder)) {
    dir.create(folder, recursive = TRUE)
  }

  # Generate the file path with optional timestamp
  timestamp <- if (time_in_name) format(Sys.time(), "%Y%m%d%H%M%S") else ""
  output_path <- file.path(folder, paste0(name, "_", timestamp, ".RData"))

  # Check if the file path already exists and handle overwriting
  index <- 1
  while (file.exists(output_path)) {
    output_path <- file.path(folder, paste0(name, "_", timestamp, "-", sprintf("%02d", index), ".RData"))
    index <- index + 1
  }


  # Save specific objects or the entire workspace
  if (!is.null(objects_to_save)) {
    # Save only specified objects
    save(list = objects_to_save, file = output_path)
  } else {
    # Save entire workspace
    save.image(file = output_path)
  }

  message("Workspace saved to:", output_path)


  # Create a text file listing the saved objects
  objects_list <- paste0(output_path, "_objects_list.txt")

  if (!is.null(objects_to_save)) {
    objects_to_list <- objects_to_save
  } else {
    objects_to_list <- ls(envir = .GlobalEnv)
  }

  cat("Objects saved in the workspace:\n", file = objects_list)
  cat(objects_to_list, sep = "\n", file = objects_list, append = TRUE)

  message("Objects list saved to:", objects_list)
}
