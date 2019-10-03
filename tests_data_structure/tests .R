########################### LIBRARIES & GLOBAL VARIABLES/FUNCTIONs ################################
library(microbenchmark)
library(ggplot2)
library(tibble)
library(profvis)

time = 1000                                                                 # microbenchmark execution number

num_list = function() {                                                    # function that creates a list of elements that can be modified
  li <- lapply(1:300,function(i) i)
  return(li)
}

############################### LIST ##############################

pld_sugarCane1 = list("fplt" = "proto_sugarcane_plt.xml","ftec" = "canne_tec.xml","flai" = "null")   # "plant dominance 1" list creation
pld_sugarCane2 = list("fplt" = "null","ftec" = "null","flai" = "null")                               # "plant dominance 2" list creation
elem_list = num_list()                                                                               # 300 elem long list which can be modified
usm_sugarCane <- list(name = "SugarCane",date_begin = 286,date_end = 650,finit = "canne_ini.xml",ground_name = "solcanne",fstation = "climcanj_sta.xml",fclim1 = "climcanj.1998",fclim2 = "climcanj.1999",culturean = 0,nb_plant = 1,simulation_code = 0,plant_dominance_1 = pld_sugarCane1,plant_dominance_2 = pld_sugarCane2,observation_file = "file.obs",elements_list = elem_list)  # sugarCane usm creation

############################# CLASS ########################################

usm <- setRefClass("usm",
                   fields = list(name = "character",date_begin = "numeric",date_end = "numeric",finit = "character",ground_name = "character",fstation = "character",fclim1 = "character",fclim2 = "character",culturean = "numeric",nb_plant = "numeric",simulation_code = "numeric",plant_dominance_1 = "list",plant_dominance_2 = "list",observation_file = "character",elements_list = "list")
)
Sugarcane <- usm(name = "SugarCane",date_begin = 286,date_end = 650,finit = "canne_ini.xml",ground_name = "solcanne",fstation = "climcanj_sta.xml",fclim1 = "climcanj.1998",fclim2 = "clilmcanj.1999",nb_plant = 0,simulation_code = 1,plant_dominance_1 = pld_sugarCane1,plant_dominance_2 = pld_sugarCane2,observation_file = "file.obs",elements_list = elem_list)

#### pour les fonctions faire une classe qui comporte juste une liste

################ DATA FRAME ################################################

df <- data.frame(usm_sugarCane)

############### TIBBLE #####################################################

tb <- tibble::as_tibble(df)

################# FONCTIONS ################

test1 = function(x,y) {                                                     # create a x elements list from a non pre allocated list
  li = list()
  for (i in 1:x) {
    li = append(li,y)
  }
  return(li)
}

test1_bis = function(x,y) {                                                     # create a x elements list from a non pre allocated list
  li = list()
  y$name <- "rouge gorge"
  y$date_begin = 3102019
  for (i in 1:x) {
    li = append(li,y)
  }
  return(li)
}

test2 = function(x,y) {                                                     # create a x elements list from a pre allocated list
  vec = as.list(x)
  for (i in 1:x) {
    vec[[i]] = y
  }
  if (is.data.frame(x) | is.tibble(x)) {
    return(do.call(rbind,vec))
  }
  return(vec)
}

test2_bis = function(x,y) {                                                     # create a x elements list from a pre allocated list
  vec = as.list(x)
  y$name <- "rouge gorge"
  y$date_begin = 3102019
  for (i in 1:x) {
    vec[[i]] = y
  }
  if (is.data.frame(x) | is.tibble(x)) {
    return(do.call(rbind,vec))
  }
  return(vec)
}

test3 = function(x,y) {                                                     # other method to create a x elements list from a non pre allocated list
  li <- lapply(1:x,function(i) y)                                          
  if (is.data.frame(x) | is.tibble(x)) {
    return(do.call(rbind,li))
  }
  return(li)
}

slice = function(x,y,c1,c2,struct) {                                        # function useful to extract a sub-list of usm
  if(is.data.frame(struct) | is_tibble(struct)) {                           
    if(is.null(c1)) {
      part <- struct[x:y,]                                                
    }
    else {
      part <- struct[x:y,c1:c2]
    }
  }
  else {
    if(is.null(c1)) {
      part <- struct[x:y]
    }
    else {
      part <- struct[[x:y]][c1:c2]
    }
  }
  return(part)
}

############## TESTS POUR 10 000 ##############################################################################
y = 10000

########### LIST #############

begin <- Sys.time()
test <- test1(y,usm_sugarCane)
end <- Sys.time()
time1 <- end - begin
ost1 <- object.size(test)

begin <- Sys.time()
test <- test2(y,usm_sugarCane)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,usm_sugarCane)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost1,ost2,ost3)
collectionT = c(time1,time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "list / 10 000 elem",
     ylab = "weight",
     xlab = "NPA / PA Vector / lapply"
     )

