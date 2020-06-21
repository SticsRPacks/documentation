source("data_structure_functions.R")
library(tibble)
library(data.table)
library(tidyverse)
library(microbenchmark)
library(dplyr)
library(ggplot2)
library(memuse)

num_elem <- c(1000,10000,100000)
# 
# ## List Vs Class
# 
# Structures_types <- c("list","class")
# 
# weights_list <- list()
# weights_class <- list()
# 
# benchmarks_list_class <- vector("list",length(num_elem)*length(Structures_types))
# cpt = 1
# 
# # Loop on structures (List,Class)
# for (i in Structures_types) {
#   cat("\nStructure : ",i,"\n")
#   # Loop on size (10K,100K,1M)
#   for (j in num_elem) {
#     cat("iteration : ",j,"\n")
#     # first call to creation functions to get the structure weight for the j size
#     set.seed(1) # setting seed to have the same object between list and class
#     test <- eval(parse(text=paste("list_of_usm_",i,"_by_lapply(",j,")",sep="")))
#     if (i == "list") {
#       if (j == 1000) {
#         weights_list <- object.size(test)
#       }
#       else {
#         weights_list <- append(weights_list,object.size(test))
#       }
#     }
#     else {
#       if (j == 1000) {
#         weights_class <- object.size(test)
#       }
#       else {
#         weights_class <- append(weights_class,object.size(test))
#       }
#     }
# 
#     benchmark
#     benchmarks_list_class[[cpt]] <- microbenchmark(NPA_Lapply= eval(parse(text=paste("list_of_usm_",i,"_by_lapply(",j,")",sep=""))),
#                                 PA_Lapply = eval(parse(text=paste("list_of_usm_",i,"_by_PA_lapply(",j,")",sep=""))),
#                                 setup = set.seed(1),times = 100)
#     cpt <- cpt + 1
#   }
# }
# 
# save(file = "List_Vs_Class_times.RData",benchmarks_list_class)
# 
# df_weights_list <- data.frame(Usms = num_elem, Valeurs = weights_list, type = "List")
# df_weights_class <- data.frame(Usms = num_elem, Valeurs = weights_class, type = "Class")
# df_weights_list_class <- rbind(df_weights_list,df_weights_class)
# save(file = "List_Vs_Class_weights.RData",df_weights_list_class)
# 
# ## Df Vs Dt Vs Tb
# 
# Structures_types <- c("dataframe","datatable","tibble")
# benchmarks_df_dt_tb <- vector("list",length(Structures_types)*length(num_elem))
# weights_dataframe <- list()
# weights_datatable <- list()
# weights_tibble <- list()
# cpt = 1
# 
# for (i in Structures_types) {
#   cat("\nStructure : ",i,"\n")
#   # Loop on size (10K,100K,1M)
#   for (j in num_elem) {
#     cat("iteration : ",j,"\n")
#     # first call to creation functions to get the structure weight for the j size
#     set.seed(1) # setting seed to have the same object between list and class
#     test <- eval(parse(text=paste("usm_",i,"_by_lapply(",j,")",sep="")))
# 
#     if (i == "dataframe") {
#       if (j == 1000) {
#         weights_dataframe <- object.size(test)
#       }
#       else {
#         weights_dataframe <- append(weights_dataframe,object.size(test))
#       }
#     }
#     else {
#       if (i == "datatable") {
#         if (j == 1000) {
#           weights_datatable <- object.size(test)
#         }
#         else {
#           weights_datatable <- append(weights_datatable,object.size(test))
#         }
#       }
#       else {
#         if (j == 1000) {
#           weights_tibble <- object.size(test)
#         }
#         else {
#           weights_tibble <- append(weights_tibble,object.size(test))
#         }
#       }
#     }
# 
#     name1 <- paste(i,"_by_itself",sep="")
#     name2 <- paste(i,"_by_lapply",sep="")
#     # benchmark
#     benchmarks_df_dt_tb[[cpt]] <- microbenchmark(name1 = eval(parse(text=paste("usm_",i,"_by_",i,"(",j,")",sep=""))),
#                                                  name2 = eval(parse(text=paste("usm_",i,"_by_lapply(",j,")",sep=""))),
#                                                  setup = set.seed(1),times = 10)
#     cpt <- cpt + 1
#   }
# }
# 
# save(file = "Df_Vs_Dt_Vs_Tb_times.RData", list = "benchmarks_df_dt_tb")
# 
# df_weights_df <- data.frame(Usms = num_elem, Valeurs = weights_dataframe, type = "Dataframe")
# df_weights_dt <- data.frame(Usms = num_elem, Valeurs = weights_datatable, type = "Datatable")
# df_weights_tb <- data.frame(Usms = num_elem, Valeurs = weights_tibble, type = "Tibble")
# weights_df_dt_tb <- rbind(weights_dataframe,weights_datatable,weights_tibble)
# save(file = "Df_Vs_Dt_Vs_Tb_weights.RData",weights_df_dt_tb)
# 
# ## Random extract
# 
# benchmarks <- vector("list",length(num_elem))
# cpt = 1
# 
# for (i in num_elem) {
#   cat("iteration : ",i,"\nInitialisation\n")
#   random_names <- get_random_names(i)
#   set.seed(1)
#   li <- list_of_usm_list_by_lapply(i)
#   cla <- list_of_usm_class_by_lapply(i)
#   df <- usm_dataframe_by_lapply(i)
#   dt <- usm_datatable_by_lapply(i)
#   tb <- usm_tibble_by_lapply(i)
#   cat("benchmark\n")
#   benchmarks[[cpt]] <- microbenchmark(random_extract_for_usm_list_class(li,random_names),
#                                       random_extract_for_usm_list_class(cla,random_names),
#                                       map_random_extract(li,random_names),
#                                       map_random_extract(cla,random_names),
#                                       random_extract_for_usm_df_dt_tb(df,random_names),
#                                       random_extract_for_usm_df_dt_tb(dt,random_names),
#                                       random_extract_for_usm_df_dt_tb(tb,random_names),
#                                       setup = set.seed(1),
#                                       times = 50)
#   cpt <- cpt + 1
# 
# }
# 
# save(file = "random_extract.RData",benchmarks)
# 
# ## Criteria extract
# 
# benchmarks <- vector("list",length(num_elem))
# cpt = 1
# 
# for (i in num_elem) {
#   set.seed(1)
#   li <- list_of_usm_list_by_lapply(i)
#   cla <- list_of_usm_class_by_lapply(i)
#   df <- usm_dataframe_by_lapply(i)
#   dt <- usm_datatable_by_lapply(i)
#   tb <- usm_tibble_by_lapply(i)
# 
#   benchmarks[[cpt]] <- microbenchmark(criteria_extract_for_usm_list_class(li,"ground_name","sol_canne"),
#                               criteria_extract_for_usm_list_class(cla,"ground_name","sol_canne"),
#                               map_criteria_extract(li,"ground_name","sol_canne"),
#                               map_criteria_extract(cla,"ground_name","sol_canne"),
#                               criteria_extract_for_usm_df_dt_tb(df,"ground_name","sol_canne"),
#                               criteria_extract_for_usm_df_dt_tb(dt,"ground_name","sol_canne"),
#                               criteria_extract_for_usm_df_dt_tb(tb,"ground_name","sol_canne"),
#                               times = 100)
#   cpt <- cpt + 1
# }
# 
# save(file = "Criteria_extract.RData",benchmarks)

