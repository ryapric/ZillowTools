library(ZillowTools)
library(tidyverse)
library(lubridate)
library(tvm)

# Housing calculation variables ----
term <- 360 # In months
down <- 0.05 # Percent down payment on home
p_tax <- 0.02 # Property taxes as percentage per year
h_ins <- 0.01 # Homeowners insurance, as a percentage of value per year (the default value of 1.0% is an estimate)

# Rental property types (leave desired type uncommented, or use all) ----
rental_type <-
  c(
    'http://files.zillowstatic.com/research/public/City/City_ZriPerSqft_AllHomes.csv'
  )

# # Read data in from Zillow (house sale price, $/sqft) ----
house_0 <-
  read_csv(
    # 'http://files.zillowstatic.com/research/public/City/City_MedianSoldPricePerSqft_AllHomes.csv',
    'http://files.zillowstatic.com/research/public/City/City_MedianValuePerSqft_AllHomes.csv',
    trim_ws = T
  )



# # Use TVM to calculate payments on $/sqft using variables specified above ----

# # Get monthly mortgage rates from FRED, and clean up data
mrate <-
  as.data.frame(
    quantmod::getSymbols(
      'MORTG',
      src = 'FRED',
      auto.assign = FALSE
    )
  )
mrate$MORTG <- (mrate$MORTG / 100)
mrate$date <- str_replace(rownames(mrate), '-01', '')



# # Calculate: principle & interest payments, estimated property taxes, and estimated homeowner's insurance, then add together for total monthly payment ----
house <-
  house_0 %>%
  gather(
    date,
    house_price,
    7:ncol(.)
  ) %>%
  select(
    -RegionID,
    -SizeRank
  ) %>%
  left_join(
    .,
    mrate,
    by = 'date'
  ) %>%
  mutate(
    
    prin_int_pmt =
      tvm::pmt(
        amt = house_price,
        maturity = term,
        rate = (MORTG / 12)
      ),
    
    tax_pmt = ((house_price * p_tax) / 12),
    
    h_ins_pmt = ((house_price * h_ins) / 12),
    
    mortg_pmt_total = (prin_int_pmt + tax_pmt + h_ins_pmt)
    
  )



# # Read rental data in from Zillow, and clean up ----
rental_0 <-
  read_csv(
    rental_type,
    trim_ws = T
  )



rental <-
  rental_0 %>%
  gather(
    date,
    rent_price,
    7:ncol(.)
  ) %>%
  select(
    -SizeRank
  )



# # Merge data together to calculate RvOs ----
comparo <-
  inner_join(
    house,
    rental
  ) %>%
  mutate(
    
    RvO = (rent_price / mortg_pmt_total),
    
    best_option =
      ifelse(
        RvO < 1.0,
        'Rent',
        ifelse(
          (RvO >= 1.0) & (RvO <= 1.5),
          'Either',
          ifelse(
            RvO > 1.5,
            'Buy',
            'BROKEN'
          )
        )
      )
    
  ) %>%
  filter(
    !is.na(RvO)
  ) %>%
  arrange(
    date,
    RvO
  )



# # Look at Zillow's Price-to-Rent Ratio to compare it to RvO (should have strong (negative) correlation) ----
ptr0 <-
  read_csv(
    'http://files.zillowstatic.com/research/public/City/City_PriceToRentRatio_AllHomes.csv',
    trim_ws = T
  )

ptr <-
  ptr0 %>%
  gather(
    date,
    ptr,
    7:ncol(.)
  ) %>%
  select(
    -RegionID,
    -SizeRank
  )



comparo <-
  left_join(
    comparo,
    ptr
  )

# cor(comparo$RvO, comparo$ptr, use = 'pairwise.complete.obs')
# cor.test(comparo$RvO, comparo$ptr, use = 'pairwise.complete.obs')
# plot(comparo$RvO, comparo$ptr)



# # Plot the RvO ----
# # Using steps from: http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

# # # Populate list of city-states so you can limit the API calls used
# comparo_forplot <-
#   as.data.frame(comparo) %>%
#   mutate(
#     location = paste0(RegionName, ', ', State)
#   )
# 
# city_state_list <-
#   distinct(
#     comparo_forplot,
#     location
#   ) %>%
#   mutate_geocode(
#     location,
#     client = '123',
#     signature = '123',
#     source = 'dsk'
#   )
# 
# write.csv(
#   city_state_list,
#   file = 'C:\\Users\\Ryan\\Google Drive\\SkedaMetrics\\Housing\\city_state_list.csv',
#   row.names = F,
#   na = ''
# )

city_state_list <-
  read_csv(
    'C:\\Users\\Ryan\\Google Drive\\SkedaMetrics\\Housing\\city_state_list.csv'
    # 'C:\\Users\\Ryan price\\Downloads\\city_state_list.csv'
  )



# # Adjust as you see fit
comparo_forplot <-
  as.data.frame(comparo) %>%
  mutate(
    location = paste0(RegionName, ', ', State)
  )

comparo_forplot <-
  left_join(
    comparo_forplot,
    city_state_list
  ) %>%
  filter(
    !(State %in% c('AK', 'HI')),
    location != 'Sweden, NY',
    date %in% tail(sort(unique(date)), 6)
    # RvO <= 1.5
  ) %>%
  group_by(
    RegionName,
    State,
    Metro,
    CountyName,
    location,
    lon,
    lat
  ) %>%
  summarize(
    RvO = mean(RvO, na.rm = T)
  ) %>%
  ungroup()



# # Now plot!
states <- map_data('state')
counties <- map_data('county')

# # # To get fill by county (instead of dot), you'll need to mape either lat/lon, or state/counties, since they don't match between tables
# comparo_forplot <-
#   left_join(
#     comparo_forplot,
#     counties,
#     by = c(
#       'lon' = 'long',
#       'lat'
#     )
#   )

ggplot() +
  geom_polygon(data = counties, aes(x = long, y = lat, group = group), color = 'lightgrey', fill = NA) +
  geom_polygon(data = states, aes(x = long, y = lat, group = group), color = 'black', fill = NA) +
  geom_point(data = comparo_forplot, aes(x = lon, y = lat, color = log(RvO))) +
  scale_color_gradient(low = 'red', high = 'green') +
  coord_fixed(1.3) +
  # # Get rid of gridlines, etc.
  theme(
    axis.text = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    panel.grid = element_blank(),
    axis.title = element_blank()
  )

