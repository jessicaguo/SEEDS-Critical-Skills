# Learning  how to write functions

# function_name <-  function(inputs) {
#   output_value <- do_something (inputs)
#   return (output_value)
# }


calc_shrub_vol <- function(length, width, height) {
  area <- length * width 
  volume <- area * height
  return(volume)
}

shrub_vol <- calc_shrub_vol(1,2.5,2)




get_mass_from_length_theropoda <- function(length){
  mass <- 0.73 * length ^ 3.63
  return(mass)
}
# Question 1: Get mass of 16 m long dinosaur

get_mass_from_length_theropoda(16)


# Question 2: Turn a and b into arguments in function, then run
# for dinosaur that is 26 m in length, a = 214.44, b = 1.46

get_mass_from_length_theropoda <- function(length, a, b){
  mass <- a * length ^ b
  return(mass)
}

get_mass_from_length_theropoda(26,214.44,1.46)

est_shrub_mass <- function(volume){ 
  mass <- 2.6 * volume ^0.9
  return(mass)
}


shrub_vol <- calc_shrub_vol(2,6,2)
shrub_mass <- est_shrub_mass(shrub_vol)

library(dplyr)

shrub_mass <- calc_shrub_vol (2,6,2) %>%
  est_shrub_mass()

shrub_mass <-  est_shrub_mass(calc_shrub_vol(1,3,10))