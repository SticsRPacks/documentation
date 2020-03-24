library(tidyverse)
library(tibble)

usm_list = c("bo96iN+","bou00t1","bou00t3","bou99t1","bou99t3","lu96iN+",
             "lu96iN6","lu97iN+")
DOE_size = 2
origins = c("obs","sim")
plants = c(1,2)
dates = c("2009-01-01","2009-01-02","2009-01-03","2009-02-17","2009-03-14")
stages = c("rep","mat","rep mat","NA")
LAIS = c(0,1)

get_values_by_usm_and_doe = function(structure,usm,doe) {
  dplyr::filter(structure,USM==usm,DOE==doe)
}

get_values_by_usm_var_and_date = function(structure,usm,var,wanted,date) {
  var <- enquo(var)
  dplyr::filter(structure,USM==usm & !!var == wanted & Date==date)
}

# get_doe_values_by_usm_var_and_date = function(structure,usm,var,wanted,date) {
#   dplyr::select(get_values_by_usm_var_and_date(structure,usm,var,wanted,date),DOE)
# }

create_tibble = function(usm,doe,origin,plant,date,stage,lai) {
  return(tibble("usm"=usm,"doe"=doe,"origin"=origin,"plant"=plant,
                "date"=date,"stage"=stage,"lai"=lai))
}

insert_data = function(usm_list,DOE_size,origins,plants,dates,stages,LAIS) {
  size = DOE_size*length(usm_list)*length(origins)*length(plants)*length(dates)*
    length(stages)*length(LAIS)
  tb <- tibble(USM=character(size),DOE=numeric(size),Origin=character(size),Plant=numeric(size),
               Date=character(size),Stage=character(size),LAI=numeric(size))
  cpt = 1
  for(doe in 1:DOE_size) {
    for(usm in usm_list) {
      for(date in dates) {
        for(plant in plants) {
          for(lai in LAIS) {
            for(origin in origins) {
              for(stage in stages) {
                tb[cpt,] <- create_tibble(usm,doe,origin,plant,date,stage,lai)
                cpt = cpt + 1
              }
            }
          }
        }
      }
    }
  }
  return(tb)
}

tb <- insert_data(usm_list,DOE_size,origins,plants,dates,stages,LAIS)

test <- get_values_by_usm_and_doe(tb,"lu97iN+",2)
test

test2 <- get_values_by_usm_var_and_date(tb,"lu97iN+","Stage","rep","2009-01-01")
test2