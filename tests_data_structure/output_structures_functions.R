

################### DATA STRUCTURES CREATION ############################

# Date = function(size) {
#   return(structure(rep(NA_real_,size),class="POSIXct"))
# }

# fonction qui cr?e l'alternative tibble
# elle prend en param?tres :
# _ USM_list qui correspond au vecteur de noms des USMS, ici c'est USM_list_1996
# _ doe_size qui correspond ? la taille du DoE, ici c'est 2
# _ usm_number qui est le nombre d'USMS diff?rentes, ici 6
# _ stics_inputs_path pour get_daily_result
create_tibble = function(USM_list,doe_size,usm_number,sim_data) {
  size = doe_size*usm_number*nrow(sim_data[[1]])
  tb <- tibble(Name=character(size),Date=as.POSIXct.default((rep("1996-10-15",size))),
                jul=integer(size), lai_n=double(size),masec_n=double(size),
                mafruit=double(size), HR_1=double(size), HR_2=double(size),
                HR_3=double(size),HR_4=double(size), HR_5=double(size), resmes=double(size),DoE=integer(size))
  begin_id = 1
  end_id = nrow(sim_data[[1]])
  size_bis = nrow(sim_data[[1]])
  lapply(1:doe_size, function(doe) {
    lapply(USM_list, function(usm) {
      #tibble_res = SticsRFiles::get_daily_results(file.path(stics_inputs_path, USM_list[usm]), USM_list[usm])
      #tibble_res = sim_data[[usm]]
      # tibble_res = dplyr::select(tibble_res,Date,jul,lai_n,masec_n,mafruit,HR_1,HR_2,HR_3,HR_4,HR_5,resmes)
      # tibble_res = dplyr::filter(tibble_res,Date >= ymd("1996/01/01") & Date <= ymd("1996/10/15"))
      #Name = rep(NA,nrow(tibble_res))
      #DoE = rep(doe,nrow(tibble_res))
      #tibble_res = cbind(Name,DoE,tibble_res)
      lapply(1:(usm_number/length(USM_list)), function(id) {
        tb[begin_id:end_id,1] <<- rep(paste(usm,"_",id,sep=""),size_bis)
        tb[begin_id:end_id,2:12] <<- sim_data[[usm]]
        tb[begin_id:end_id,13] <<- rep(doe,size_bis)
        #tb[begin_id:end_id,] <<- cbind(rep(paste(usm,"_",id,sep=""),size_bis),sim_data[[usm]],rep(doe,size_bis))
        # la commande pr�c�dente ne veut pas s'executer, le champs "Name" est �gal a "1" pour chaque ligne
        begin_id <<- end_id + 1
        end_id <<- end_id + size_bis
      })
    })
  })
  # cette ligne sert � mettre les dates au format suivant : 1996-01-01 00:00:00 car auparavant elles etaient au
  # format : 1996-01-01 01:00:00
  setattr(tb$Date,'tzone','UTC')
  # Patrice
  # changing tibble to as_tibble 
  return(as_tibble(tb))
}





create_tibble2 = function(USM_list,doe_size,usm_number,sim_data) {
  # USM_list: vecteur des noms d'usm (parmi les noms de la liste sim_data) 
  # doe_size: nombre d'échantillons du doe
  # usm_number: nombre d'usm à générer à partir des usms de USM_list
  # sim_data: list de tibbles retournée par la fonction stics_wrapper 
  # avec sélection des colonnes et filrage des ligne sur une plage de dates
  # au préalable (voir dans TESTS plus bas)
  
  # replicating tibbles: each sim_data element by generated usm names 
  usms_nb <- length(USM_list)
  usm_names_nb <- usm_number/usms_nb
  #
  one_doe_tb <- lapply(1:usms_nb, function(x) {
    usm_sub_list <- rep(sim_data[x],usm_names_nb)
    names(usm_sub_list) <- paste(rep(USM_list[x],usm_names_nb), 1:usm_names_nb, sep="_")
    bind_rows(usm_sub_list, .id = "Name")
  })
  
  # Replicating one_doe_tb doe_size times; conversion to tibble
  tb <- bind_rows(rep(one_doe_tb, doe_size))
  # adding doe identifiers to tb
  tb$DoE = sort(rep(1:doe_size,nrow(tb)/doe_size))
  
  return(tb)
}



