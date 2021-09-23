# Jessene Aquino-Thomas
# 9/23/2021
# Learning how to write functions

# this is the general function format
# function_name <- function(inputs) {
#   output_value <- do_something(inputs)
#   return(out_value)
# }

calc_shrub_vol <- function(length, width, height) {
  area <- length * width
  volume <- area * height
  return(volume)
}

calc_shrub_vol(1, 2.5, 2)



# Excerise
get_mass_from_length_teropoda <-  function(length){
  mass <- 0.73 * length ^ 3.63
  return(mass)
}


# Question 1: Get mass of 16 m long dinosaur 
get_mass_from_length_teropoda(16)

# Question 2: Turn a and b into arguments in function, then run 
# for dinosaur that is 26 m in length, a = 214.44, b = 1.46
get_mass_from_length_teropoda2 <-  function(length, a, b){
  mass <- a * length ^ b
  return(mass)
}

get_mass_from_length_teropoda2(26, 214.44, 1.46)




