source("data_structure_functions.R")

########################### LIBRARIES & GLOBAL VARIABLES/FUNCTIONs ################################
library(microbenchmark)
library(ggplot2)
library(tibble)
library(data.table)
library(dplyr)

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

#################### Sous ensemble -> extraction d'une ou plusieurs usm(s)

########### LIST #############

test <- NPA_list(num_elem,usm_sugarCane)
test_bis <- NPA_list(num_elem,usm_potato)
test <- append(test,test_bis)
# on récupère la première usm (15 elements dans une usm)
test[1:15]
# on récupère le nom de la première usm
test[1:15]$name
# on recupère les noms des usms directement avec leurs indices
test[1]
test[16]
# on recupere tous les noms de la liste
test$name
# mais cela ne fonctionne pas et ne retourne que le premier
slice(test,1:5)


########### CLASS  ############
test_class <- NPA_list(num_elem,Sugarcane)
test_class2 <- NPA_list(num_elem,Potato)
test_class <- append(test_class,test_class2)
# on recupere les infos de la premiere usm
test_class[1]
# on récupère le nom de la seconde usm
test_class[[2]]$name
# on recupere un valeur de la liste de parametres de la seconde usm
test_class[[2]]$parametres_list[[2]]
# cela fonctionne avec simple crochet aussi

############# DataFrame #############

test_df <- PA_vector_Df_and_Tb(num_elem,dfs)
test_dfp <- PA_vector_Df_and_Tb(num_elem,dfp)
test_df <- rbind(test_df,test_dfp)
# retourne la premiere ligne
test_df[1]
# retourne toutes les informations dans la première colonne
test_df[[1]]
# retourne le second element dans la colonne 1, fonctionne aussi avec double crochets
test_df[[1]][2]
# retourne le deuxième element de la première ligne
test_df[1][[2]]


# ########## TIBBLE ###########

# on peux aussi user des noms des colonnes pour selectionner les elements voulus
test_tb <- PA_vector_Df_and_Tb(num_elem,tbs)
test_tbp <- PA_vector_Df_and_Tb(num_elem,tbp)
test_tb <- rbind(test_tb,test_tbp)
test_tb[1]
test_tb[[1]][2]
test_tb[2,name]
test_tb[1][[2]]
test_tb[1,date_begin]

############ Data table #############
test_dt <- PA_vector_Df_and_Tb(num_elem,dts)
test_dtp <- PA_vector_Df_and_Tb(num_elem,dtp)
test_dt <- rbind(test_dt,test_dtp)
test_dt[name == "SugarCane"]
test_dt[,name]
test_dt[1,name]
test_dt[,.(name,date_begin)]
test_dt[,.(nom = name, total = date_begin + date_end)]