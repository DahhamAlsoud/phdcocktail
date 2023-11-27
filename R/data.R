#' Data dictionary for Inflammatory Bowel Disease (IBD) data
#'
#' A small, non-exhaustive list of variables that are commonly collected in IBD research. For each
#' variable and its levels, if applicable, publications-ready labels are provided
#'
#' @format A data frame with 53 rows and four columns:
#' \describe{
#'   \item{variable}{Variable name in the 'short', i.e. 'excel', form}
#'   \item{variable_label}{Variable name in the publication form}
#'   \item{value}{Value name in the 'short', i.e. 'excel', form}
#'   \item{value_label}{Value name in the publication form}
#' }
"ibd_data_dict"


#' Inflammatory Bowel Disease (IBD) datasets
#'
#' 'ibd_data1' and 'ibd_data2' are two small datasets containing data collected from IBD patients,
#' more specifically patients with Crohn's disease. 'ibd_data2' is a modified version of 'ibd_data1'
#' by introducing missing and incorrect entries 'L11' into the column 'disease_location'.
#'
#' @format Two data frames with each 30 rows and six columns:
#' \describe{
#'   \item{patientid}{Patient ID}
#'   \item{gender}{Gender}
#'   \item{disease_location}{Disease location}
#'   \item{disease_behaviour}{Disease behaviour}
#'   \item{crp_mg_l}{C-reactive protein (mg/L)}
#'   \item{calprotectin_ug_g}{Faecal calprotectin (ug/g)}
#' }
#' @source Randomly generated data
"ibd_data1"


#' @rdname ibd_data1
#' @format NULL
"ibd_data2"

#' Inflammatory Bowel Disease (IBD) outcomes
#'
#' A table containing proportions and percentages of IBD patients achieving clinical outcomes.
#'
#' @format A data frame with eight rows and seven columns:
#' \describe{
#'   \item{outcome}{Outcome type}
#'   \item{timepoint}{Assessment timepoint}
#'   \item{achieved}{Number of patients who achieved the outcome}
#'   \item{total}{Total number of patients}
#'   \item{proportion}{Proportion of patients who achieved the outcome}
#'   \item{percentage}{Percentage of patients who achieved the outcome}
#'   \item{percentage_labelled}{Percentage of patients who achieved the outcome, suffixed with '%'}
#'   }
"ibd_outcomes"

