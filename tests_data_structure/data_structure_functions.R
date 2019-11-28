################# FONCTIONS ################

# return a non pre-allocated list which contains a certain time (repetition) 
# the same list or class instanciation (struct)
# NPA stands for Non Pre-Allocated
NPA_list = function(repetition,struct) {                                                     
  li = list()
  for (i in 1:repetition) {
    li = append(li,struct)
  }
  return(li)
}

# return a non pre-allocated list which contains a certain time (repetition) 
# the same list or class instanciation (struct)
# this time the copy_on_modifying is add (we change some elements inside struct)
# WCOM stands for With Copy On Modifying
NPA_list_WCOM = function(repetition,struct) {                                                     
  li = list()
  struct$name <- "rouge gorge"
  struct$date_begin = 3102019
  for (i in 1:repetition) {
    li = append(li,struct)
  }
  return(li)
}

# return a pre allocated vector which contains a certain time (repetition)
# the same list or class instanciation (struct)
# PA stands for Pre-allocated
PA_vector_list_and_class = function(repetition,struct) {                                                    
  vec = vector("list",repetition)
  for (i in 1:repetition) {
    vec[[i]] = struct
  }
  return(vec)
}

# return a pre allocated vector which contains a certain time (repetition)
# the same data frame or tibble (struct)
PA_vector_Df_and_Tb = function(repetition,struct) {                                                    
  vec = vector("list",repetition)
  for (i in 1:repetition) {
    vec[[i]] = struct
  }
  return(rbindlist(vec))
}

# return a pre-allocated vector which contains a certain time (repetition) 
# the same list or class instanciation (struct)
# this time the copy_on_modifying is add (we change some elements inside struct)
PA_vector_list_and_class_WCOM = function(repetition,struct) {                                    
  vec = vector("list",repetition)
  struct$name <- "rouge gorge"
  struct$date_begin = 3102019
  for (i in 1:repetition) {
    vec[[i]] = struct
  }
  return(vec)
}

# Return a pre allocated vector which contains a certain time (repetition)
# the same data frame or tibble (struct)
# This time the copy_on_modifying is add (we change some elements inside struct)
PA_vector_Df_and_Tb_WCOM = function(repetition,struct) {                                                    
  vec = vector("list",repetition)
  struct$name <- "rouge gorge"
  struct$date_begin = 3102019
  for (i in 1:repetition) {
    vec[[i]] = struct
  }
  return(rbindlist(vec))
}

# return a pre allocated list which contains a certain time (repetition)
# the same list or class instanciation (struct)
PA_List_list_and_class = function(repetition,struct) {                                                    
  li <- lapply(1:repetition,function(i) struct)                                          
  return(li)
}

# return a pre allocated list which contains a certain time (repetition)
# the same data frame or tibble (struct)
PA_List_Df_and_Tb = function(repetition,struct) {                                                    
  li <- lapply(1:repetition,function(i) struct)                                          
  return(rbindlist(li))
}

# return a pre allocated list which contains a certain time (repetition)
# the same list or class instanciation (struct)
# This time the copy_on_modifying is add (we change some elements inside struct)
PA_List_list_and_class_WCOM = function(repetition,struct) {       
  struct$name <- "rouge gorge"
  struct$date_begin = 3102019
  li <- lapply(1:repetition,function(i) struct)                                          
  return(li)
}

# return a pre allocated list which contains a certain time (repetition)
# the same data frame or tibble (struct)
# This time the copy_on_modifying is add (we change some elements inside struct)
PA_List_Df_and_Tb_WCOM = function(repetition,struct) {    
  struct$name <- "rouge gorge"
  struct$date_begin = 3102019
  li <- lapply(1:repetition,function(i) struct)                                          
  return(rbindlist(li))
}