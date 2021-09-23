# Learning if statements

# if (the conditional statement is TRUE) {
#   do something
# }

x <- 4
if(x > 5) {
  x <- x ^2
}

veg_type <- "tree"
volume <- 16

if(veg_type == "tree") {
  mass <- 2.6 * volume ^ 0.9  # different to the function, this DOES get saved to the environment
}

veg_type <- "grass"

if(veg_type == "tree") {
  mass <- 2.6 * volume ^ 0.9
} else if (veg_type == "grass") {
  mass <- 0.6 * volume ^ 1.2
}

length <- 5
ifelse(length == 5, "correct", "incorrect")

# Excercise

# Complete if statement so that age_class= sapling returns a y of 10, and age_class= seedling sets y to 5; if age_class is neither, return y of 0

age_class <- "seedling"
if(age_class == "sapling") {
  y <- 10
} else if (age_class == "seedling") {
  y <- 5
} else {
  y <- 0
}