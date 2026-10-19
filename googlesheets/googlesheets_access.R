library(googlesheets4)

# Reading from a public Google sheet (does not require auth) ----
# Indicate that authorization is not necessary to access the Google sheet
googlesheets4::gs4_deauth()

test_link <- "https://docs.google.com/spreadsheets/d/1a4f3XpaKxjAVw6QarHZseZXR5N7KfYG_gYCxx0K-bWo/edit?usp=sharing"
test_sheet <- googlesheets4::read_sheet(test_link)

# Reading from a private Google sheet (requires auth) ----
googlesheets4::gs4_auth()

test_link <- "https://docs.google.com/spreadsheets/d/1a4f3XpaKxjAVw6QarHZseZXR5N7KfYG_gYCxx0K-bWo/edit?usp=sharing"
test_sheet <- googlesheets4::read_sheet(test_link)

# Writing to any Google sheet (requires auth) ----
# Set up authorization and select account
googlesheets4::gs4_auth()

test_link <- "https://docs.google.com/spreadsheets/d/1a4f3XpaKxjAVw6QarHZseZXR5N7KfYG_gYCxx0K-bWo/edit?usp=sharing"
test_data <- data.frame(date_time_utc = lubridate::now(), value = rnorm(1))
googlesheets4::sheet_append(test_link, data = test_data)
