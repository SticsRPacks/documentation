library(purrr)

################# USM elements ##################

# function that creates a 300 elem long list of elements that can be modified
num_list = function() {
  vec = vector("list",15)
  for (i in 1:15) {
    vec[i] <- paste("name_",i,sep="")
  }
  return(vec)
}

# usm_class definition
usm_class_definiton <- setRefClass("usm",fields = list(name = "character",date_begin = "numeric",
                                                       date_end = "numeric",finit = "character",
                                                       ground_name = "character",
                                                       fstation = "character",fclim1 = "character",
                                                       fclim2 = "character",culturean = "numeric",
                                                       nb_plant = "numeric",
                                                       simulation_code = "numeric",
                                                       plant_dominance_1_fplt = "character",
                                                       plant_dominance_1_ftec = "character",
                                                       plant_dominance_1_flai = "character",
                                                       plant_dominance_2_fplt = "character",
                                                       plant_dominance_2_ftec = "character",
                                                       plant_dominance_2_flai = "character",
                                                       observation_file = "character"))
                                                       #elements_list = "list"))

ground_names_vector <- c("sol_canne","potato_sol","courgette_sol")

################################ CONSTRUCTORS #####################################

# function that creates dynamicly an usm_list instance
# it takes as parameters only the usm's name for now, later it will take all the usm's param
usm_list = function(usm_name,ground_n) {
  return (list(name = usm_name,date_begin = 256,date_end = 384,finit = "canne_ini.xml",
               ground_name = ground_n,fstation = "climcanj_sta.xml",fclim1 = "climcanj.1998",
               fclim2 = "climcanj.1999",culturean = 0,nb_plant = 1,simulation_code = 0,
               plant_dominance_1_fplt = "proto_sugarcane_plt.xml",
               plant_dominance_1_ftec = "canne_tec.xml",
               plant_dominance_1_flai = "null",
               plant_dominance_2_fplt = "null",
               plant_dominance_2_ftec = "null",
               plant_dominance_2_flai = "null",
               observation_file = "file.obs"))#,elements_list = num_list()))
}


# function that creates dynamicly an usm_class instance
# it takes as parameters only the usm's name for now, later it will take all the usm's param
usm_class = function (usm_name,ground_n) {
  return(usm_class_definiton(name = usm_name,date_begin = 256,date_end = 384,
                             finit = "canne_ini.xml", ground_name = ground_n, 
                             fstation = "climcanj_sta.xml", fclim1 = "climcanj.1998",
                             fclim2 = "clilmcanj.1999",culturean = 0, nb_plant = 0,
                             simulation_code = 1,plant_dominance_1_fplt = "proto_sugarcane_plt.xml",
                             plant_dominance_1_ftec = "canne_tec.xml",
                             plant_dominance_1_flai = "null",plant_dominance_2_fplt = "null",
                             plant_dominance_2_ftec = "null",plant_dominance_2_flai = "null",
                             observation_file = "file.obs"))
                             #elements_list = num_list()))
}


# function that create dynamicly an usm_dataframe instance
# it takes as parameters only the usm's name for now, later it will take all the usm's param
usm_dataframe = function(usm_name,ground_n) {
  return (data.frame("name" = usm_name,"date_begin" = 286,"date_end" = 384,
                     "finit" = "canne_ini.xml", "ground_name" = ground_n, 
                     "fstation" = "climcanj_sta.xml", "fclim1" = "climcanj.1998",
                     "fclim2" = "climcanj.1999","culturean" = 0, "nb_plant" = 1,
                     "simulation_code" = 0,"plant_dominance_1_fplt" = "proto_sugarcane_plt.xml",
                     "plant_dominance_1_ftec" = "canne_tec.xml","plant_dominance_1_flai" = "null",
                     "plant_dominance_2_fplt" = "null","plant_dominance_2_ftec" = "null",
                     "plant_dominance_2_flai" = "null","observation_file" = "file.obs",stringsAsFactors = FALSE))
                     #"elements_list" = num_list()))
}

