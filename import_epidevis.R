
#  ------------------------------------------------------------------------
#
# Title :  iMPORT edidevis
#    By : PhM
#  Date : 2024-10-10
#
#  ------------------------------------------------------------------------


importph <- function() {
  rm(list = ls())
  library(readODS)
  library(tidyverse)
  library(janitor)
  library(baseph)
  library(lubridate)
  library(labelled)
  #
  nan <- c("NA", "ND", "", " ", "non demandé")

  tt <- read_ods("data/EPIDEVIS1.ods", sheet = 1) |>
    janitor::clean_names() |>
    remove_constant() |>
    mutate(across(where(is.character), as.factor)) |>
    mutate(apgar_1 = as.factor(as.character(apgar_1))) |>

  ## Recodage de tt$apgar_1 en tt$apgar_1_rec
mutate(apgar_1 = fct_recode(apgar_1,
    "< 5" = "2",
    "< 5" = "3",
    "< 5" = "4",
    "6-7" = "6",
    "6-7" = "7",
    "8-9" = "8",
    "8-9" = "9"
  )) |>
    ## Réordonnancement de tt$apgar_1
    mutate(apgar_1 = fct_relevel(apgar_1,
    "< 5", "6-7", "8-9", "10"
  )) |>
    mutate(apgar_5 = as.factor(as.character(apgar_5))) |>
    mutate(apgar_5 = fct_recode(apgar_5,
                                "< 5" = "3",
                                "6-7" = "6",
                                "8-9" = "8",
                                "8-9" = "9"
    )) |>
    ## Réordonnancement de tt$apgar_1
    mutate(apgar_5 = fct_relevel(apgar_5,
                                 "< 5", "6-7", "8-9", "10"
    ))
  #
  bn <- read_ods("data/EPIDEVIS1.ods", sheet = 'bnom')
  var_label(tt) <- bn$nom

  save(tt, file = "data/epidevis.RData")
}

importph()
load(file = "data/epidevis.RData")

