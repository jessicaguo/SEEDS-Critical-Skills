# learning If statements 
# 
# if( the conditional statement is true) { 
#   do something }

x <-4 

if (x > 5) {
  x <- x ^ 2
}

x

veg_type <- "tree"
volume <- 16
if (veg_type== "tree"){
  mass <- 2.6 *volume ^ 0.9
} 

veg_type <- "grass"
volume <- 16
if (veg_type== "tree"){
  mass <- 2.6 *volume ^ 0.9
} else if (veg_type=="grass"){
  mass<-06 *volume ^1.2
}


# Question: Complete if statement so that age_class is sapling
# returns a y of 10, and age_class of seedling sets y to 5
# if age_class is neither, return y of 0
age_class <- ("seedling")

if (age_class== "sapling"){
  y <- 10
} else if (age_class=="seeding") {
  y <- 5
} else {
  y <- 0
}

# Learning for loops - repeated actions on a list 
 
#for(item in list_of_items){
#  do_something(item)
# }

volumes <- c(1.6,3,8)

for (volume in volumes) {
  mass <- 2.65 *volume ^ 0.9
  mass_lb <- mass *2.2
  print(mass_lb)
}


for (i in 1:length(volumes)){
  mass <- 2.65 * volumes [i]^ 0.9 
  print(mass)
}

# used to save the data 
# create empty object
masses <- vector (mode = "numeric", length = length(volumes))

for (i in 1:length(volumes)){
  mass <- 2.65 * volumes [i]^ 0.9 
  masses[i] <- mass # assign results so empty vector 
}

# Exercise 1
# This prints numbers 1 through 5 as is, modify it to
# print each of the numbers multiplied by 3
for (i in 1:5){
 thrice <- 3 * i
  print(thrice)
}

# Exercise 2
# Complete code to print out name of each bird

birds = c("robin","woodpecker","bluejay", "sparrow")

for (i in 1:length(birds)){
  print(birds[i])
}

download.file("http://www.datacarpentry.org/semester-biology/data/locations.zip","locations.zip")
unzip("location.zip")

data_files <-  list.files (path = "locations", pattern = "locations",full.names = TRUE)

results <- c()

for (i in 1:length(data_files)) {
  data <- read.csv(data_files[i])
  count <- nrow(data)
  results [i] <- count
}




