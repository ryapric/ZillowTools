#' Read static Zillow Data from the web
#'
#' @return
#' @export
#'
#' @examples
zillow_read_from_web <- function(zillow_var) {
  read_csv(web_address_config)
}
