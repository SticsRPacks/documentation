source("data_structure_functions.R")

########################### LIBRARIES & GLOBAL VARIABLES/FUNCTIONs ################################
library(microbenchmark)
library(ggplot2)
library(tibble)
library(data.table)

# microbenchmark execution number
time = 100                                                                

# function that creates a 300 elem long list of elements that can be modified
num_list = function() {
  li <- lapply(1:3,function(i) i)
  return(li)
}

############################### LIST ##############################

# "plant dominance 1" list creation
pld_sugarCane1 = list("fplt" = "proto_sugarcane_plt.xml","ftec" = "canne_tec.xml","flai" = "null") 

# "plant dominance 2" list creation
pld_sugarCane2 = list("fplt" = "null","ftec" = "null","flai" = "null")     

# 300 elem long list which can be modified
param_list = num_list()                                                                               

# sugarCane usm creation
usm_sugarCane <- list(name = "SugarCane",date_begin = 286,date_end = 650,finit = "canne_ini.xml",
                      ground_name = "solcanne",fstation = "climcanj_sta.xml",fclim1 = "climcanj.1998",
                      fclim2 = "climcanj.1999",culturean = 0,nb_plant = 1,simulation_code = 0,
                      plant_dominance_1 = pld_sugarCane1,plant_dominance_2 = pld_sugarCane2,
                      observation_file = "file.obs",parametres_list = param_list) 

usm_potato <- list(name = "potato",date_begin = 133,date_end = 650,finit = "canne_ini.xml",
                   ground_name = "solcanne",fstation = "climcanj_sta.xml",fclim1 = "climcanj.1998",
                   fclim2 = "climcanj.1999",culturean = 0,nb_plant = 1,simulation_code = 0,
                   plant_dominance_1 = pld_sugarCane1,plant_dominance_2 = pld_sugarCane2,
                   observation_file = "file.obs",parametres_list = param_list) 

############################# CLASS ########################################

# usm class declaration
usm <- setRefClass("usm",
                   fields = list(name = "character",date_begin = "numeric",date_end = "numeric",
                                 finit = "character",ground_name = "character",fstation = "character",
                                 fclim1 = "character",fclim2 = "character",culturean = "numeric",
                                 nb_plant = "numeric",simulation_code = "numeric",
                                 plant_dominance_1 = "list",plant_dominance_2 = "list",
                                 observation_file = "character",parametres_list = "list")
)

# usm class object Sugarcane instanciation
Sugarcane <- usm(name = "SugarCane",date_begin = 286,date_end = 650,finit = "canne_ini.xml",
                 ground_name = "solcanne",fstation = "climcanj_sta.xml",fclim1 = "climcanj.1998",
                 fclim2 = "clilmcanj.1999",nb_plant = 0,simulation_code = 1,
                 plant_dominance_1 = pld_sugarCane1,plant_dominance_2 = pld_sugarCane2,
                 observation_file = "file.obs",parametres_list = param_list)

Potato <- usm(name = "potato",date_begin = 133,date_end = 256,finit = "canne_ini.xml",
              ground_name = "solcanne",fstation = "climcanj_sta.xml",fclim1 = "climcanj.1998",
              fclim2 = "clilmcanj.1999",nb_plant = 0,simulation_code = 1,
              plant_dominance_1 = pld_sugarCane1,plant_dominance_2 = pld_sugarCane2,
              observation_file = "file.obs",parametres_list = param_list)


################ DATA FRAME ################################################

# creation data frame df using list usm_sugarCane
dfs <- data.frame(usm_sugarCane)
dfp <- data.frame(usm_potato)

############### TIBBLE #####################################################

#creation tibble tb using data frame df
tbs <- tibble::as_tibble(dfs)
tbp <- tibble::as_tibble(dfp)

############### DATA TABLE ###################
dts <- data.table(dfs)
dtp <- data.table(dfp) 

############## TESTS #################################################################

# number of element
num_elem = 1

df <- PA_vector_Df_and_Tb(num_elem,dfs)
trace