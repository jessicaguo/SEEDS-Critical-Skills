#### Learning if statements ####

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


#### Learning for loops ####

# for (item in list_of_items) {
#   do_something(item)
# }

volumes <- c(1.6, 3, 8)
for (volume in volumes) {
  print(2.65 * volume ^ 0.9)
}

for (volume in volumes) {
  mass <- 2.65 * volume ^0.9
  mass_lb <- mass * 2.2
  print(mass_lb)
}

# Getting values using index or position
volumes[1]
volumes[2]
volumes[3]

for(i in 1:length(volumes)) {
  mass <- 2.65 * volumes[i] ^ 0.9
  print(mass)
}

masses <- vector(mode = "numeric", length = length(volumes))

for(i in 1:length(volumes)) {
  mass <- 2.65 * volumes[i] ^ 0.9
  masses[i] <- mass
}

# How to create an empty vector
masses <- c()

# Exercise 1

# This prints numbers 1 through 5 as is, modify it to print each of the numbers multiplied by 3

for(i in 1:5) {
  print(i)
}

for(i in 1:5) {
  print(i * 3)
}

# Exercise 2

# Complete code to print out name of each bird

birds = c("robin", "woodpecker", "blue jay", "sparrow")

for (i in 1:length(birds)){
  print(birds[i])
}

# You provide a url and local file path to download files

download.file("http://www.datacarpentry.org/semester-biology/data/locations.zip", "locations.zip")

unzip("locations.zip")

# This will list all of your files in current directory
list.files()

data_files <- list.files(pattern = "location-*", full.names = TRUE)
View(data_files)

# Creating an empty vector, has nothing in it
results <- c()


for(i in 1:length(data_files)) {  # create a vector of position
  data <- read.csv(data_files[i])
  count <- nrow(data)
  results[i] <- count
}

results
