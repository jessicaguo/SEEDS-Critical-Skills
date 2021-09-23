# Learning how to make functions

# function_name <- function(inputs) {
#    output_value <- do_something(inputs)
#    return(output_values)
# }

# Use shift+ctrl+C to comment out chunks of code!!!

calc_shrub_vol <- function(length, width, height) {
  area <- length * width
  volume <- area * height
  return(volume) # if you use return, it will print the output; otherwise it won't print but you can assign it to something
}

calc_shrub_vol(1, 2.5, 2) # if you put in your inputs without variable names 
                          # it assumes it's in the order you established in the function

shrub_vol <- calc_shrub_vol(1, 2.5, 2)

calc_shrub_vol(length = 0.8, height = 2.0, width = 1.6) # you can change the order only if you define the variable

shrub_measurements <- data.frame(lengths =c(12, 14),
                                 widths = c(2, 3),
                                 height = c(1.3, 8))

calc_shrub_vol(shrub_measurements$lengths[1],
               shrub_measurements$widths[1],
               shrub_measurements$height[1])

calc_shrub_vol <- function(length, width, height =1) { # if one of your variables is constant, you can give it a value
  area <- length * width # BUT NOTE that there's no object called area
  volume <- area * height
  return(volume) 
}

calc_shrub_vol(2, 10)
calc_shrub_vol(2, 10, height =2) # you can still change that though

calc_shrub_vol <- function(length, width, height =1) { # if one of your variables is constant, you can give it a value
  area <- length * width # BUT NOTE that there's no object called area
  volume <- area * height
  return(c(volume, area)) # you can also return an object that's more complicated
}

# Excercise

# Function using an allometric scaling equation to calculate weight from length
get_mass_from_length_therapoda <- function(length) {
  mass <- 0.73 * length ^ 3.63
  return(mass)
}

# Get mass of 16m long dinosaur
get_mass_from_length_therapoda(16)  # 17150.56

# Turn a and b into arguments in function...
get_mass_from_length_therapoda <- function(length, a, b) {
  mass <- a * length ^ b
  return(mass)
}

# Then run for dinosaur that is 26m in length, a = 214.44, b = 1.46
get_mass_from_length_therapoda(26, 214.44, 1.46) # 24955.54


est_shrub_mass <- function(volume) {
  mass <- 2.6 * volume ^ 0.9
  return(mass)
}

shrub_vol <- calc_shrub_vol(2, 6, 2)
shrub_mass <- est_shrub_mass(shrub_vol)

# Same as above but piped
shrub_mass <- calc_shrub_vol(2, 6, 2) %>%
  est_shrub_mass()

shrub_mass <- est_shrub_mass(calc_shrub_vol(1, 3, 10))
