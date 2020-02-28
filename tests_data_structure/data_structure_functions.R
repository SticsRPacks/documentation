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
                     "plant_dominance_2_flai" = "null","observation_file" = "file.obs"))
                     #"elements_list" = num_list()))
}

##################################### FONCTIONS ################################################

############################### NON PRE ALLOCATED ################################

# return a non pre-allocated list which contains a certain time (repetition) 
# the same list or class instanciation (struct)
# NPA stands for Non Pre-Allocated
NPA_list_of_list = function(usmNumber) {                                                     
  li = list()
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    li = append(li,usm_list(paste("usm_",i,sep=""),ground_name))
  }
  return(li)
}

# return a non pre-allocated list which contains a certain time (repetition) 
# the same list or class instanciation (struct)
# NPA stands for Non Pre-Allocated
NPA_list_of_class = function(usmNumber) {                                                     
  li = list()
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    li = append(li,usm_class(paste("usm_",i,sep=""),ground_name))
  }
  return(li)
}

################################## PRE ALLOCATED ############################################

############################# VECTOR #############################################

# function that creates dynamicly a vector of n usm_list
# it takes as parameters n, number of usm_list in the vector
list_of_usm_list_by_vector = function(usmNumber) {
  vec = vector("list",usmNumber)
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    vec[[i]] <- usm_list(paste("usm_",i,sep=""),ground_name)
  }
  return(vec)
}

# function that creates dynamicly a vector of n usm_class
#it takes as parameters n, number of usm_class in the vector
list_of_usm_class_by_vector = function(usmNumber) {
  vec = vector("list",usmNumber)
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    vec[i] <- usm_class(paste("usm_",i,sep=""),ground_name)
  }
  return (vec)
}

# function that creates dynamicly a dataframe composed of n usm_dataframe
# it takes as parameters n, number of usm_dataframe in the final dataframe
usm_dataframe_by_vector = function(usmNumber) {
  vec = vector("list",usmNumber)
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    vec[[i]]<- usm_dataframe(paste("usm_",i,sep=""),ground_name)
  }
  return(rbindlist(vec))
}

# function that creates dynamicly a dataframe composed of n usm_dataframe
# it takes as parameters n, number of usm_dataframe in the final dataframe
usm_dataframe_by_dataframe = function(usmNumber) {
  df <- data.frame(Name=character(usmNumber),Date_begin=numeric(usmNumber),
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
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    df[i,] <- usm_list(paste("usm_",i,sep=""),ground_name)
  }
  return(df)
}

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
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    dt[i,] <- usm_list(paste("usm_",i,sep=""),ground_name)
  }
  return(dt)
}

# function that creates a datatable from a dataframe made with a vector
usm_datatable_by_usm_dataframe_by_vector = function(usmNumber) {
  return (data.table(usm_dataframe_by_vector(usmNumber)))
}

# function that creates a datatable from a dataframe made with a dataframe
usm_datatable_by_usm_dataframe_by_dataframe = function(usmNumber) {
  return(data.table(usm_dataframe_by_dataframe(usmNumber)))
}

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
               Pld2_flai = character(usmNumber),Observation_file=character(usmNumber),
               #Elements_list=list(),
               stringsAsFactors = FALSE)
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    tb[i,] <- usm_list(paste("usm_",i,sep=""),ground_name)
  }
  return(tb)
}

# function that creates a tibble from a dataframe made with a vector
usm_tibble_by_usm_dataframe_by_vector = function(usmNumber) {
  return (tibble::as_tibble(usm_dataframe_by_vector(usmNumber)))
}

# function that creates a tibble from a dataframe made with a dataframe
usm_tibble_by_usm_dataframe_by_dataframe = function(usmNumber){
  return(tibble::as_tibble(usm_dataframe_by_dataframe(usmNumber)))
}

############################### LAPPLY ##############################################

# function that creates dynamicly a list of n usm_list
#it takes as parameters n, number of usm_list in the list
list_of_usm_list_by_lapply = function(usmNumber) {
  ground_name <- sample(ground_names_vector,1)
  li <- lapply(1:usmNumber,function(x) usm_list(paste("usm_",x,sep=""),ground_name))
  return (li)
}

# return a pre allocated list which contains a certain time (repetition)
# the same list or class instanciation (struct)
list_of_usm_class_by_lapply = function(usmNumber) {  
  ground_name <- sample(ground_names_vector,1)
  li <- lapply(1:usmNumber,function(i) usm_class(paste("usm_",i,sep=""),ground_name))                                   
  return(li)
}

# return a pre allocated list which contains a certain time (repetition)
# the same data frame or tibble (struct)
usm_dataframe_by_lapply = function(usmNumber) { 
  ground_name <- sample(ground_names_vector,1)
  li <- lapply(1:usmNumber,function(i) usm_dataframe(paste("usm_",i,sep=""),ground_name))                                      
  return(rbindlist(li))
}

usm_datatable_by_usm_dataframe_by_lapply = function(usmNumber) {
  return(data.table(usm_dataframe_by_lapply(usmNumber)))
}

usm_tibble_by_usm_dataframe_by_lapply = function(usmNumber) {
  return(tibble::as_tibble(usm_dataframe_by_lapply(usmNumber)))
}

################# RANDOM EXTRACT ##################################

## Extract by usm name

# function that takes randomly usmNumber elements in structure
# structure = list and class
random_extract_for_usm_list_class = function(usmNumber,structure) {
  random_number_list <- sample.int(length(structure),usmNumber)
  random_usm_name <- lapply(random_number_list, function(x) paste("usm_",x,sep=""))
  vec <- unlist(lapply(structure, function(x) x[["name"]] %in% random_usm_name))
  return(structure[vec])
}

# function that takes randomly usmNumber elements in structure
# structure = data frame, data table and tibble
random_extract_for_usm_df_dt_tb = function(usmNumber,structure) {
  random_number_list <- sample.int(nrow(structure),usmNumber)
  random_usm_name <- unlist(lapply(random_number_list,function(x) paste("usm_",x,sep="")))
  vec <- unlist(lapply(1:nrow(structure), function(x) structure[x]$name %in% random_usm_name))
  return(structure[vec])
}

########### PURRR ########################

create_name = function(x) {
  return(paste("usm_",x,sep=""))
}

matching_name = function(elem,numbers) {
  names <- map(numbers,create_name)
  if (elem[["name"]] %in% names ) {
    return(elem)
  }
}

map_random_extract = function(usmNumbers,struct) {
  numbers <- sample(length(struct),usmNumbers)
  return(map(struct,matching_name,numbers))
}

################# CRITERIA EXTRACT ###################################

# function that extract a sub-list of usm group by a common criteria
criteria_extract_for_usm_list_class = function(structure,criteria,wanted) {
  vec <- unlist(lapply(structure,function(x) x[[criteria]] == wanted))
  return(structure[vec])
}

criteria_extract_for_usm_df_dt_tb = function(structure,criteria,wanted) {
  eval(parse(text=paste("return(filter(structure,",criteria," == wanted))",sep="")))
}
