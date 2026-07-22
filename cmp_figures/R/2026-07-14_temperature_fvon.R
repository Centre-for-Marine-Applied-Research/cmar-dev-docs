library(dplyr)
library(ggplot2)
library(ggview)
library(here)
library(lubridate)
library(purrr)
library(readr)
library(sensorstrings)
library(tidyr)

theme_set(theme_light())
w_out <- 32
h_out <- 13


# shut-in -----------------------------------------------------------------

files <- list.files(
  "R:/data_branches/water_quality/processed_data/qc_data/halifax",
  pattern = "shut-in",
  full.names = TRUE
)

shut_raw <- map_df(files, readRDS)

shut <- shut_raw %>% 
  select(
    station, 
    timestamp_utc, 
    sensor_depth_at_low_tide_m, 
    temperature_degree_c,
    qc_flag_temperature_degree_c
  ) %>% 
  filter(qc_flag_temperature_degree_c < 4) |> 
  select(-contains("flag"))

w_out <- 33
h_out <- 13


xlabs <- seq(as_datetime("2019-01-01"), as_datetime("2025-01-01"), by = "1 year")

p <- ss_ggplot_variables(shut, legend_position = "bottom") +
  scale_x_datetime(breaks = xlabs) +
  theme(
    text = element_text(size = 18),
    strip.text = element_text(size = 18),
    axis.title.x = element_blank(),
    axis.ticks.length=unit(.25, "cm"),
    #panel.grid = element_blank(),
    panel.border = element_rect(colour = "black")
  ) 

ggsave(
  p,
  filename = here("figures/2026-07-14_shut-in_bottom_legend.png"),
  device = "png",
  width = w_out, height = h_out, units = "cm",
  dpi = 600
)
