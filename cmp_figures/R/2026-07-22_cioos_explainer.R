library(dplyr)
library(ggplot2)
library(ggview)
library(here)
library(lubridate)
library(qaqcmar)
library(readxl)
library(rnaturalearth)
library(sensorstrings)
library(sf)
library(stringr)
library(tidyr)

source(here("cmp_figures/functions/ns_base_map.R"))

theme_set(theme_light())

dat_raw <- ss_import_data(county = "Halifax")

dat <- dat_raw |>
  select(station, timestamp_utc, sensor_depth_at_low_tide_m,
         temperature_degree_c, qc_flag_temperature_degree_c) |>
  filter(qc_flag_temperature_degree_c < 4) |>
  select(-qc_flag_temperature_degree_c) |>
  mutate(round_timestamp = round_date(timestamp_utc, "1 hour")) |>
  summarise(
    temperature_degree_c = mean(temperature_degree_c),
    .by = c(station, round_timestamp, sensor_depth_at_low_tide_m)
  )

x <- dat |>
  summarise(.by = c(station, sensor_depth_at_low_tide_m),
            min = min(temperature_degree_c),
            max = max(temperature_degree_c))

dat_wide <- dat |>
  filter(station == "Shut-In Island") |>
  pivot_wider(
    values_from = temperature_degree_c,
    names_from = sensor_depth_at_low_tide_m
  ) |>
  mutate(strat_ind = `2` - `20`)

ggplot(dat_wide, aes(round_timestamp, strat_ind)) +
  geom_line()

max(dat_wide$strat_ind, na.rm = TRUE)
min(dat_wide$strat_ind, na.rm = TRUE)


superchill <- dat |>
  filter(temperature_degree_c < 0)


# data figure -----------------------------------------------------------

dat |>
  filter(station == "Shut-In Island") |>
  rename(timestamp_utc = round_timestamp) |>
  ss_ggplot_variables() +
  scale_x_datetime(date_breaks = "1 year", date_labels = "%Y") +
  canvas(height = 10, width = 20, units = "cm")


ggsave(
  filename = here("cmp_figures/figures/2026-07-22_cioos.png"),
  dpi = 600, height = 15, width = 32, units = "cm"

)
#
#
# y <- dat |>
#   filter(station == "Shut-In Island") |>
#   ss_convert_depth_to_ordered_factor()
#
# ggplot(
#   y,
#   aes(round_timestamp, temperature_degree_c, col = sensor_depth_at_low_tide_m)) +
#   geom_line()


# map - Halifax ---------------------------------------------------------------------

w_out <- 20
h_out <- 15

st_locations <- dat_raw |>
  distinct(station, .keep_all = TRUE) |>
  st_as_sf(coords = c("longitude", "latitude"), crs = 4617)

ns_base_map(x_min = -66.1, x_max = -60, y_min = 43.6, y_max = 46.9) +
  geom_sf(
    data = st_locations, fill = "#1B9E77",
    pch = 21, size = 3.5, alpha = 1
  ) +
  canvas(width = w_out, height = h_out, units = "cm")

ggsave(
  filename = here("figures/2026-07-22_station_locations.png"),
  device = "png",
  width = w_out, height = h_out, units = "cm",
  dpi = 600
)


# map - all ---------------------------------------------------------------

w_out <- 20
h_out <- 15

st_locations <- read_excel(
  here("R:/tracking_sheets/metadata_tracking/water_quality_deployment_tracking.xlsx"),
  sheet = "station_waterbody_county"
) |>
  mutate(
    region = if_else(county == "Halifax", "Halifax Stations", "Other Stations")
  ) |>
  filter(!is.na(latitude), !is.na(longitude),
         !str_detect(station, "BDLS")) |>
  st_as_sf(coords = c("longitude", "latitude"), crs = 4617)

ns_base_map(x_min = -66.1, x_max = -60, y_min = 43.5, y_max = 47) +
  geom_sf(
    data = st_locations,
    aes(fill = region), pch = 21, size = 3.5, alpha = 1
  ) +
  geom_sf(
    data = filter(st_locations, region == "Halifax Stations"),
    fill = "#1B9E77", pch = 21, size = 3.5, alpha = 1
  ) +
  scale_fill_manual(
    values = c("Halifax Stations" = "#1B9E77", "Other Stations" = "grey70")
  ) +
  theme(
    legend.title = element_blank(),
    legend.position = "inside",
    legend.position.inside = c(0.87, 0.07),
    legend.text = element_text(size = 12)
  ) +
  canvas(width = w_out, height = h_out, units = "cm")

ggsave(
  filename = here("cmp_figures/figures/2026-07-22_station_locations_all.png"),
  device = "png",
  width = w_out, height = h_out, units = "cm",
  dpi = 600
)