plot(collectionT,
        main = "list / 10 000 elem",
        xlab = "NPA / PA Vector / lapply",
        ylab = "Time"
)

min_weight_li <- ost2
min_time_li <- time3
        
# profvis({
#   data(li, package = "ggplot2")
#   
#   plot(size ~ time, data = li)
#   m <- lm(size ~ time, data = li)
#   abline(m, col = "red")
# })


# it takes to much time
# test_plot = microbenchmark(test1(y,usm_sugarCane),test2(y,usm_sugarCane),test3(y,usm_sugarCane), times = time)
# ggplot2::autoplot(test_plot)

########## CLASS ############

begin <- Sys.time()
test <- test1(y,Sugarcane)
end <- Sys.time()
time1 <- end - begin
ost1 <- object.size(test)

begin <- Sys.time()
test <- test2(y,Sugarcane)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,Sugarcane)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost1,ost2,ost3)
collectionT = c(time1,time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "class / 10 000 elem",
     ylab = "weight",
     xlab = "NPA / PA Vector / lapply"
)

plot(collectionT,
     main = "class / 10 000 elem",
     xlab = "NPA / PA Vector / lapply",
     ylab = "Time"
)

min_weight_cl <- ost2
min_time_cl <- time3

# test_plot = microbenchmark(test1(y,Sugarcane),test2(y,Sugarcane),test3(y,Sugarcane), times = time)
# ggplot2::autoplot(test_plot)

######### DATA FRAME ##########

begin <- Sys.time()
test <- test2(y,df)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,df)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost2,ost3)
collectionT = c(time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "data frame / 10 000 elem",
     ylab = "weight",
     xlab = "PA Vector / lapply"
)

plot(collectionT,
     main = "data frame / 10 000 elem",
     xlab = "PA Vector / lapply",
     ylab = "Time"
)

min_weight_df <- ost2
min_time_df <- time3

# # test_plot = microbenchmark(test2(y,df),test3(y,df), times = time)
# # ggplot2::autoplot(test_plot)
# 
# ######## TIBBLE ##############
# 
begin <- Sys.time()
test <- test2(y,tb)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,tb)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost2,ost3)
collectionT = c(time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "tibble / 10 000 elem",
     ylab = "weight",
     xlab = "PA Vector / lapply"
)

plot(collectionT,
     main = "tibble / 10 000 elem",
     xlab = "PA Vector / lapply",
     ylab = "Time"
)

min_weight_tb <- ost2
min_time_tb <- time3
# 
# test_plot = microbenchmark(test2(y,tb),test3(y,tb), times = time)
# ggplot2::autoplot(test_plot)
# 

collectW = c(min_weight_li,min_weight_cl,min_weight_df,min_weight_tb)
collectT = c(min_time_li,min_time_cl,min_time_df,min_time_tb)

par(mfrow = c(2,1))
plot(collectW,
     main = "min weight for 10 000 elem",
     ylab = "weight",
     xlab = "list/ class / data frame / tibble"
)

plot(collectT,
     main = "min time for 10 000 elem",
     xlab = "list/ class / data frame / tibble",
     ylab = "Time"
)

# ################### TESTS POUR 100 000 ##########################
y = y*10

######### LIST ########

#begin <- Sys.time()   this takes about 30min
#test1(y)
#end <- Sys.time()
#end - begin

begin <- Sys.time()
test <- test2(y,usm_sugarCane)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,usm_sugarCane)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost2,ost3)
collectionT = c(time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "list / 100 000 elem",
     ylab = "weight",
     xlab = "PA Vector / lapply"
)

plot(collectionT,
     main = "list / 100 000 elem",
     xlab = "PA Vector / lapply",
     ylab = "Time"
)

min_weight_li <- ost2
min_time_li <- time3

# test_plot = microbenchmark(test2(y,usm_sugarCane),test3(y,usm_sugarCane), times = time)
# ggplot2::autoplot(test_plot)

########## CLASS ############

begin <- Sys.time()
test <- test1(y,Sugarcane)
end <- Sys.time()
time1 <- end - begin
ost1 <- object.size(test)

begin <- Sys.time()
test <- test2(y,Sugarcane)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,Sugarcane)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost1,ost2,ost3)
collectionT = c(time1,time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "class / 100 000 elem",
     ylab = "weight",
     xlab = "NPA / PA Vector / lapply"
)

plot(collectionT,
     main = "class / 100 000 elem",
     xlab = "NPA / PA Vector / lapply",
     ylab = "Time"
)

min_weight_cl <- ost2
min_time_cl <- time3

# test_plot = microbenchmark(test1(y,Sugarcane),test2(y,Sugarcane),test3(y,Sugarcane), times = time)
# ggplot2::autoplot(test_plot)

######### DATA FRAME ##########

