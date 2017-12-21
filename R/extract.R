#' Determine static web URL address for Zillow data
#' 
#' This function is designed to fetch the full URL of Zillow's public research
#' data via the site's static-address \code{.csv} links. It is specificaly
#' designed as a utility in actually fetching the data.
#'
#' @param zillow_var The variable name to read in. The full list of
#' these short-form variable names can be found in ...
#' 
#' @param geo_level The geographic level of the data to retrieve, passed as a
#' character string. Available options are: \code{state}, \code{metro},
#' \code{county}, \code{city}, \code{zip}, and \code{neighborhood}.
#' 
#' @return A character string giving the requested URL
#' 
#' @export
#'
#' @examples
zillow_get_url <- function(zillow_var, geo_level) {
  
  # Throw error if Zillow variable name isn't in list of options
  if (!(tolower(zillow_var) %in% tolower(names(zillow_var_dict)))) {
    stop(paste0("Invalid Zillow variable name. Please choose from..."))
  }
  
  # Throw error if geographic level isn't in list of options
  if (!(tolower(geo_level) %in% tolower(zillow_data_reporting_level))) {
    stop(paste0("Invalid geographic level. Please choose from this list: ",
                unlist(tolower(zillow_data_reporting_level)),
                collapse = ", "))
  }
  
  zillow_var_correct_case <- tolower(zillow_var)
  
  geo_level_correct_case <-
    paste0(toupper(substr(geo_level, 1, 1)),
           tolower(substr(geo_level, 2, nchar(geo_level))))
  
  paste0(static_url_head,
         geo_level_correct_case, "/", geo_level_correct_case, "_",
         zillow_var_dict[[zillow_var_correct_case]],
         ".csv")
  
}



#' Read static Zillow data from the web
#' 
#' This function is designed to read in Zillow's public research
#' data via the site's static-address \code{.csv} links.
#'
#' @param zillow_var The variable name to read in. The full list of
#' these short-form variable names can be found in ...
#' 
#' @param geo_level The geographic level of the data to retrieve, passed as a
#' character string. Available options are: \code{state}, \code{metro},
#' \code{county}, \code{city}, \code{zip}, and \code{neighborhood}.
#' 
#' @return A table of class \code{tbl_df}
#' 
#' @export
#'
#' @examples
zillow_read_from_web <- function(zillow_var, geo_level) {
  zillow_url <- zillow_get_url(zillow_var, geo_level)
  readr::read_csv(zillow_url)
}
