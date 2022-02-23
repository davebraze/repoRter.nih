#' \code{covid_response} code translation
#' 
#' A tibble containing name translations between `covid_response_code` and the funding source(s)
#' 
#' @docType data
#' @format A \code{"tibble"} with 6 rows and 2 columns:
#' \describe{
#'   \item{\code{covid_response_code}}{the name for a data element when specified in the payload criteria of a request; 
#'         NA indicates that this is not available as payload criteria (can not search/filter on)}
#'   \item{\code{funding_source}}{the name of the funding source, often some federal legislation}
#' }
#' @keywords datasets, covid-19, coronavirus, NIH, research, grant, funding, federal, api
#' @references NIH RePORTER API Documentation
#' (\url{https://api.reporter.nih.gov/documents/Data\%20Elements\%20for\%20RePORTER\%20Project\%20API\%20v2.pdf})
"covid_response_codes"