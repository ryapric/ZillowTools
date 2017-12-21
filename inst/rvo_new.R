library(ZillowTools)


# Read in Zillow data
house <- zillow_read("medValue_psf", "city")
rental <- zillow_read("zri_allhomes_psf", "city")

# Retrieve mortgage rates from FRED
mrate <- get_mortgage_rates()



tibble,
magrittr,
rlang,
stringr,
readr,
dplyr,
tidyr,
lubridate,