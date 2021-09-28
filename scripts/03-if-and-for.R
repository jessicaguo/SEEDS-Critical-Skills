# Learning if statements

# if (the conditional statement is TRUE) {
#   do something
# }

x <- 4
if (x > 5) {
  x <- x ^ 2
}

veg_type <- "tree"
volume <- 16
if (veg_type == "tree") {
  mass <- 2.6 * volume ^ 0.9
}

veg_type <- "forb"
if (veg_type == "tree") {
  mass <- 2.6 * volume ^ 0.9
} else if (veg_type == "grass") {
  mass <- 0.6 * volume ^ 1.2
} else {
  mass <- NA
}

length <- "fjdskl"
ifelse(length == 5, "correct", ifelse(length == 6, "correct", "incorrect"))

# Exercise

# Question: Complete if statement so that age_class is sapling
# returns a y of 10, and age_class of seedling sets y to 5
# if age_class is neither, return y of 0

age_class <- "xyz"
if(age_class == "sapling") {
  y <- 10
} else if (age_class == "seedling") {
  y <- 5
} else {
  y <- 0
}

y <- 5
5 -> y
y = 5

# Learning for loops

# for (item in list_of_items) {
#   do_something(item)
# }

volumes <- c(1.6, 3, 8)
for (volume in volumes) {
  mass <- 2.65 * volume ^ 0.9
  mass_lb <- mass * 2.2
  print(mass_lb)
}

# getting values using index or position
volumes[1]
volumes[2]
volumes[3]

for (i in 1:length(volumes)) {
  mass <- 2.65 * volumes[i] ^ 0.9
  print(mass)
}

masses <- vector(mode = "numeric", length = length(volumes))
for (i in 1:length(volumes)) {
  mass <- 2.65 * volumes[i] ^ 0.9
  masses[i] <- mass
}

# Exercise 1

# This prints numbers 1 through 5 as is, modify it to
# print each of the numbers multiplied by 3

for (i in 1:5){
  m <- i * 3
  print(m)
}

for (i in 1:5){
  print(i * 3)
}

# Exercise 2

# Complete code to print out name of each bird

birds = c('robin', 'woodpecker', 'blue jay', 'sparrow')
for (i in 1:length(birds)){
  print(birds[i])
}

download.file("http://www.datacarpentry.org/semester-biology/data/locations.zip", 
              "locations.zip")
unzip("locations.zip")

data_files <- list.files(pattern = "locations-*", full.names = TRUE)

results <- c()

for (i in 1:length(data_files)) {
  data <- read.csv(data_files[i])
  count <- nrow(data)
  results[i] <- count
}

