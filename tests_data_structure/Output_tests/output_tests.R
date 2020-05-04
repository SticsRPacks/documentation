#devtools::install_github("SticsRPacks/SticsRPacks")
library(tidyverse)
library(tibble)
library(data.table)
library(lubridate)
library(microbenchmark)
library(ggplot2)
library("SticsRPacks")
library("SticsOnR")
library("SticsRFiles")


source("output_structures_functions.R")

# Download the example USMs:
#data_dir= file.path(SticsRFiles::download_data(),"study_case_1","V9.0")
# NB: all examples are now in data_dir

# DEFINE THE PATH TO YOUR LOCALLY INSTALLED VERSION OF JAVASTICS
####################################################################################
path_to_JavaStics="C:/Users/Thomas/Documents/GitHub/SticsRTests/inst/stics"  ############ A MODIFIER #####################
####################################################################################
javastics_path=file.path(path_to_JavaStics,"JavaSTICS-1.41-stics-9.0")
stics_path=file.path(javastics_path,"bin/stics_modulo.exe")

#'
#' ## Generate Stics input files from JavaStics input files
#' The Stics wrapper function used in CroptimizR works on text formatted input files (new_travail.usm,
#' climat.txt, ...) stored per USMs in different directories (which names must be the USM names).
#' `stics_inputs_path` is here the path of the directory that will contain these USMs folders.
stics_inputs_path = "C:/Users/Thomas/Documents/V9.0/TxtFiles"
#stics_inputs_path=file.path(data_dir,"TxtFiles")
dir.create(stics_inputs_path)
#' ## Run the model before optimization for a prior evaluation
# Set the model options (see '? stics_wrapper_options' for details)
model_options=stics_wrapper_options(stics_path,stics_inputs_path,
                                    parallel=FALSE)
# Run the model on all situations found in stics_inputs_path
sim_before_optim=stics_wrapper(model_options=model_options)

################### DATAS ################################

# stics_inputs_path est l'emplacement du dossier V9.0/TxtFiles apr?s avoir ?x?cut? RunModel.R
#stics_inputs_path = "C:/Users/Thomas/Documents/V9.0/TxtFiles"

USM_list_all = c("bo96iN+","bou00t1","bou00t3","bou99t1","bou99t3","lu96iN+",
                 "lu96iN6","lu97iN+")

USM_list_1996 = c("bo96iN+","lu96iN+","lu96iN6")


############### TESTS ############################

# Instanciation of data structures
#
# Get output data sub-list from stics_wrapper run (RunModel_test.R)
# for USM_list_1996
sim_data <- sim_before_optim$sim_list[[1]][USM_list_1996]


# Selecting needed data
sim_data_5 <- lapply(sim_data, function(x)
  dplyr::select(x,Date,jul,lai_n,masec_n,mafruit,HR_1,HR_2,HR_3,HR_4,HR_5,resmes) %>%
    dplyr::filter(Date >= ymd("1996/01/01") & Date <= ymd("1996/01/05")))

sim_data_20 <- lapply(sim_data, function(x)
  dplyr::select(x,Date,jul,lai_n,masec_n,mafruit,HR_1,HR_2,HR_3,HR_4,HR_5,resmes) %>%
    dplyr::filter(Date >= ymd("1996/01/01") & Date <= ymd("1996/01/20")))

sim_data_289 <- lapply(sim_data, function(x)
  dplyr::select(x,Date,jul,lai_n,masec_n,mafruit,HR_1,HR_2,HR_3,HR_4,HR_5,resmes) %>%
    dplyr::filter(Date >= ymd("1996/01/01") & Date <= ymd("1996/10/15")))

#Creating tibble and list instances
# tb <- create_tibble(USM_list_1996,2,6,sim_data)
# tb2 <- create_tibble2(USM_list_1996,2,6,sim_data)
# identical(tb, tb2)
# tb
# tb2
# 
#li <- create_list(USM_list_1996,2,6,sim_data)
# li2 <- create_list2(USM_list_1996,2,6,sim_data)
# identical(li, li2)
#list_get_usm_names_and_var_values(li,1,"HR_4","1996/01/05")

