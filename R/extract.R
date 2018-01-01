#' @import rlang
#' @import dplyr
NULL



#' @title Determine static web URL address for Zillow data
#' 
#' @description This function is designed to fetch the full URL of Zillow's
#' public research data via the site's static-address \code{.csv} links. It is
#' specificaly designed as a utility in actually fetching the data.
#'
#' @param zillow_var The variable name to read in. The full list of
#' these short-form variable names can be found in the variable dictionary
#' included with this package (i.e. by calling \code{zillow_var_dict})
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
  if (!(tolower(zillow_var) %in% tolower(names(zillow_var_dict_0)))) {
    stop(paste0("Invalid Zillow variable name. Please choose from list ",
                "(included with this package): zillow_var_dict"))
  }
  
  # Throw error if geographic level isn't in list of options
  if (!(tolower(geo_level) %in% tolower(zillow_data_reporting_level))) {
    stop(paste0("Invalid geographic level. Please choose from this list: ",
                unlist(tolower(zillow_data_reporting_level)),
                collapse = ", "))
  }
  
  # Fix casing, including in the zillow_var_dict to make lookup work
  zillow_var_dict_cased <- zillow_var_dict_0
  names(zillow_var_dict_cased) <- tolower(names(zillow_var_dict_cased))
  
  zillow_var_cased <- tolower(zillow_var)
  
  geo_level_cased <-
    paste0(toupper(substr(geo_level, 1, 1)),
           tolower(substr(geo_level, 2, nchar(geo_level))))
  
  # Return
  paste0(static_url_head,
         geo_level_cased, "/", geo_level_cased, "_",
         zillow_var_dict_cased[[zillow_var_cased]],
         ".csv")
  
}



#' @title Read static Zillow data from the web
#' 
#' @description This function is designed to read in Zillow's public research
#' data via the site's static-address \code{.csv} links.
#'
#' @param zillow_var The variable name to read in. The full list of
#' these short-form variable names can be found in the variable dictionary
#' included with this package (i.e. by calling \code{zillow_var_dict})
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
zillow_read <- function(zillow_var, geo_level) {
  
  # Find URL
  zillow_url <- zillow_get_url(zillow_var, geo_level)
  
  # Read static file
  readr::read_csv(zillow_url)
  
}



#' @title Retrieve Mortgage Rates from FRED
#' 
#' @description This function is designed to return monthly mortgage rates provided by the
#' St. Louis Federal Reserve's Economic Data (FRED) system. Specifically,
#' this function will return a \code{data.frame} containing the "MORTG" FRED
#' data series, which is the monthly spot rates for 30-year mortgage loans in
#' the United States.
#' 
#' @details This function is not designed to accept any arguments; you may wish
#' to inspect the documentation of the \code{\link[quantmod]{getSymbols}}
#' function from the \code{quantmod} package for more flexible financial &
#' economic data retrieval.
#' 
#' @return A table of class \code{tbl_df} that contains monthly mortgage rate
#' data.
#' 
#' @export
#'
#' @examples
get_mortgage_rates <- function() {
  
  # Get weekly mortgage rates from FRED, and convert to decimal
  mrate <- as.data.frame(
    quantmod::getSymbols("MORTGAGE30US",
                         src = "FRED",
                         auto.assign = FALSE))
  
  names(mrate) <- "mortgage_rate"
  
  mrate$mortgage_rate <- (mrate$mortgage_rate / 100)
  
  # Group by month, and find mean mortgage rates, since this new series is weekly-only
  
  # Can't seem to figure out how to assign rownames inside a magrittr pipe
  # (with "."), inside a function, so do that first
  mrate$year_month <- rownames(mrate)
  mrate %<>%
    mutate(year = lubridate::year(year_month),
           month = lubridate::month(year_month)) %>%
    group_by(year, month) %>%
    summarise(mortgage_rate = mean(mortgage_rate, na.rm = T)) %>%
    ungroup() %>%
    mutate(
      year_month = paste0(year, "-",
                          stringr::str_pad(month,
                                           2,
                                           "left",
                                           "0"))) %>%
    select(year_month,
           mortgage_rate)
  
  mrate
  
}
