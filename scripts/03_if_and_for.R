# Learning if Statements

#if (the condition statement is TRUE) {
#    do something
# }

#### creating a simple condition ####

x <- 4
if (x > 5) { #objects created in the if function go into the global environment
  x <- x ^ 2 #if FALSE it does nothing
}

# biological example

veg_type <- "tree"
volume <- 16
if (veg_type == "tree") {
  mass <- 2.6 * volume ^ 0.9 # this object would be saved
}

# using else to complicate more the condition
veg_type <- "grass"
if (veg_type == "tree") {
  mass <- 2.6 * volume ^ 0.9 # this object would be saved
} else if (veg_type == "grass") { #nest the second condition
  mass <- 0.6 * volume  ^ 1.2
} else { # adding another condition
  mass <- NA
}

#### ifelse function ####
#ifelse vectorize needed to create a new column
length <- 7
ifelse(length == 5, "correct", ifelse (length == 6, "correct", "incorrect"))

#### Exercise ####

# Question: Complete if statement so that age_class is sapling
# returns a y of 10, and age_class of seedling sets y to 5
# if age_class is neither, return y of 0

age_class <- "seedling"

if (age_class == "seedling"){
  y <- 5
} else if (age_class == "sapling") {
  y <- 10
} else {
  y <- 0
}