usm_datatable = function (usm_name,ground_n) {
  return (data.table("name" = usm_name,"date_begin" = 286,"date_end" = 384,
                     "finit" = "canne_ini.xml", "ground_name" = ground_n, 
                     "fstation" = "climcanj_sta.xml", "fclim1" = "climcanj.1998",
                     "fclim2" = "climcanj.1999","culturean" = 0, "nb_plant" = 1,
                     "simulation_code" = 0,"plant_dominance_1_fplt" = "proto_sugarcane_plt.xml",
                     "plant_dominance_1_ftec" = "canne_tec.xml","plant_dominance_1_flai" = "null",
                     "plant_dominance_2_fplt" = "null","plant_dominance_2_ftec" = "null",
                     "plant_dominance_2_flai" = "null","observation_file" = "file.obs",stringsAsFactors = FALSE))
}

usm_tibble = function(usm_name,ground_n) {
  return(tibble("name" = usm_name,"date_begin" = 286,"date_end" = 384,
                "finit" = "canne_ini.xml", "ground_name" = ground_n, 
                "fstation" = "climcanj_sta.xml", "fclim1" = "climcanj.1998",
                "fclim2" = "climcanj.1999","culturean" = 0, "nb_plant" = 1,
                "simulation_code" = 0,"plant_dominance_1_fplt" = "proto_sugarcane_plt.xml",
                "plant_dominance_1_ftec" = "canne_tec.xml","plant_dominance_1_flai" = "null",
                "plant_dominance_2_fplt" = "null","plant_dominance_2_ftec" = "null",
                "plant_dominance_2_flai" = "null","observation_file" = "file.obs"))
}

##################################### FONCTIONS ################################################

############### LIST ##########################

# function that creates dynamicly a list of n usm_list
#it takes as parameters n, number of usm_list in the list
list_of_usm_list_by_lapply = function(usmNumber) {
  li <- lapply(1:usmNumber,function(x) {
    ground_name <- sample(ground_names_vector,1)
    usm_list(paste("usm_",x,sep=""),ground_name)
    })
  names(li) <- paste("usm_",1:usmNumber,sep="")
  return (li)
}

list_of_usm_list_by_PA_lapply = function(usmNumber) {
  liste <- lapply(1:usmNumber,function(x) {
    list(name = character(),date_begin = numeric(),date_end = numeric(),finit = character(),
         ground_name = character(),fstation = character(),fclim1 = character(),
         fclim2 = character(),culturean = numeric(),nb_plant =numeric(),simulation_code =numeric(),
         plant_dominance_1_fplt = character(),plant_dominance_1_ftec = character(),
         plant_dominance_1_flai = character(),
         plant_dominance_2_fplt = character(),
         plant_dominance_2_ftec = character(),
         plant_dominance_2_flai = character(),
         observation_file = character())
    })
  lapply(1:length(liste),function(x) {
    ground_name <- sample(ground_names_vector,1)
    liste[[x]] <<- usm_list(paste("usm_",x,sep=""),ground_name)
  })
  names(liste) <- paste("usm_",1:usmNumber,sep="")
  return (liste)
}

############### CLASS ########################

# return a non pre allocated list which contains a certain time (repetition)
# the same list or class instanciation (struct)
list_of_usm_class_by_lapply = function(usmNumber) {  
  li <- lapply(1:usmNumber,function(i) {
    ground_name <- sample(ground_names_vector,1)
    usm_class(paste("usm_",i,sep=""),ground_name)                                   
  })
  names(li) <- paste("usm_",1:usmNumber,sep="")
  return(li)
}

list_of_usm_class_by_PA_lapply = function(usmNumber) {  
  classe <- lapply(1:usmNumber,function(x) usm_class_definiton())
  lapply(1:length(classe),function(x) {
    ground_name <- sample(ground_names_vector,1)
    classe[[x]] <<- usm_class(paste("usm_",x,sep=""),ground_name)
  })
  names(classe) <- paste("usm_",1:usmNumber,sep="")
  return(classe)
}
############## DATA FRAME #################

