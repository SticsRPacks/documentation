library(microbenchmark)
library(dplyr)
library(data.table)
library(tibble)

source("data_structure_functions.R")

num_elem <- c(1000,10000,100000)
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
weights_df_dt_tb <- cbind(weights_dataframe,weights_datatable,weights_tibble)
save(file = "Df_Vs_Dt_Vs_Tb_weights.RData",weights_df_dt_tb)

