source("data_structure_functions.R")
library(tibble)
library(data.table)
library(tidyverse)
library(microbenchmark)
library(dplyr)
library(ggplot2)
library(memuse)

# a voir pour une alternative a object.size()
object.size(vector_usm_list(10000))
memuse(vector_usm_list(10000))
object.size(vector_usm_class(10000))
memuse(vector_usm_class(10000))


# this test takes 5 min
# list <- vector_usm_list(10000)
# benchmark = microbenchmark(random_extract_for_usm_list_class(5000,list),random_sub_list(5000,list),
#                            times = 100)
# 
# benchmark
# ggplot2::autoplot(benchmark)

# list <- vector_usm_list(10)
# df <- vector_usm_dataframe(10)
# 
# list_sub <- extract_between_index_for_list_class(df,2,8)
# list_sub
# 
# # between version slice ne fonctionne pas
# sub_list <- extract_between_index_for_df_dt_tb(df,2,8)
# sub_list
# 