# function that creates dynamicly a dataframe composed of n usm_dataframe
# it takes as parameters n, number of usm_dataframe in the final dataframe
usm_dataframe_by_dataframe = function(usmNumber) {
  df <- data.frame(name=character(usmNumber),Date_begin=numeric(usmNumber),
                   Date_end=numeric(usmNumber),Finit=character(usmNumber),
                   Ground_name=character(usmNumber),Fstation=character(usmNumber),
                   Fclim1=character(usmNumber),Fclim2=character(usmNumber),
                   Culturean=numeric(usmNumber),Nb_plant=numeric(usmNumber),
                   Simulation_code=numeric(usmNumber),Pld1_fplt = character(usmNumber),
                   Pld1_ftec = character(usmNumber),Pld1_flai = character(usmNumber),
                   Pld2_fplt = character(usmNumber),Pld2_ftec = character(usmNumber),
                   Pld2_flai = character(usmNumber),Observation_file=character(usmNumber),
                   #Elements_list=list(),
                   stringsAsFactors = FALSE)
  lapply(1:nrow(df),function(x) {
    ground_name <- sample(ground_names_vector,1)
    df[x,] <<- usm_dataframe(paste("usm_",x,sep=""),ground_name)
  })
  return(df)
}

# return a pre allocated list which contains a certain time (repetition)
# the same data frame or tibble (struct)
usm_dataframe_by_lapply = function(usmNumber) {
  li <- lapply(1:usmNumber,function(i) {
    ground_name <- sample(ground_names_vector,1)
    usm_dataframe(paste("usm_",i,sep=""),ground_name)
    })
  return(rbindlist(li))
}

################### DATA TABLE ##############

# function that creates a datatable
usm_datatable_by_datatable = function(usmNumber) {
  dt <- data.table(Name=character(usmNumber),Date_begin=numeric(usmNumber),
                   Date_end=numeric(usmNumber),Finit=character(usmNumber),
                   Ground_name=character(usmNumber),Fstation=character(usmNumber),
                   Fclim1=character(usmNumber),Fclim2=character(usmNumber),
                   Culturean=numeric(usmNumber),Nb_plant=numeric(usmNumber),
                   Simulation_code=numeric(usmNumber),Pld1_fplt = character(usmNumber),
                   Pld1_ftec = character(usmNumber),Pld1_flai = character(usmNumber),
                   Pld2_fplt = character(usmNumber),Pld2_ftec = character(usmNumber),
                   Pld2_flai = character(usmNumber),Observation_file=character(usmNumber),
                   #Elements_list=list(),
                   stringsAsFactors = FALSE)
  lapply(1:nrow(dt),function(x) {
    ground_name <- sample(ground_names_vector,1)
    dt[x,] <<- usm_datatable(paste("usm_",x,sep=""),ground_name)
  })
  return(dt)
}

usm_datatable_by_lapply = function(usmNumber) {
  li <- lapply(1:usmNumber,function(i) {
    ground_name <- sample(ground_names_vector,1)
    usm_datatable(paste("usm_",i,sep=""),ground_name)
  })
  return(rbindlist(li))
}

############ TIBBLE #################

# function that creates a tibble 
usm_tibble_by_tibble = function(usmNumber) {
  tb <- tibble(Name=character(usmNumber),Date_begin=numeric(usmNumber),
               Date_end=numeric(usmNumber),Finit=character(usmNumber),
               Ground_name=character(usmNumber),Fstation=character(usmNumber),
               Fclim1=character(usmNumber),Fclim2=character(usmNumber),
               Culturean=numeric(usmNumber),Nb_plant=numeric(usmNumber),
               Simulation_code=numeric(usmNumber),Pld1_fplt = character(usmNumber),
               Pld1_ftec = character(usmNumber),Pld1_flai = character(usmNumber),
               Pld2_fplt = character(usmNumber),Pld2_ftec = character(usmNumber),
               Pld2_flai = character(usmNumber),Observation_file=character(usmNumber))
               #Elements_list=list())
  lapply(1:nrow(tb),function(x) {
    ground_name <- sample(ground_names_vector,1)
    tb[x,] <<- usm_tibble(paste("usm_",x,sep=""),ground_name)
  })
  return(tb)
}

