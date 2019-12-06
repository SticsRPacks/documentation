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

# return a pre allocated vector which contains a certain time (repetition)
# the same list or class instanciation (struct)
# PA stands for Pre-allocated
PA_vector_list_and_class = function(repetition,struct) {
  #print(s#printf("%s %s","tracemem struct : ",tracemem(struct)))
  vec = vector("list",repetition)
  #print(s#printf("%s %s","tracemem vect : ",tracemem(vec)))
  for (i in 1:repetition) {
    vec[[i]] = struct
    #print(s#printf("%s %s","tracemem vect : ",tracemem(vec)))
  }
  return(vec)
}

# return a pre allocated vector which contains a certain time (repetition)
# the same data frame or tibble (struct)
PA_vector_Df_and_Tb = function(repetition,struct) {  
  #print(s#printf("%s %s","tracemem struct ",tracemem(struct)))
  vec = vector("list",repetition)
  #print(s#printf("%s %s","tracemem vec 1 ",tracemem(vec)))
  for (i in 1:repetition) {
    vec[[i]] = struct
    #print(s#printf("%s %s","tracemem vec 2 ",tracemem(vec)))
  }
  return(rbindlist(vec))
}

# return a pre allocated list which contains a certain time (repetition)
# the same list or class instanciation (struct)
PA_List_list_and_class = function(repetition,struct) {  
  #print(s#printf("%s %s","tracemem struct ",tracemem(struct)))
  li <- lapply(1:repetition,function(i) struct)                                          
  return(li)
}

# return a pre allocated list which contains a certain time (repetition)
# the same data frame or tibble (struct)
PA_List_Df_and_Tb = function(repetition,struct) { 
  #print(s#printf("%s %s","tracemem struct ",tracemem(struct)))
  li <- lapply(1:repetition,function(i) struct)                                          
  return(rbindlist(li))
}