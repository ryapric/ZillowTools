# How the static web addresses begin
static_url_head <- "http://files.zillowstatic.com/research/public/"

# List of short-form names to be used as the zillow_var arguments
# The values of this list just need to end in ".csv" to become the static URL tails
zillow_var_dict <- list(
  "zhvi_summary" = "Zhvi_Summary_AllHomes.csv",
  "zhvi_allHomes" = "Zhvi_AllHomes.csv",
  "zhvi_bottomtier" = "Zhvi_BottomTier.csv",
  "zhvi_toptier" = "Zhvi_TopTier.csv",
  "zhvi_condo" = "Zhvi_Condominum.csv",
  "zhvi_sfr" = "Zhvi_SingleFamilyResidence.csv",
  "zhvi_1Bed" = "Zhvi_1bedroom.csv",
  "zhvi_2Bed" = "Zhvi_2bedroom.csv",
  "zhvi_3Bed" = "Zhvi_3bedroom.csv",
  "zhvi_4Bed" = "Zhvi_4bedroom.csv",
  "zhvi_5BedPlus" = "Zhvi_5BedroomOrMore.csv",
  "medValue_psf" = "MedianValuePerSqft_AllHomes.csv",
  "zri_summary" = "Zri_AllHomesPlusMultifamily_Summary.csv",
  "zri_allHomesPlus" = "Zri_AllHomesPlusMultifamily.csv",
  "zri_allHomes" = "Zri_AllHomes.csv",
  "zri_sfr" = "Zri_SingleFamilyResidenceRental.csv",
  "zri_mfr" = "Zri_MultiFamilyResidenceRental.csv",
  "zri_allHomes_psf" = "ZriPerSqft_AllHomes.csv",
  "medRent_allHomes" = "MedianRentalPrice_AllHomes.csv",
  "medRent_mfr" = "MedianRentalPrice_Mfr5Plus.csv",
  "medRent_condo" = "MedianRentalPrice_CondoCoop.csv",
  "medRent_dtx" = "MedianRentalPrice_DuplexTriplex.csv",
  "medRent_sfr" = "MedianRentalPrice_Sfr.csv",
  "medRent_studio" = "MedianRentalPrice_Studio.csv",
  "medRent_1Bed" = "MedianRentalPrice_1Bedroom.csv",
  "medRent_2Bed" = "MedianRentalPrice_2Bedroom.csv",
  "medRent_3Bed" = "MedianRentalPrice_3Bedroom.csv",
  "medRent_4Bed" = "MedianRentalPrice_4Bedroom.csv",
  "medRent_5BedPlus" = "MedianRentalPrice_5BedroomOrMore.csv",
  "medRent_allHomes_psf" = "MedianRentalPricePerSqft_AllHomes.csv",
  "medRent_mfr_psf" = "MedianRentalPricePerSqft_Mfr5Plus.csv",
  "medRent_condo_psf" = "MedianRentalPricePerSqft_CondoCoop.csv",
  "medRent_dtx_psf" = "MedianRentalPricePerSqft_DuplexTriplex.csv",
  "medRent_sfr_psf" = "MedianRentalPricePerSqft_Sfr.csv",
  "medRent_studio_psf" = "MedianRentalPricePerSqft_Studio.csv",
  "medRent_1Bed_psf" = "MedianRentalPricePerSqft_1Bedroom.csv",
  "medRent_2Bed_psf" = "MedianRentalPricePerSqft_2Bedroom.csv",
  "medRent_3Bed_psf" = "MedianRentalPricePerSqft_3Bedroom.csv",
  "medRent_4Bed_psf" = "MedianRentalPricePerSqft_4Bedroom.csv",
  "medRent_5Bed_psf" = "MedianRentalPricePerSqft_5BedroomOrMore.csv")

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

