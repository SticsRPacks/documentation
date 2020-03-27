library(tidyverse)
library(tibble)
library(data.table)
library(lubridate)
library(microbenchmark)

################### DATAS ################################

# stics_inputs_path est l'emplacement du dossier V9.0/TxtFiles après avoir éxécuté RunModel.R
stics_inputs_path = "C:/Users/Thomas/Documents/V9.0/TxtFiles"

USM_list_all = c("bo96iN+","bou00t1","bou00t3","bou99t1","bou99t3","lu96iN+",
                 "lu96iN6","lu97iN+")

USM_list_1996 = c("bo96iN+","lu96iN+","lu96iN6")

################### CREATION ############################

Date = function(size) {
  return(structure(rep(NA_real_,size),class="POSIXct"))
}

# fonction qui crée l'alternative tibble
# elle prend en paramètres :
# _ USM_list qui correspond au vecteur de noms des USMS, ici c'est USM_list_1996
# _ doe_size qui correspond à la taille du DoE, ici c'est 2
# _ usm_number qui est le nombre d'USMS différentes, ici 6
# _ stics_inputs_path pour get_daily_result
create_tibble = function(USM_list,doe_size,usm_number,stics_inputs_path) {
  tb <<- tibble(Name=character(),DoE=numeric(),Date=Date(),Jul=numeric(),
                Lai_n=double(),Masec_n=double(),Mafruit=double(),Hr_1=double(),
                Hr_2=double(),Hr_3=double(),Hr_4=double(),Hr_5=double(),Resmes=double())
  lapply(1:doe_size, function(doe) {
    lapply(1:length(USM_list), function(usm) {
      tibble_res = SticsRFiles::get_daily_results(file.path(stics_inputs_path, USM_list[usm]), USM_list[usm])
      tibble_res = dplyr::select(tibble_res,Date,jul,lai_n,masec_n,mafruit,HR_1,HR_2,HR_3,HR_4,HR_5,resmes)
      tibble_res = dplyr::filter(tibble_res,Date >= ymd("1996/01/01") & Date <= ymd("1996/10/15"))
      Name = rep(NA,nrow(tibble_res))
      DoE = rep(doe,nrow(tibble_res))
      tibble_res = cbind(Name,DoE,tibble_res)
      lapply(1:(usm_number/length(USM_list)), function(id) {
        Name = rep(paste(USM_list[usm],"_",id,sep=""),nrow(tibble_res))
        tibble_res[,1] = Name
        tb <<- rbind(tb,tibble_res)
      })
    })
  })
  return(tibble(tb))
}

create_list = function(USM_list,doe_size,usm_number,stics_inputs_path) {
  li <- vector("list",doe_size)
  lapply(1:doe_size, function(doe) {
    cpt = 1
    li2 = vector("list",length(USM_list)*floor(usm_number/length(USM_list)))
    names_usm = vector("list",length(USM_list)*floor(usm_number/length(USM_list)))
    lapply(1:length(USM_list), function(usm) {
      tibble_res = SticsRFiles::get_daily_results(file.path(stics_inputs_path, USM_list[usm]), USM_list[usm])
      tibble_res = dplyr::select(tibble_res,Date,jul,lai_n,masec_n,mafruit,HR_1,HR_2,HR_3,HR_4,HR_5,resmes)
      tibble_res = dplyr::filter(tibble_res,Date >= ymd("1996/01/01") & Date <= ymd("1996/10/15"))
      lapply(1:(usm_number/length(USM_list)), function (id) {
        Name = paste(USM_list[usm],"_",id,sep="")
        names_usm[[cpt]] <<- Name
        li2[[cpt]] <<- tibble_res[,]
        cpt <<- cpt+1
      })
    })
    names(li2) <- names_usm
    li[[doe]] <<- li2
  })
  names(li) <- 1:doe_size
  return(li)
}

################# EXTRACTION ################################

list_get_dates_and_var_values = function(structure,doe,usm_name,var) {
  structure[[doe]][[usm_name]][,c("Date",var)]
}

tibble_get_dates_and_var_values = function(structure,doe,usm_name,var) {
  var <- enquo(var)
  n <- names(structure)
  tb <- structure[[n]]
  tb <- dplyr::filter(tb,DoE == doe,Name == usm_name)
  dplyr::select(tb,Date,!!var)
}

########################################

list_get_usm_names_and_var_values = function(structure,doe,var,date) {
  names = vector("list",length(structure[[doe]]))
  values = vector("list",length(structure[[doe]]))
  lapply(1:length(structure[[doe]]), function(id_usm) {
    id_var <- which(structure[[doe]][[id_usm]]$Date == ymd_hms(date))
    values[id_usm] <<- structure[[doe]][[id_usm]][id_var,var]
    names[id_usm] <<- names(structure[[doe]][id_usm])
  })
  cbind(names,values)
}

tibble_get_usm_names_and_var_values = function(structure,doe,var,date) {
  var <- enquo(var)
  n <- names(structure)
  tb <- structure[[n]]
  tb <- dplyr::filter(tb,DoE == doe,Date == ymd(date))
  dplyr::select(tb,Name,!!var)
}

#########################################

list_get_DOE_and_var_values = function(structure,usm_name,var,date) {
  DOE <- vector("list",length(structure))
  values <- vector("list",length(structure))
  lapply(1:length(structure), function(doe) {
    id_usm <- which(names(structure[[doe]]) == usm_name)
    id_var <- which(structure[[doe]][[id_usm]]$Date == ymd_hms(date))
    values[doe] <<- structure[[doe]][[id_usm]][id_var,var]
    DOE[doe] <<- doe
  })
  cbind(DOE,values)
}

tibble_get_DOE_and_var_values = function(structure,usm_name,var,date) {
  var <- enquo(var)
  n <- names(structure)
  tb <- structure[[n]]
  tb <- dplyr::filter(tb,Name == usm_name,Date == ymd(date))
  dplyr::select(tb,DoE,!!var)
}

############### TESTS ############################

# fonctionne
# tb <- create_tibble(USM_list_1996,2,6,stics_inputs_path)
# res <- tibble_get_dates_and_var_values(tb,1,"bo96iN+_2","HR_1")
# res

# fonctionne
# li <- create_list(USM_list_1996,2,6,stics_inputs_path)
# li2 <- list_get_dates_and_var_values(li,1,"bo96iN+_2","HR_1")
# li2

#########################

# fonctionne
# tb <- create_tibble(USM_list_1996,2,6,stics_inputs_path)
# res <- tibble_get_usm_names_and_var_values(tb,1,"HR_4","1996-01-05")
# res

# fonctionne
# li <- create_list(USM_list_1996,2,6,stics_inputs_path)
# li2 <- list_get_usm_names_and_var_values(li,1,"HR_4","1996/01/05-00/00/00")
# li2

#########################

# fonctionne
# tb <- create_tibble(USM_list_1996,2,6,stics_inputs_path)
# res <- tibble_get_DOE_and_var_values(tb,"bo96iN+_2","HR_3","1996-01-05")
# res

# fonctionne
# li <- create_list(USM_list_1996,2,6,stics_inputs_path)
# li2 <- list_get_DOE_and_var_values(li,"bo96iN+_1","HR_3","1996/01/05-00/00/00")
# li2

