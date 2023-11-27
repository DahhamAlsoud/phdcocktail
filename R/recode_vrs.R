#' Recode variables and their values based on a data dictionary
#'
#' @param data A data frame with raw data.
#' @param data_dictionary A data dictionary containing labels for variables and their values.
#' @param vrs A character vector specifying variables of which the values need to be recoded.
#' @param factor A logical to indicate whether recoded variables need to be converted into ordered
#' factors.
#'
#' @return The input data frame with recoded and labelled variables.
#'
#' @examples
#' \donttest{
#' if (FALSE) {
#'   library(phdcocktail)
#'   data(ibd_data1, package = "phdcocktail")
#'   ibd_data_recoded <- recode_vrs(
#'     data = ibd_data1, data_dictionary = ibd_data_dict,
#'     vrs = c("disease_location", "disease_behaviour", "gender"), factor = TRUE
#'   )
#' }
#' }
#'
#' @export
recode_vrs <- function(data, data_dictionary, vrs = NULL, factor = FALSE) {
  # If no variables have been supplied, warn the user!
  if (is.null(vrs)) {
    warning("It seems that you have left the 'vrs' argument empty. recode_vrs() will therefore look for available 'variables labels'\n  If you whish to get 'values labels' too, please pass the desired variables to the 'vrs' argument")
  }

  # If none of the provided variables exist in both the analysis df and data dictionary, warn the user!
  existing_vrs <- vrs[vrs %in% names(data) & vrs %in% data_dictionary$variable]

  if (!is.null(vrs) & length(existing_vrs) == 0) {
    warning("None of the provided variables exist in both the analysis data frame and the data dictionary!\n  Please re-check your input in order to get 'values labels'!!\n  recode_vrs() will look for available 'variables labels'")
  }

  # If some or all of the provided variables exist in both the analysis df and data dictionary, recode the values with their labels
  if (!is.null(vrs) & length(existing_vrs) > 0) {
    # Loop through each variable to be recoded
    for (variable_name in vrs) {
      # Check if the variable exists in the analysis dataframe and data dictionary
      if (variable_name %in% names(data) &&
        variable_name %in% data_dictionary$variable) {
        # Get the mapping for the current variable from the data dictionary
        mapping <- data_dictionary[data_dictionary$variable == variable_name, ]

        # Recode the values in the analysis dataframe using the mapping
        recoded_values <- ifelse(data[[variable_name]] %in% mapping$value,
          mapping$value_label[match(data[[variable_name]], mapping$value)],
          data[[variable_name]]
        )

        # Warn the user about any missing mappings values in the current variable
        missing_values <- data[[variable_name]][!(data[[variable_name]] %in% mapping$value)]
        missing_values <- unique(missing_values)
        if (length(missing_values) > 0) {
          warning(
            paste("Variable '", variable_name, "' has no corresponding mapping for value(s): ", paste(missing_values, collapse = ", "), sep = ""),
            "\n  if you chose factor = TRUE, ", paste(missing_values[!is.na(missing_values)], collapse = " & "), " will be converted to NA!"
          )
        }

        # Update the analysis dataframe with the recoded values
        data[[variable_name]] <- recoded_values

        # Convert the variable to an ordered factor if the factor argument is TRUE
        if (factor) {
          levels_order <- unique(mapping$value_label)
          data[[variable_name]] <- factor(data[[variable_name]], levels = levels_order, ordered = TRUE)
        }
      } else {
        # Print a warning if the variable is not found in either the analysis dataframe or data dictionary
        warning(paste("Variable '", variable_name, "' not found in the analysis dataframe or data dictionary. Skipping!!", sep = ""))
      }
    }
  }

  # add label attribute for each variable if available
  for (variable_name in names(data)) {
    attr(data[[variable_name]], "label") <- unique(data_dictionary$variable_label[data_dictionary$variable == variable_name])
  }

  # Return the recoded analysis dataframe
  return(data)
}
