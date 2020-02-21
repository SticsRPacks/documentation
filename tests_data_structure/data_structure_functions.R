################# USM elements ##################

# lists for plant dominance for sugarcane usm, this will disappear later and be created 
# dynamicly
pld_sugarCane1 = list("fplt" = "proto_sugarcane_plt.xml","ftec" = "canne_tec.xml","flai" = "null") 
pld_sugarCane2 = list("fplt" = "null","ftec" = "null","flai" = "null")

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
                                                       plant_dominance_1 = "list",
                                                       plant_dominance_2 = "list",
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
               plant_dominance_1 = pld_sugarCane1,plant_dominance_2 = pld_sugarCane2,
               observation_file = "file.obs"))#,elements_list = num_list()))
}


# function that creates dynamicly an usm_class instance
# it takes as parameters only the usm's name for now, later it will take all the usm's param
usm_class = function (usm_name,ground_n) {
  return(usm_class_definiton(name = usm_name,date_begin = 256,date_end = 384,
                             finit = "canne_ini.xml", ground_name = ground_n, 
                             fstation = "climcanj_sta.xml", fclim1 = "climcanj.1998",
                             fclim2 = "clilmcanj.1999",culturean = 0, nb_plant = 0,
                             simulation_code = 1,plant_dominance_1 = pld_sugarCane1,
                             plant_dominance_2 = pld_sugarCane2,observation_file = "file.obs"))
                             #elements_list = num_list()))
  
}


# function that create dynamicly an usm_dataframe instance
# it takes as parameters only the usm's name for now, later it will take all the usm's param
usm_dataframe = function(usm_name,ground_n) {
  return (data.frame("name" = usm_name,"date_begin" = 286,"date_end" = 384,
                     "finit" = "canne_ini.xml", "ground_name" = ground_n, 
                     "fstation" = "climcanj_sta.xml", "fclim1" = "climcanj.1998",
                     "fclim2" = "climcanj.1999","culturean" = 0, "nb_plant" = 1,
                     "simulation_code" = 0,"plant_dominance_1" = pld_sugarCane1,
                     "plant_dominance_2" = pld_sugarCane2,"observation_file" = "file.obs"))
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
    li = append(li,usm_list(paste("usm_",i,sep="")))
  }
  return(li)
}

# return a non pre-allocated list which contains a certain time (repetition) 
# the same list or class instanciation (struct)
# NPA stands for Non Pre-Allocated
NPA_list_of_class = function(usmNumber) {                                                     
  li = list()
  for (i in 1:usmNumber) {
    li = append(li,usm_class(paste("usm_",i,sep="")))
  }
  return(li)
}

################################## PRE ALLOCATED ############################################

############################# VECTOR #############################################

# function that creates dynamicly a vector of n usm_list
# it takes as parameters n, number of usm_list in the vector
vector_usm_list = function(usmNumber) {
  vec = vector("list",usmNumber)
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    vec[[i]] <- usm_list(paste("usm_",i,sep=""),ground_name)
  }
  return(vec)
}

# function that creates dynamicly a vector of n usm_class
#it takes as parameters n, number of usm_class in the vector
vector_usm_class = function(usmNumber) {
  vec = vector("list",usmNumber)
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    vec[i] <- usm_class(paste("usm_",i,sep=""),ground_name)
  }
  return (vec)
}

# function that creates dynamicly a dataframe composed of n usm_dataframe
# it takes as parameters n, number of usm_dataframe in the final dataframe
vector_usm_dataframe = function(usmNumber) {
  vec = vector("list",usmNumber)
  for (i in 1:usmNumber) {
    ground_name <- sample(ground_names_vector,1)
    vec[[i]] <- usm_dataframe(paste("usm_",i,sep=""),ground_name)
  }
  return(rbindlist(vec))
}

# function that creates dynamicly a dataframe from a vector
vector_usm_datatable = function(usmNumber) {
  # vec = vector("list",usmNumber)
  # for (i in 1:usmNumber) {
  #   ground_name <- sample(ground_names_vector,1)
  #   date_begin <- sample(1:300,1)
  #   date_end <- sample(301:600,1)
  #   vec[[i]] <- data.table(usm_dataframe(paste("usm_",i,sep=""),date_begin,date_end,ground_name))
  # }
  # return (rbindlist(vec))
  return (data.table(vector_usm_dataframe(usmNumber)))
}

# function that creates dynamicly a tibble from a vector
vector_usm_tibble = function(usmNumber) {
  # vec = vector("list",usmNumber)
  # for (i in 1:usmNumber) {
  #   vec[[i]] <- tibble::as_tibble(usm_dataframe(paste("usm_",i,sep="")))
  # }
  # return(rbindlist(vec))
  return (tibble::as_tibble(vector_usm_dataframe(usmNumber)))
}

############################### LAPPLY ##############################################

# function that creates dynamicly a list of n usm_list
#it takes as parameters n, number of usm_list in the list
lapply_usm_list = function(usmNumber) {
  ground_name <- sample(ground_names_vector,1)
  li <- lapply(1:usmNumber,function(x) usm_list(paste("usm_",x,sep=""),ground_name))
  return (li)
}

# return a pre allocated list which contains a certain time (repetition)
# the same list or class instanciation (struct)
lapply_usm_class = function(usmNumber) {  
  ground_name <- sample(ground_names_vector,1)
  li <- lapply(1:usmNumber,function(i) usm_class(paste("usm_",i,sep=""),ground_name))                                   
  return(li)
}

# return a pre allocated list which contains a certain time (repetition)
# the same data frame or tibble (struct)
lapply_usm_dataframe = function(usmNumber) { 
  ground_name <- sample(ground_names_vector,1)
  li <- lapply(1:usmNumber,function(i) usm_dataframe(paste("usm_",i,sep=""),ground_name))                                      
  return(rbindlist(li))
}

lapply_usm_datatable = function(usmNumber) {
  # li <- lapply(1:usmNumber,function(i) usm_dataframe(paste("usm_",i,sep="")))
  # return(rbindlist(li))
  return(data.table(lapply_usm_dataframe(usmNumber)))
}

lapply_usm_tibble = function(usmNumber) {
  # li <- lapply(1:usmNumber,function(i) usm_dataframe(paste("usm_",i,sep="")))
  # return(rbindlist(li))
  return(tibble::as_tibble(lapply_usm_dataframe(usmNumber)))
}

#################### SEARCH FUNCTIONS ##############################################


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


################# CRITERIA EXTRACT ###################################

# function that extract a sub-list of usm group by a common criteria
criteria_extract_for_usm_list_class = function(structure,criteria,wanted) {
  vec <- unlist(lapply(structure,function(x) x[[criteria]] == wanted))
  return(structure[vec])
}

criteria_extract_for_usm_df_dt_tb = function(structure,criteria,wanted) {
  eval(parse(text=paste("return(filter(structure,",criteria," == wanted))",sep="")))
}