create_list = function(USM_list,doe_size,usm_number,sim_data) {
  li <- vector("list",doe_size)
  lapply(1:doe_size, function(doe) {
    cpt = 1
    li2 = vector("list",length(USM_list)*floor(usm_number/length(USM_list)))
    names_usm = vector("list",length(USM_list)*floor(usm_number/length(USM_list)))
    lapply(1:length(USM_list), function(usm) {
      #tibble_res = SticsRFiles::get_daily_results(file.path(stics_inputs_path, USM_list[usm]), USM_list[usm])
      tibble_res = sim_data[[usm]]
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

# Alternative: r
create_list2 = function(USM_list,doe_size,usm_number,sim_data) {
  # USM_list: vecteur des noms d'usm (parmi les noms de la liste sim_data) 
  # doe_size: nombre d'échantillons du doe
  # usm_number: nombre d'usm à générer à partir des usms de USM_list
  # sim_data: list de tibbles retournée par la fonction stics_wrapper 
  # avec sélection des colonnes et filrage des ligne sur une plage de dates
  # au préalable (voir dans TESTS plus bas)
  
  # replicating list: each sim_data element by generated usm names 
  usms_nb <- length(USM_list)
  usm_names_nb <- usm_number/usms_nb
  #
  one_doe_list <- lapply(1:usms_nb, function(x) {
    usm_sub_list <- rep(sim_data[x],usm_names_nb)
    names(usm_sub_list) <- paste(rep(USM_list[x],usm_names_nb), 1:usm_names_nb, sep="_")
    usm_sub_list
  })
  
  # Replicating one_doe_list doe_size times; adding doe names
  one_doe_list <- unlist(one_doe_list, recursive = FALSE)
  li <- lapply(1:doe_size, function(x) return(one_doe_list))
  # set doe identifiers as names
  names(li) <- as.character(1:doe_size)
  
  return(li)
}

################# EXTRACTION ################################
# Patrice
# ne fonctionne que pour une usm, generalisation a une liste ?
# On perd les infos de départ sur usm, doe
# Est-ce qu'il ne faudrait pas renvoyer un objet du même type que celui de départ ?
list_get_dates_and_var_values = function(structure,doe,usm_name,var) {
  structure[[doe]][[usm_name]][,c("Date",var)]
}

# voir si ok pour une liste d'usm
# On perd les infos de départ sur usm, doe
# Est-ce qu'il ne faudrait pas renvoyer un objet du même type que celui de départ ?
tibble_get_dates_and_var_values = function(structure,doe,usm_name,var) {
  var <- enquo(var)
  dplyr::filter(structure, DoE == doe,Name == usm_name) %>% dplyr::select(Date,!!var)
}

########################################

list_get_usm_names_and_var_values = function(structure,doe,var,date) {
  names = vector("list",length(structure[[doe]]))
  values = vector("list",length(structure[[doe]]))
  lapply(1:length(structure[[doe]]), function(id_usm) {
    id_var <- which(structure[[doe]][[id_usm]]$Date == ymd(date))
    values[id_usm] <<- structure[[doe]][[id_usm]][id_var,var]
    names[id_usm] <<- names(structure[[doe]][id_usm])
  })
  cbind(names,values)
  
  # renvoie une matrice
}

# Alternative: renvoie une liste ou un tibble
list_get_usm_names_and_var_values2 = function(structure,doe,var,date) {
  
  structure_doe <- structure[[doe]]
  
  # renvoie une liste
  # lapply(structure_doe, function(x) {filter(x, Date == ymd(date)) %>% select(var)})
  
  # renvoie un tibble
  bind_rows(lapply(structure_doe, function(x) {filter(x, Date == ymd(date)) %>% select(var)}),.id = "Name")
  
}


tibble_get_usm_names_and_var_values = function(structure,doe,var,date) {
  var <- enquo(var)
  dplyr::filter(structure,DoE == doe,Date == ymd(date)) %>% dplyr::select(Name,!!var)
}

#########################################

list_get_DOE_and_var_values = function(structure,usm_name,var,date) {
  DOE <- vector("list",length(structure))
  values <- vector("list",length(structure))
  lapply(1:length(structure), function(doe) {
    id_usm <- which(names(structure[[doe]]) == usm_name)
    id_var <- which(structure[[doe]][[id_usm]]$Date == ymd(date))
    values[doe] <<- structure[[doe]][[id_usm]][id_var,var]
    DOE[doe] <<- doe
  })
  cbind(DOE,values)
}

# Alternative: renvoie une liste ou un tibble
list_get_DOE_and_var_values2 = function(structure,usm_name,var,date) {
  
  structure_usm <- lapply(structure, function(x) x[[usm_name]])
  
  # renvoie une liste
  #lapply(structure_usm, function(x) {filter(x, Date == ymd(date)) %>% select(var)})
  
  # renvoie un tibble
  bind_rows(lapply(structure_usm, function(x) {filter(x, Date == ymd(date)) %>% select(var)}),.id = "Name")
  
}

tibble_get_DOE_and_var_values = function(structure,usm_name,var,date) {
  var <- enquo(var)
  dplyr::filter(structure, Name == usm_name,Date == ymd(date)) %>% dplyr::select(DoE,!!var)
}
