# How the static web addresses begin...
static_web_address_head <- "http://files.zillowstatic.com/research/public/"

# ...and how they end, for each variable's static download link
static_web_address_tail <- list(
  "home" = list("_Zhvi_Summary_AllHomes.csv",
                "_Zhvi_AllHomes.csv",
                "_Zhvi_BottomTier.csv",
                "_Zhvi_TopTier.csv",
                "_Zhvi_Condominum.csv",
                "_Zhvi_SingleFamilyResidence.csv",
                "_Zhvi_1bedroom.csv",
                "_Zhvi_2bedroom.csv",
                "_Zhvi_3bedroom.csv",
                "_Zhvi_4bedroom.csv",
                "_Zhvi_5BedroomOrMore.csv",
                "_MedianValuePerSqft_AllHomes.csv"
  ),
  "rental" = list("_Zri_AllHomesPlusMultifamily_Summary.csv",
                  "_Zri_AllHomesPlusMultifamily.csv",
                  "_Zri_AllHomes.csv",
                  "_Zri_SingleFamilyResidenceRental.csv",
                  "_Zri_MultiFamilyResidenceRental.csv",
                  "_ZriPerSqft_AllHomes.csv",
                  "_MedianRentalPrice_AllHomes.csv",
                  "_MedianRentalPrice_Mfr5Plus.csv",
                  "_MedianRentalPrice_CondoCoop.csv",
                  "_MedianRentalPrice_DuplexTriplex.csv",
                  "_MedianRentalPrice_Sfr.csv",
                  "_MedianRentalPrice_Studio.csv",
                  "_MedianRentalPrice_1Bedroom.csv",
                  "_MedianRentalPrice_2Bedroom.csv",
                  "_MedianRentalPrice_3Bedroom.csv",
                  "_MedianRentalPrice_4Bedroom.csv",
                  "_MedianRentalPrice_5BedroomOrMore.csv",
                  "_MedianRentalPricePerSqft_AllHomes.csv",
                  "_MedianRentalPricePerSqft_Mfr5Plus.csv",
                  "_MedianRentalPricePerSqft_CondoCoop.csv",
                  "_MedianRentalPricePerSqft_DuplexTriplex.csv",
                  "_MedianRentalPricePerSqft_Sfr.csv",
                  "_MedianRentalPricePerSqft_Studio.csv",
                  "_MedianRentalPricePerSqft_1Bedroom.csv",
                  "_MedianRentalPricePerSqft_2Bedroom.csv",
                  "_MedianRentalPricePerSqft_3Bedroom.csv",
                  "_MedianRentalPricePerSqft_4Bedroom.csv",
                  "_MedianRentalPricePerSqft_5BedroomOrMore.csv"))

# This will be the reference table by which users can review what the argument
# options are
zillow_var_ids <- gsub("[[:punct:]]|csv", "", unlist(static_web_address_tail))
names(zillow_var_ids) <- gsub("home", "home_", names(zillow_var_ids))
names(zillow_var_ids) <- gsub("rental", "rental_", names(zillow_var_ids))
zillow_var_ids <- data.frame(variable_name = names(zillow_var_ids),
                             variable_desc_key = as.character(zillow_var_ids),
                             row.names = NULL,
                             stringsAsFactors = FALSE)



# Geographic levels by which Zillow reports their research data
zillow_data_reporting_level <- list("State",
                                     "Metro",
                                     "County",
                                     "City",
                                     "Zip",
                                     "Neighborhood")



# Populate full web addresses, based on the above
static_web_address_full <-
  lapply(zillow_data_reporting_level,
         function(x) paste0(static_web_address_head,
                            x,
                            "/",
                            x,
                            unlist(static_web_address_tail)))

names(static_web_address_full) <- tolower(unlist(zillow_data_reporting_level))

# static_web_addresses_full <- as.data.frame(static_web_addresses_full)



# Something to look up full web address via short-form variable name,
# e.g. "home_1_state" would look up the first Home variable's state-level address
web_address_config <- list()
