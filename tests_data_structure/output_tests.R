library(tidyverse)
library(tibble)
library(lubridate)

# stics_inputs_path est l'emplacement du dossier V9.0/TxtFiles après avoir éxécuté RunModel.R
stics_inputs_path = "C:/Users/Thomas/Documents/V9.0/TxtFiles"

USM_list_all = c("bo96iN+","bou00t1","bou00t3","bou99t1","bou99t3","lu96iN+",
                 "lu96iN6","lu97iN+")

USM_list_1996 = c("bo96iN+","lu96iN+","lu96iN6")

# fonction qui crée l'alternative tibble
# elle prend en paramètres :
# _ USM_list qui correspond au vecteur de noms des USMS, ici c'est USM_list_1996
# _ doe_size qui correspond à la taille du DoE, ici c'est 2
# _ usm_number qui est le nombre d'USMS différentes, ici 6
# _ stics_inputs_path pour get_daily_result
create_tibble_optimization_1 = function(USM_list,doe_size,usm_number,stics_inputs_path) {
  li <- lapply(1:doe_size,function(x) {
    lapply(USM_list,function(usm) {
      # usm_number/length(usm_list) pour qu'il y ai autant de bo96iN+_1 que de lu96iN+_1 
       lapply(1:(usm_number/length(USM_list)),function(id) {
        # rep avec 10 car j'ai pris 10 dates à chaque fois
        Name = rep(paste(usm,"_",id,sep=""),10)
        DoE = rep(x,10)
        tibble_res = get_daily_results(file.path(stics_inputs_path, usm), usm)
        tibble_res = dplyr::select(tibble_res,Date,jul,lai_n,masec_n,mafruit,HR_1,HR_2,HR_3,HR_4,HR_5,resmes)
        tibble_res = dplyr::filter(tibble_res,Date >= ymd("1996/09/01") & Date <= ymd("1996/09/10"))
        tibble_res = cbind(Name,DoE,tibble_res)
        tibble_res = tibble(tibble_res)
      })
    })
  })
  return(rbindlist(li))
}

# fonction qui crée l'alternative tibble
# elle prend en paramètres :
# _ USM_list qui correspond au vecteur de noms des USMS, ici c'est USM_list_1996
# _ doe_size qui correspond à la taille du DoE, ici c'est 2
# _ usm_number qui est le nombre d'USMS différentes, ici 6
# _ stics_inputs_path pour get_daily_result
create_tibble_optimization_2 = function(USM_list,doe_size,usm_number,stics_inputs_path) {
  # taille du grand tibble (10 dates * taille du DoE * nombre d'usm = 120 dans le cas que j'ai testé)
  size = 10*doe_size*usm_number
  tb = tibble(Name=character(size),DoE=numeric(size),Date=character(size),Jul=numeric(size),
              Lai_n=double(size),Masec_n=double(size),Mafruit=double(size),Hr_1=double(size),
              Hr_2=double(size),Hr_3=double(size),Hr_4=double(size),Hr_5=double(size),Resmes=double(size))
  cpt = 1
  for (doe in 1:doe_size) {
    for (usm in USM_list) {
      for (id in 1:(usm_number/length(USM_list))) {
        Name = rep(paste(usm,"_",id,sep=""),10)
        DoE = rep(doe,10)
        tibble_res = get_daily_results(file.path(stics_inputs_path, usm), usm)
        tibble_res = dplyr::select(tibble_res,Date,jul,lai_n,masec_n,mafruit,HR_1,HR_2,HR_3,HR_4,HR_5,resmes)
        tibble_res = dplyr::filter(tibble_res,Date >= ymd("1996/09/01") & Date <= ymd("1996/09/10"))
        tibble_res = cbind(Name,DoE,tibble_res)
        tibble_res = tibble(tibble_res)
        for(i in 1:nrow(tibble_res)) {
          tb[cpt,] <- tibble_res[i,]
          cpt = cpt+1
        }
      }
    }
  }
  return(tb)
}

create_list_optimization = function(USM_list,doe_size,usm_number,stics_inputs_path) {
  lapply(1:doe_size,function(x) {
    lapply(USM_list,function(usm) {
      lapply(1:(usm_number/length(USM_list)),function(id) {
        Name = rep(paste(usm,"_",id,sep=""),10)
        DoE = rep(x,10)
        tibble_res = get_daily_results(file.path(stics_inputs_path, usm), usm)
        tibble_res = dplyr::select(tibble_res,Date,jul,lai_n,masec_n,mafruit,HR_1,HR_2,HR_3,HR_4,HR_5,resmes)
        tibble_res = dplyr::filter(tibble_res,Date >= ymd("1996/09/01") & Date <= ymd("1996/09/10"))
        tibble_res = cbind(Name,DoE,tibble_res)
      })
    })
  })
}

tb <- create_tibble_optimization_1(USM_list_1996,2,6,stics_inputs_path)
tb

