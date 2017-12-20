#' Read static Zillow data from the web
#' 
#' @description This function is designed to read in Zillow's public research
#' data via the site's static-address \code{.csv} links.
#'
#' @param zillow_var The variable name to read in. The full list of
#' these short-form variable names can be found in the \code{zillow_var_ids}
#' data available in this package.
#' @return A table of class \code{tbl_df}
#' @export
#'
#' @examples
zillow_read_from_web <- function(zillow_var, geo_level) {
  # readr::read_csv(zillow_var_ids[[geo_level]])
  print(static_web_address_full[[geo_level]])
}