# #########################
# # fonctionne
# tb_dates_val <- tibble_get_dates_and_var_values(tb,doe = 1,usm_name = "bo96iN+_2",var = "HR_1")
# 
# # # A tibble: 289 x 2
# # Date                 HR_1
# # <dttm>              <dbl>
# #   1 1996-01-01 00:00:00  31.6
# # 2 1996-01-02 00:00:00  31.6
# # 3 1996-01-03 00:00:00  31.6
# # 4 1996-01-04 00:00:00  31.6
# # 5 1996-01-05 00:00:00  31.6
# # 6 1996-01-06 00:00:00  31.6
# # 7 1996-01-07 00:00:00  31.6
# # 8 1996-01-08 00:00:00  31.6
# # 9 1996-01-09 00:00:00  31.6
# # 10 1996-01-10 00:00:00  31.6
# # # … with 279 more rows
# 
# # fonctionne
# li_dates_val <- list_get_dates_and_var_values(li,1,"bo96iN+_2","HR_1")
# 
# # # A tibble: 289 x 2
# # Date                 HR_1
# # <dttm>              <dbl>
# #   1 1996-01-01 00:00:00  31.6
# # 2 1996-01-02 00:00:00  31.6
# # 3 1996-01-03 00:00:00  31.6
# # 4 1996-01-04 00:00:00  31.6
# # 5 1996-01-05 00:00:00  31.6
# # 6 1996-01-06 00:00:00  31.6
# # 7 1996-01-07 00:00:00  31.6
# # 8 1996-01-08 00:00:00  31.6
# # 9 1996-01-09 00:00:00  31.6
# # 10 1996-01-10 00:00:00  31.6
# # # … with 279 more rows
# 
# 
# # Les objets retournés sont les mêmes 
# identical(tb_dates_val, li_dates_val)
# 
# # TODO: voir si les fonctions doivent retourner la même chose ! 
# 
# 
# #########################
# 
# # fonctionne
# tb_usms_val <- tibble_get_usm_names_and_var_values(tb,1,"HR_4","1996-01-05")
# 
# # # A tibble: 6 x 2
# # Name       HR_4
# # <chr>     <dbl>
# #   1 bo96iN+_1   0  
# # 2 bo96iN+_2   0  
# # 3 lu96iN+_1  28.4
# # 4 lu96iN+_2  28.4
# # 5 lu96iN6_1  28.4
# # 6 lu96iN6_2  28.4
# 
# 
# # fonctionne
# li_usms_val <- list_get_usm_names_and_var_values(li,1,"HR_4","1996/01/05")
# 
# # On perd le nom de la variable !
# 
# # matrix
# 
# # names       values  
# # [1,] "bo96iN+_1" 0       
# # [2,] "bo96iN+_2" 0       
# # [3,] "lu96iN+_1" 28.35693
# # [4,] "lu96iN+_2" 28.35693
# # [5,] "lu96iN6_1" 28.35693
# # [6,] "lu96iN6_2" 28.35693
# 
# # Le type n'est pas le même qu'avec tibble_get_usm_names_and_var_values
# # et on perd le nom de la variable, alors qu'elle est dans tb_usms_val
# 
# 
# # comparaison des objets retournés : voir si les fonctions doivent retourner la même chose ! 
# identical(tb_usms_val, li_usms_val)
# 
# 
# li_usms_val2 <- list_get_usm_names_and_var_values2(li,1,"HR_4","1996/01/05")
# 
# # # A tibble: 6 x 2
# # Name       HR_4
# # <chr>     <dbl>
# #   1 bo96iN+_1   0  
# # 2 bo96iN+_2   0  
# # 3 lu96iN+_1  28.4
# # 4 lu96iN+_2  28.4
# # 5 lu96iN6_1  28.4
# # 6 lu96iN6_2  28.4
# 
# 
# 
# #########################
# 
# # fonctionne
# tb_doe_val <- tibble_get_DOE_and_var_values(tb,"bo96iN+_2","HR_3","1996/01/05")
# 
# # # A tibble: 2 x 2
# # DoE  HR_3
# # <int> <dbl>
# # 1     1  26.0
# # 2     2  26.0
# 
# 
# # fonctionne
# li_doe_val <- list_get_DOE_and_var_values(li,"bo96iN+_1","HR_3","1996/01/05")
# 
# # On perd le nom de la variable , alors qu'elle est dans tb_doe_val
# 
# # matrix
# # 
# # DOE values  
# # [1,] 1   26.00001
# # [2,] 2   26.00001
# 
# 
# li_doe_val2 <- list_get_DOE_and_var_values2(li,"bo96iN+_1","HR_3","1996/01/05")
# 
# # # A tibble: 2 x 2
# # Name   HR_3
# # <chr> <dbl>
# # 1 1      26.0
# # 2 2      26.0

# once you allocated memory, if your pc freeze or bug because of the new allocated memory for R
# just restart your R session and the memory will be reset to its initial value

# memory.limit(size = 8000000000000)
# memory.limit()
# gc()
# multi_tb <- create_tibble2(USM_list_1996,1,150000,sim_data_289)
# gc()
# tibble_get_usm_names_and_var_values(multi_tb,1,"resmes","1996-01-05")
# save(multi_tb, file="MultiSimulation_tibble.RData")
# gc()
# load(file = "MultiSimulation_tibble.RData")
# res = tibble_get_dates_and_var_values(multi_tb,1,"lu96iN+_133","HR_1")
# res
# analysis_tb <- create_tibble2(USM_list_1996,50000,10,sim_data)
# save(analysis_tb, file = "Analysis_tibble.RData")
# analysis_tb
# gc()?

# load(file = "Analysis_tibble.RData")
# analysis_li <- create_list2(USM_list_1996,50000,500,sim_data)
