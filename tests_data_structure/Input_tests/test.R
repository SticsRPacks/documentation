source("data_structure_functions.R")
library(tibble)
library(data.table)
library(tidyverse)
library(microbenchmark)
library(dplyr)
library(ggplot2)
library(memuse)

tb <- usm_tibble_by_tibble(10)
tb