usm_tibble_by_lapply = function(usmNumber) {
  li <- lapply(1:usmNumber,function(i) {
    ground_name <- sample(ground_names_vector,1)
    usm_tibble(paste("usm_",i,sep=""),ground_name)
  })
  return(tibble(rbindlist(li)))
}

################# RANDOM EXTRACT ##################################

## get random names

get_random_names = function(Usm_number) {
  samples <- sample(Usm_number,Usm_number/2)
  return(lapply(samples,function(x) paste("usm_",x,sep="")))
}

## Extract by usm name

# function that takes randomly usmNumber elements in structure
# structure = list and class
random_extract_for_usm_list_class = function(structure,random_usm_name) {
  structure[names(structure) %in% random_usm_name]
}

# function that takes randomly usmNumber elements in structure
# structure = data frame, data table and tibble
random_extract_for_usm_df_dt_tb = function(structure,random_usm_name) {
  structure[structure$name %in% random_usm_name,]
}

random_extract_for_usm_df_dt_tb_filter = function(structure,random_usm_name) {
  dplyr::filter(structure,name %in% random_usm_name)
}

########### PURRR ########################

matching_name = function(elem,random_names) {
  if (elem[["name"]] %in% random_names ) {
    return(elem)
  }
}

map_random_extract = function(struct,random_names) {
  return(map(struct,matching_name,random_names))
}

matching_criteria = function(elem,criteria,wanted) {
  if (elem[[criteria]] == wanted) {
    return(elem)
  }
}

map_criteria_extract = function(struct,criteria,wanted) {
  return(map(struct,matching_criteria,criteria,wanted))
}

################# CRITERIA EXTRACT ###################################

# function that extract a sub-list of usm group by a common criteria
criteria_extract_for_usm_list_class = function(structure,criteria,wanted) {
  vec <- unlist(lapply(structure,function(x) x[[criteria]] == wanted))
  return(structure[vec])
}

criteria_extract_for_usm_df_dt_tb = function(structure,criteria,wanted) {
  criteria <- enquo(criteria)
  dplyr::filter(structure,!!criteria == wanted)
}


# Generates a data.frame fro a list of microbenchmark
# objects, setting a common execution time unit
# and adding it as column
bench_list2df <- function(bench_list, id = "doe") {
  units_vect <- unlist(lapply(bench_list, get_bench_unit))
  com_unit <- get_common_unit(units_vect)
  sum_list <- lapply(bench_list, function(x) summary(x, unit = names(com_unit)) %>% mutate(unit = com_unit))
  df <- dplyr::bind_rows(sum_list, .id = id)
  df[[id]] <- as.numeric(df[[id]])
  return(df)
}

# Getting unit from a microbenchmark object
get_bench_unit <- function(bench_table) {
  unit_str <- gsub(pattern = "Unit: ", x = capture.output(bench_table)[1], replacement = "")
  return(unit_str)
}

# Getting the common unit from a list
# of units == the most represented
get_common_unit <- function(units_vect) {
  units_list <- c("nanoseconds", "microseconds", "milliseconds","seconds")
  names(units_list) <- c("ns", "us","ms", "s")
  units_names <- unique(units_vect)
  units_count <- unlist(lapply(units_names, function(x) sum(units_vect %in% x)))
  #unit_name <- units_names[units_count == max(units_count)]
  # on ne s'embête pas et on prend l'unité la plus basse au lieu de celle la plus présente car il y a un nombre pair de tests contrairement aux tests de données de sortie.
  unit_name <- units_names[1]
  units_list[ units_list %in% unit_name ]
}