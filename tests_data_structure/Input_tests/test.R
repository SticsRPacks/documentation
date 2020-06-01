source("data_structure_functions.R")
library(tibble)
library(data.table)
library(tidyverse)
library(microbenchmark)
library(dplyr)
library(ggplot2)
library(memuse)

num_elem <- c(1000,10000,100000)

## List Vs Class

Structures_types <- c("list","class")

weights_list <- list()
weights_class <- list()

benchmarks_list_class <- vector("list",length(num_elem)*length(Structures_types))
cpt = 1

# Loop on structures (List,Class)
for (i in Structures_types) {
  cat("\nStructure : ",i,"\n")
  # Loop on size (10K,100K,1M)
  for (j in num_elem) {
    cat("iteration : ",j,"\n")
    # first call to creation functions to get the structure weight for the j size
    set.seed(1) # setting seed to have the same object between list and class
    test <- eval(parse(text=paste("list_of_usm_",i,"_by_lapply(",j,")",sep="")))
    if (i == "list") {
      if (j == 1000) {
        weights_list <- object.size(test)
      }
      else {
        weights_list <- append(weights_list,object.size(test))
      }
    }
    else {
      if (j == 1000) {
        weights_class <- object.size(test)
      }
      else {
        weights_class <- append(weights_class,object.size(test))
      }
    }

    benchmark
    benchmarks_list_class[[cpt]] <- microbenchmark(NPA_Lapply= eval(parse(text=paste("list_of_usm_",i,"_by_lapply(",j,")",sep=""))),
                                PA_Lapply = eval(parse(text=paste("list_of_usm_",i,"_by_PA_lapply(",j,")",sep=""))),
                                setup = set.seed(1),times = 100)
    cpt <- cpt + 1
  }
}

save(file = "List_Vs_Class_times.RData",benchmarks_list_class)

df_weights_list <- data.frame(Usms = num_elem, Valeurs = weights_list, type = "List")
df_weights_class <- data.frame(Usms = num_elem, Valeurs = weights_class, type = "Class")
df_weights_list_class <- rbind(df_weights_list,df_weights_class)
save(file = "List_Vs_Class_weights.RData",df_weights_list_class)

## Df Vs Dt Vs Tb

Structures_types <- c("dataframe","datatable","tibble")
benchmarks_df_dt_tb <- vector("list",length(Structures_types)*length(num_elem))
weights_dataframe <- list()
weights_datatable <- list()
weights_tibble <- list()
cpt = 1

for (i in Structures_types) {
  cat("\nStructure : ",i,"\n")
  # Loop on size (10K,100K,1M)
  for (j in num_elem) {
    cat("iteration : ",j,"\n")
    # first call to creation functions to get the structure weight for the j size
    set.seed(1) # setting seed to have the same object between list and class
    test <- eval(parse(text=paste("usm_",i,"_by_lapply(",j,")",sep="")))

    if (i == "dataframe") {
      if (j == 1000) {
        weights_dataframe <- object.size(test)
      }
      else {
        weights_dataframe <- append(weights_dataframe,object.size(test))
      }
    }
    else {
      if (i == "datatable") {
        if (j == 1000) {
          weights_datatable <- object.size(test)
        }
        else {
          weights_datatable <- append(weights_datatable,object.size(test))
        }
      }
      else {
        if (j == 1000) {
          weights_tibble <- object.size(test)
        }
        else {
          weights_tibble <- append(weights_tibble,object.size(test))
        }
      }
    }

    name1 <- paste(i,"_by_itself",sep="")
    name2 <- paste(i,"_by_lapply",sep="")
    # benchmark
    benchmarks_df_dt_tb[[cpt]] <- microbenchmark(name1 = eval(parse(text=paste("usm_",i,"_by_",i,"(",j,")",sep=""))),
                                                 name2 = eval(parse(text=paste("usm_",i,"_by_lapply(",j,")",sep=""))),
                                                 setup = set.seed(1),times = 10)
    cpt <- cpt + 1
  }
}

save(file = "Df_Vs_Dt_Vs_Tb_times.RData", list = "benchmarks_df_dt_tb")

df_weights_df <- data.frame(Usms = num_elem, Valeurs = weights_dataframe, type = "Dataframe")
df_weights_dt <- data.frame(Usms = num_elem, Valeurs = weights_datatable, type = "Datatable")
df_weights_tb <- data.frame(Usms = num_elem, Valeurs = weights_tibble, type = "Tibble")
weights_df_dt_tb <- rbind(weights_dataframe,weights_datatable,weights_tibble)
save(file = "Df_Vs_Dt_Vs_Tb_weights.RData",weights_df_dt_tb)

## Random extract

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
                                      times = 50)
  cpt <- cpt + 1

}

save(file = "random_extract.RData",benchmarks)

## Criteria extract

benchmarks <- vector("list",length(num_elem))
cpt = 1

for (i in num_elem) {
  set.seed(1)
  li <- list_of_usm_list_by_lapply(i)
  cla <- list_of_usm_class_by_lapply(i)
  df <- usm_dataframe_by_lapply(i)
  dt <- usm_datatable_by_lapply(i)
  tb <- usm_tibble_by_lapply(i)

  benchmarks[[cpt]] <- microbenchmark(criteria_extract_for_usm_list_class(li,"ground_name","sol_canne"),
                              criteria_extract_for_usm_list_class(cla,"ground_name","sol_canne"),
                              map_criteria_extract(li,"ground_name","sol_canne"),
                              map_criteria_extract(cla,"ground_name","sol_canne"),
                              criteria_extract_for_usm_df_dt_tb(df,"ground_name","sol_canne"),
                              criteria_extract_for_usm_df_dt_tb(dt,"ground_name","sol_canne"),
                              criteria_extract_for_usm_df_dt_tb(tb,"ground_name","sol_canne"),
                              times = 100)
  cpt <- cpt + 1
}

save(file = "Criteria_extract.RData",benchmarks)