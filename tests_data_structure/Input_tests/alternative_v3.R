library(microbenchmark)
library(dplyr)
library(data.table)
library(tibble)

source("data_structure_functions.R")

num_elem <- c(1000,10000,100000)

benchmarks <- vector("list",length(num_elem))
cpt = 1

for (i in num_elem) {
  cat("iteration : ",i,"\nInitialisation\n")
  random_names <- get_random_names(i)
  set.seed(1)
  li <- list_of_usm_list_by_lapply(i)
  cla <- list_of_usm_class_by_lapply(i)
  df <- usm_dataframe_by_lapply(i)
  dt <- usm_datatable_by_lapply(i)
  tb <- usm_tibble_by_lapply(i)
  cat("benchmark\n")
  benchmarks[[cpt]] <- microbenchmark(random_extract_for_usm_list_class(li,random_names),
                                      random_extract_for_usm_list_class(cla,random_names),
                                      map_random_extract(li,random_names),
                                      map_random_extract(cla,random_names),
                                      random_extract_for_usm_df_dt_tb(df,random_names),
                                      random_extract_for_usm_df_dt_tb(dt,random_names),
                                      random_extract_for_usm_df_dt_tb(tb,random_names),
                                      setup = set.seed(1),
                                      times = 100)
  cpt <- cpt + 1
  
}

save("random_extract.RData",benchmarks)