# Learning how to write functions

#funciont_name <- function(inputs) { #inputs is what you need to calculate the function
#  output_value <- do_something (inputs) everything you want to do with the input value 
#  return(output_value) what you want printed
#} evrything in brackets is the function

# good to start function with a verb because it is an action

#### Creating a function ####
calc_shrub_vol <- function(length, width, height) {
  area <- length * width #objects created 
  volume <- area * height
  return(volume)
}

# Use the function
calc_shrub_vol(1,2.5,2) #you can use data from a data frame

#### using data from a data frame ####

shrub_measurements <- data.frame(length = c(12,14), #create a fake data frame
                                 width = c(2,3),
                                 height= c(1.3, 8))

calc_shrub_vol(shrub_measurements$length[1],
               shrub_measurements$width[1],
               shrub_measurements$height[1])

# to automate this you can vectorize the function or apply() this tells the code to run the function in all the columns or rows

# name the variables
calc_shrub_vol(length = 1, width = 3.4, height = 1.6)
# in different order 
calc_shrub_vol(length = 1, height = 1.6, width = 3.4)

# insert default arguments into the function 
calc_shrub_vol <- function(length, width, height = 1) {
  area <- length * width #objects created but they are not in the global environment, temporary  
  volume <- area * height #black box of the intermediate steps
  return(volume) #not two returns, but one return as a vector c(), it is still just one object
}

calc_shrub_vol(2,10)
# later change height
calc_shrub_vol(2, 10, height = 3)

#### Exercise ####

get_mass_from_length_theropoda <- function(length) {
  mass <- 0.73 * length ^ 3.63
  return(mass)
}

# Question 1: Get mass of 16 m long dinosaur
get_mass_from_length_theropoda(16)

# Question 2: Turn a and b into arguments in function, then run 
#for dinosaur that is 26 m in length, a = 214.44, b = 1.46
get_mass_from_length_theropoda <- function(length,a,b) {
  mass <- a * length ^ b
  return(mass)
}
get_mass_from_length_theropoda(26,214.44,1.46)

#### combining functions ####

est_shrub_mass <- function(volume) {
  mass <- 2.6 * volume ^ 0.9
  return(mass)
}

shrub_vol <- calc_shrub_vol(2,6,2)
shrub_mass <- est_shrub_mass(shrub_vol)

# using pipes

library(dplyr)
shrub_mass <- calc_shrub_vol(2,6,2) %>%
  est_shrub_mass()

# nest functions, ideally not more than two at a time
 shrub_mass <- est_shrub_mass(calc_shrub_vol(1,3,10))