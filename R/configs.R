# How the static web addresses begin
static_url_head <- "http://files.zillowstatic.com/research/public/"

# List of short-form names to be used as the zillow_var arguments
# The values of this list just need to end in ".csv" to become the static URL tails
zillow_var_dict_0 <- list(
  "zhvi_summary" = "Zhvi_Summary_AllHomes",
  "zhvi_allHomes" = "Zhvi_AllHomes",
  "zhvi_bottomtier" = "Zhvi_BottomTier",
  "zhvi_toptier" = "Zhvi_TopTier",
  "zhvi_condo" = "Zhvi_Condominum",
  "zhvi_sfr" = "Zhvi_SingleFamilyResidence",
  "zhvi_1Bed" = "Zhvi_1bedroom",
  "zhvi_2Bed" = "Zhvi_2bedroom",
  "zhvi_3Bed" = "Zhvi_3bedroom",
  "zhvi_4Bed" = "Zhvi_4bedroom",
  "zhvi_5BedPlus" = "Zhvi_5BedroomOrMore",
  "medValue_psf" = "MedianValuePerSqft_AllHomes",
  "zri_summary" = "Zri_AllHomesPlusMultifamily_Summary",
  "zri_allHomesPlus" = "Zri_AllHomesPlusMultifamily",
  "zri_allHomes" = "Zri_AllHomes",
  "zri_sfr" = "Zri_SingleFamilyResidenceRental",
  "zri_mfr" = "Zri_MultiFamilyResidenceRental",
  "zri_allHomes_psf" = "ZriPerSqft_AllHomes",
  "medRent_allHomes" = "MedianRentalPrice_AllHomes",
  "medRent_mfr" = "MedianRentalPrice_Mfr5Plus",
  "medRent_condo" = "MedianRentalPrice_CondoCoop",
  "medRent_dtx" = "MedianRentalPrice_DuplexTriplex",
  "medRent_sfr" = "MedianRentalPrice_Sfr",
  "medRent_studio" = "MedianRentalPrice_Studio",
  "medRent_1Bed" = "MedianRentalPrice_1Bedroom",
  "medRent_2Bed" = "MedianRentalPrice_2Bedroom",
  "medRent_3Bed" = "MedianRentalPrice_3Bedroom",
  "medRent_4Bed" = "MedianRentalPrice_4Bedroom",
  "medRent_5BedPlus" = "MedianRentalPrice_5BedroomOrMore",
  "medRent_allHomes_psf" = "MedianRentalPricePerSqft_AllHomes",
  "medRent_mfr_psf" = "MedianRentalPricePerSqft_Mfr5Plus",
  "medRent_condo_psf" = "MedianRentalPricePerSqft_CondoCoop",
  "medRent_dtx_psf" = "MedianRentalPricePerSqft_DuplexTriplex",
  "medRent_sfr_psf" = "MedianRentalPricePerSqft_Sfr",
  "medRent_studio_psf" = "MedianRentalPricePerSqft_Studio",
  "medRent_1Bed_psf" = "MedianRentalPricePerSqft_1Bedroom",
  "medRent_2Bed_psf" = "MedianRentalPricePerSqft_2Bedroom",
  "medRent_3Bed_psf" = "MedianRentalPricePerSqft_3Bedroom",
  "medRent_4Bed_psf" = "MedianRentalPricePerSqft_4Bedroom",
  "medRent_5Bed_psf" = "MedianRentalPricePerSqft_5BedroomOrMore")

# Include (a cleaner version of) this dictionary for users to review
zillow_var_dict <- as.data.frame(t(as.data.frame(zillow_var_dict_0)))
zillow_var_dict$zillow_var <- rownames(zillow_var_dict)
rownames(zillow_var_dict) <- 1:nrow(zillow_var_dict)
names(zillow_var_dict)[1] <- "Zillow Data Description"
devtools::use_data(zillow_var_dict, overwrite = TRUE)

# # Zillow's geographical reporting levels
zillow_data_reporting_level <- list("State",
                                     "Metro",
                                     "County",
                                     "City",
                                     "Zip",
                                     "Neighborhood")



# # Fuck it, just scrape it
# page <-
#   html_session("https://www.zillow.com/research/data/") %>%
#   html_table()
