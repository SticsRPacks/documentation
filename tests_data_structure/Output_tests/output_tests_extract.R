library(tibble)
library(data.table)
library(lubridate)
library(microbenchmark)
library(ggplot2)
library("SticsOnR")
library("SticsRFiles")
library(dplyr)

source("output_structures_functions.R")

# loading output simulation structure
load(file = file.path("sim_before_optim.RData"))

USM_list_1996 = c("bo96iN+","lu96iN+","lu96iN6")

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

memory.limit(size = 16000000000000)

## Extraction's tests
bench_times <- 100
sys_name <- Sys.info()[['sysname']]
opti_name <- paste0("benchmark_opti_",sys_name,"_")
multi_name <- paste0("benchmark_multi_",sys_name,"_")
analysis_name <- paste0("benchmark_analysis_",sys_name,"_")
opti_plot <- paste0("plot_opti_",sys_name,"_")
multi_plot <- paste0("plot_multi_",sys_name,"_")
analysis_plot <- paste0("plot_analysis_",sys_name,"_")

### Optimization's extraction test

#### First setup : DoE from 1 to 50K, 10 Usms and 289 Dates
# doe_samp <- c(1,10000,20000,30000,40000,50000)
# benchmark_opti_1 <- bench_get_dates_var(usm_list = USM_list_1996,
#                                 doe_samp = doe_samp,
#                                 usm_number = 10, 
#                                 sim_data = sim_data_289,
#                                 var_name = "HR_2", 
#                                 usm_name = "lu96iN6_2",
#                                 times = bench_times)
# 
# # save data !
# save(file = paste0(opti_name,"1.RData"), list = "benchmark_opti_1")
# 
# # plot
# bench_list2df(benchmark_opti_1) %>% mutate(med_time_log10 = log10(median)) %>%
# ggplot() + geom_line(aes(doe, med_time_log10, colour = expr)) + ggtitle("test") -> p_opti_1
# 
# 
# ggsave(filename = paste0(opti_plot, "1.png"), plot = p_opti_1)
# 
# gc()
# 
# 
# #### Second setup : DoE from 1 to 50K, 100 Usms and 20 Dates
# benchmark_opti_2 <- bench_get_dates_var(usm_list = USM_list_1996,
#                                       doe_samp = doe_samp,
#                                       usm_number = 100, 
#                                       sim_data = sim_data_20,
#                                       var_name = "HR_2", 
#                                       usm_name = "lu96iN6_2",
#                                       times = bench_times)
# 
# # save data !
# save(file = paste0(opti_name,"2.RData"), list = "benchmark_opti_2")
# 
# # plot
# bench_list2df(benchmark_opti_2) %>% mutate(med_time_log10 = log10(median)) %>%
# ggplot() + geom_line(aes(doe, med_time_log10, colour = expr)) -> p_opti_2
# 
# ggsave(filename = paste0(opti_plot, "2.png"), plot = p_opti_2)
# 
# gc()

### Multi-simulation's extraction test

#### First setup : 1 DoE, Usms from 100K to 500K and 289 Dates

usm_samp <- c(500000)

benchmark_multi_1 <- bench_get_usm_var(usm_list = USM_list_1996,
                                       doe = 1,
                                       usm_samp = usm_samp,
                                       sim_data = sim_data_289,
                                       var_name = "resmes",
                                       date = "1996-01-05",
                                       times = 10 )

multi_tb <- create_tibble3(usm_list,1,500000,sim_data_289)
multi_li <- create_list2(usm_list,1,500000,sim_data_289)


benchmark_multi_1 <- microbenchmark(li = list_get_usm_names_and_var_values2(multi_li,1,"resmes","1996-01-05"),
                                    tb = tibble_get_usm_names_and_var_values(multi_tb,1,"resmes","1996-01-05"),
                                    times = 10)

# save data !
save(file = paste0(multi_name,"1.RData"), list = "benchmark_multi_1")

# # plot
# bench_list2df(benchmark_multi_1, id = "usm") %>% mutate(med_time_log10 = log10(median)) %>%
# ggplot() + geom_line(aes(usm, med_time_log10, colour = expr)) -> p_multi_1
# 
# ggsave(filename = paste0(multi_plot, "1.png"), plot = p_multi_1)

gc()

#### Second setup : 1 DoE, Usms from 100K to 1 Million and 5 Dates
# usm_samp <- c(100000,200000,300000,400000,500000,600000,700000,800000,900000,1000000)
# 
# benchmark_multi_2 <- bench_get_usm_var(usm_list = USM_list_1996,
#                                        doe = 1,
#                                        usm_samp = usm_samp,
#                                        sim_data = sim_data_5, 
#                                        var_name = "resmes",
#                                        date = "1996-01-05", 
#                                        times = bench_times )
# 
# 
# # save data !
# save(file = paste0(multi_name,"2.RData"), list = "benchmark_multi_2")
# 
# # plot
# bench_list2df(benchmark_multi_2, id = "usm") %>% mutate(med_time_log10 = log10(median)) %>%
# ggplot() + geom_line(aes(usm, med_time_log10, colour = expr)) -> p_multi_2
# 
# ggsave(filename = paste0(multi_plot, "2.png"), plot = p_multi_2)
# 
# gc()
# 
# ### Analysis' extraction test
# 
# #### First setup : DoE from 10K to 50K, 10 Usms and 289 Dates
# doe_samp <- c(10000,20000,30000,40000,50000)
# benchmark_analysis_1 <- bench_get_doe_var(usm_list = USM_list_1996,
#                                         doe_samp = doe_samp,
#                                         usm_number = 10, 
#                                         sim_data = sim_data_289,
#                                         var_name = "HR_3", 
#                                         usm_name = "lu96iN6_2",
#                                         date = "1996-01-05",
#                                         times = bench_times)
# 
# # save data !
# save(file = paste0(analysis_name,"1.RData"), list = "benchmark_analysis_1")
# 
# # plot
# bench_list2df(benchmark_analysis_1) %>% mutate(med_time_log10 = log10(median)) %>%
# ggplot() + geom_line(aes(doe, med_time_log10, colour = expr)) -> p_analysis_1
# 
# ggsave(filename = paste0(analysis_plot, "1.png"), plot = p_analysis_1)
# 
# gc()
# 
# #### Second setup : DoE from 10K to 50K, 10 Usms and 5 Dates
# doe_samp <- c(10000,20000,30000,40000,50000)
# 
# benchmark_analysis_2 <- bench_get_doe_var(usm_list = USM_list_1996,
#                                             doe_samp = doe_samp,
#                                             usm_number = 10, 
#                                             sim_data = sim_data_5,
#                                             var_name = "HR_3", 
#                                             usm_name = "lu96iN6_2",
#                                             date = "1996-01-05",
#                                             times = bench_times)
# 
# 
# # save data !
# save(file = paste0(analysis_name,"2.RData"), list = "benchmark_analysis_2")
# 
# # plot
# bench_list2df(benchmark_analysis_2) %>% mutate(med_time_log10 = log10(median)) %>%
# ggplot() + geom_line(aes(doe, med_time_log10, colour = expr)) -> p_analysis_2
# 
# ggsave(filename = paste0(analysis_plot, "2.png"), plot = p_analysis_2)
# 
# gc()
# 