# load("List_Vs_Class_times.RData")
# load("List_Vs_Class_weights.RData")
# load("Df_Vs_Dt_Vs_Tb_times.RData")
# load("Df_Vs_Dt_Vs_Tb_weights.RData")
# 
# df_list_class <- bench_list2df(benchmarks_list_class)
# df_df_dt_tb <- bench_list2df(benchmarks_df_dt_tb)
# 
# time_unit = paste("median_log10_",df_list_class$unit[1],sep="")
# 
# df_npa_list <- dplyr::filter(df_list_class,doe <= 3,expr == "NPA_Lapply")
# df_weights_list <- dplyr::filter(df_weights_list_class, type == "List")
# list_npa <- data.frame(Usms = num_elem, Valeurs = log10(df_npa_list$median), type = "List")
# weights_list <- data.frame(Usms = num_elem,Valeurs = log10(df_weights_list$Valeurs), type = "List")
# 
# df_npa_class <- dplyr::filter(df_list_class ,doe > 3, expr == "NPA_Lapply")
# df_weights_class <- dplyr::filter(df_weights_list_class, type == "Class")
# class_npa <- data.frame(Usms = num_elem,Valeurs = log10(df_npa_class$median), type = "Class")
# weights_class <- data.frame(Usms = num_elem,Valeurs = log10(df_weights_class$Valeurs), type = "Class")
# 
# df_lapply <- dplyr::filter(df_df_dt_tb,doe < 4,expr == "name2" )
# df_weights <- weights_df_dt_tb[1,]
# lapply_df <- data.frame(Usms = num_elem, Valeurs = log10(df_lapply$median), type = "Dataframe")
# weights_df <- data.frame(Usms = num_elem, Valeurs = log10(df_weights), type = "Dataframe")
# 
# dt_lapply <- dplyr::filter(df_df_dt_tb,doe > 3,doe < 7,expr == "name2")
# dt_weights <- weights_df_dt_tb[2,]
# lapply_dt <- data.frame(Usms = num_elem, Valeurs = log10(dt_lapply$median), type = "Datatable")
# weights_dt <- data.frame(Usms = num_elem, Valeurs = log10(dt_weights), type = "Datatable")
# 
# tb_lapply <- dplyr::filter(df_df_dt_tb,doe > 6,expr == "name2")
# tb_weights <- weights_df_dt_tb[3,]
# lapply_tb <- data.frame(Usms = num_elem, Valeurs = log10(tb_lapply$median), type = "Tibble")
# weights_tb <- data.frame(Usms = num_elem, Valeurs = log10(tb_weights), type = "Tibble")
# 
# final_times <- rbind(list_npa,class_npa,lapply_df,lapply_dt,lapply_tb)
# ggplot(final_times)+geom_line(aes(Usms,Valeurs,colour=type))+labs(y = time_unit)
# 
# final_weights <- rbind(weights_list,weights_class,weights_df,weights_dt,weights_tb)
# ggplot(final_weights)+geom_line(aes(Usms,Valeurs,colour=type))+labs(y = "log10_bytes")