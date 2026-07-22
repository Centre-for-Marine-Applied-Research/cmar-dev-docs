library(data.table)
library(dplyr)
library(RSocrata)

# saved on R drive
x <- ss_import_data(county = "Lunenburg")
sum(is.na(x$timestamp_utc))

# sent to opendata 
y <- fread("C:/Users/Danielle Dempsey/Desktop/2025-12-11_lunenburg.csv")
sum(is.na(y$timestamp_utc))

# downloaded from open data (fewer rows because only 1 Birchy Head depl)
a <- fread("C:/Users/Danielle Dempsey/Desktop/Lunenburg_County_Water_Quality_Data_20260311.csv")
sum(is.na(a$timestamp_utc))

# SODA2 API from open data
## reads timestamps in local time - eg converts March 11, 2018 at 2 am to NA
z <- RSocrata::read.socrata(
  "https://data.novascotia.ca/resource/eda5-aubu.csv"
)
sum(is.na(z$timestamp_utc))

z_na <- z %>% filter(is.na(timestamp_utc))

na_count <- z_na %>% 
  group_by(station, deployment_range, sensor_type) %>% 
  count()

z1 <- z %>% 
  filter(station == "Birchy Head")


# Pull in app token from config.yml
odp_api_config <- config::get(
  config = "default", 
  file = "C:/Users/Danielle Dempsey/Desktop/RProjects/ssnippets/odp_api/config.yml"
)
# Read in dataset from API
s <- read.socrata(
  "https://data.novascotia.ca/api/v3/views/eda5-aubu/",
  app_token = odp_api_config$app_token
)
sum(is.na(s$timestamp_utc))
