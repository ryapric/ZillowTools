#' Determine static web URL address for Zillow data
#'
#' This function is designed to fetch the full URL of Zillow's public research
#' data via the site's static-address `.csv` links. It is specificaly designed
#' as a utility in actually fetching the data.
#'
#' @param zillow_var The variable name to read in. The full list of these
#'   short-form variable names can be found in the variable dictionary included
#'   with this package (i.e. by calling `zillow_var_dict`)
#' @param geo_level The geographic level of the data to retrieve, passed as a
#'   character string. Available options are: `state`, `metro`, `county`,
#'   `city`, `zip`, and `neighborhood`.
zillow_get_url <- function(zillow_var, geo_level) {
    totitle <- function(x) {
        paste0(toupper(substr(x, 1, 1)), tolower(substr(x, 2, nchar(x))))
    }
    zillow_var <- tolower(zillow_var)
    geo_level <- totitle(geo_level)
    
    if (!(tolower(zillow_var) %in% tolower(names(var_dict)))) {
        stop(paste0("Invalid Zillow variable name."))
    }
    if (!(geo_level %in% geo_levels)) {
        stop(paste0("Invalid geographic level."))
    }
    
    paste0(static_url_head, geo_level, "/", geo_level, "_",
           var_dict[[zillow_var]], ".csv")
}


#' Read static Zillow data from the web
#'
#' This function is designed to read in Zillow's public research data via the
#' site's static-address `.csv` links.
#'
#' @param zillow_var The variable name to read in. The full list of these
#'   short-form variable names can be found in the variable dictionary included
#'   with this package (i.e. by calling `zillow_var_dict`)
#' @param geo_level The geographic level of the data to retrieve, passed as a
#'   character string. Available options are: `state`, `metro`, `county`,
#'   `city`, `zip`, and `neighborhood`.
#' @param download_dir Directory to save Zillow data to. Defaults to attempt the
#'   standard path of `~/Downloads`.
#'
#' @return A table of class `data.frame`
#'
#' @export
zillow_read <- function(zillow_var, geo_level, download_dir = "~/Downloads") {
    # Stub for download checks
    # you should make another function that builds the file name, to make this cleaner
    url <- zillow_get_url(zillow_var, geo_level)
    read.csv(url, strip.white = TRUE, stringsAsFactors = FALSE)
}