begin <- Sys.time()
test <- test2(y,df)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,df)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost2,ost3)
collectionT = c(time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "data frame / 100 000 elem",
     ylab = "weight",
     xlab = "PA Vector / lapply"
)

plot(collectionT,
     main = "data frame / 100 000 elem",
     xlab = "PA Vector / lapply",
     ylab = "Time"
)

min_weight_df <- ost2
min_time_df <- time3


# test_plot = microbenchmark(test2(y,df),test3(y,df), times = time)
# ggplot2::autoplot(test_plot)

######## TIBBLE ##############

begin <- Sys.time()
test <- test2(y,tb)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,tb)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost2,ost3)
collectionT = c(time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "tibble / 100 000 elem",
     ylab = "weight",
     xlab = "PA Vector / lapply"
)

plot(collectionT,
     main = "tibble / 100 000 elem",
     xlab = "PA Vector / lapply",
     ylab = "Time"
)

min_weight_tb <- ost2
min_time_tb <- time3

# test_plot = microbenchmark(test2(y,tb),test3(y,tb), times = time)
# ggplot2::autoplot(test_plot)

collectW = c(min_weight_li,min_weight_cl,min_weight_df,min_weight_tb)
collectT = c(min_time_li,min_time_cl,min_time_df,min_time_tb)

par(mfrow = c(2,1))
plot(collectW,
     main = "min weight for 100 000 elem",
     ylab = "weight",
     xlab = "list/ class / data frame / tibble"
)

plot(collectT,
     main = "min time for 100 000 elem",
     xlab = "list/ class / data frame / tibble",
     ylab = "Time"
)

############### TESTS POUR 1 000 000 ##########################
y = y*10

########## LIST #########

#begin <- Sys.time()    Ce test prend plus de 3 jours
#test1(y)
#end <- Sys.time()
#end - begin

begin <- Sys.time()
test <- test2(y,usm_sugarCane)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,usm_sugarCane)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost2,ost3)
collectionT = c(time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "list / 1 000 000 elem",
     ylab = "weight",
     xlab = "PA Vector / lapply"
)

plot(collectionT,
     main = "list / 1 000 000 elem",
     xlab = "PA Vector / lapply",
     ylab = "Time"
)

min_weight_li <- ost2
min_time_li <- time3

# test_plot = microbenchmark(test2(y,usm_sugarCane),test3(y,usm_sugarCane), times = time)
# ggplot2::autoplot(test_plot)

########## CLASS ############

# begin <- Sys.time()
# test1(y,Sugarcane)
# end <- Sys.time()
# end - begin

begin <- Sys.time()
test <- test2(y,Sugarcane)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,Sugarcane)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost2,ost3)
collectionT = c(time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "class / 1 000 000 elem",
     ylab = "weight",
     xlab = "PA Vector / lapply"
)

plot(collectionT,
     main = "class / 1 000 000 elem",
     xlab = "PA Vector / lapply",
     ylab = "Time"
)

min_weight_cl <- ost2
min_time_cl <- time3

# test_plot = microbenchmark(test2(y,Sugarcane),test3(y,Sugarcane), times = time)
# ggplot2::autoplot(test_plot)

######### DATA FRAME ##########

# it takes too much time
# begin <- Sys.time()
# test2(y,df)
# end <- Sys.time()
# end-begin
#
# begin <- Sys.time()
# test3(y,df)
# end <- Sys.time()
# end-begin
#
# test_plot = microbenchmark(test2(y,df),test3(y,df), times = time)
# ggplot2::autoplot(test_plot)

######## TIBBLE ##############

begin <- Sys.time()
test <- test2(y,tb)
end <- Sys.time()
time2 <- end - begin
ost2 <- object.size(test)

begin <- Sys.time()
test <- test3(y,tb)
end <- Sys.time()
time3 <- end - begin
ost3 <- object.size(test)

collectionW = c(ost2,ost3)
collectionT = c(time2,time3)

par(mfrow = c(2,1))
plot(collectionW,
     main = "tibble / 1 000 000 elem",
     ylab = "weight",
     xlab = "PA Vector / lapply"
)

plot(collectionT,
     main = "tibble / 1 000 000 elem",
     xlab = "PA Vector / lapply",
     ylab = "Time"
)

min_weight_tb <- ost2
min_time_tb <- time3

# test_plot = microbenchmark(test2(y,tb),test3(y,tb), times = time)
# ggplot2::autoplot(test_plot)

collectW = c(min_weight_li,min_weight_cl,min_weight_tb)
collectT = c(min_time_li,min_time_cl,min_time_tb)

par(mfrow = c(2,1))
plot(collectW,
     main = "min weight for 1 000 000 elem",
     ylab = "weight",
     xlab = "list/ class / tibble"
)

plot(collectT,
     main = "min time for 1 000 000 elem",
     xlab = "list/ class / tibble",
     ylab = "Time"
)
