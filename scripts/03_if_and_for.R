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

#### Learning for loops ####

# Structure
# for (item in list_of items) {
# do_something(item)
#}

# Simple example
volumes <- c(1.6, 3, 8) # any type of vector
for (volume in volumes) { # the name of the item volume is an arbitrary object; after in it has to go a known object in the environment
  print(2.65*volume ^ 0.9) # the name of the item has to match with the name given before
#print(volume) to test if the for loop is working 
}

# multiple steps

for (volume in volumes) { 
  mass <- 2.65 * volume ^ 0.9
  mass_lb <- mass * 2.2
  print(mass_lb)
}

# getting values using index or position

volumes [1]

for (i in 1: length(volumes)) { # work with index value not the numbers of the vector
  mass <- 2.65 * volumes[i] ^ 0.9 # length of volumes is 3 so it goes for 1 to 3
  print(mass)
} 

length(volumes)

#### Storing for loop data in a vector ####

masses <- vector( mode = "numeric", length = length(volumes)) # print an empty vector
# mode is the type of vector and also specify the length of it based on our volumes object
for (i in 1: length(volumes)) {
  mass <- 2.65 * volumes[i] ^ 0.9 
  masses[i] <- mass #fill out the object masses with the results of the loop
} 

#### Exercise 2 ####

# This prints numbers 1 through 5 as is, modify it to
# print each of the numbers multiplied by 3
for (i in 1:5){
  print(i * 3)
}

# Complete code to print out name of each bird
birds <-  c("robin", "woodpecker", "blue jay", "sparrow")

for (i in 1:length(birds)){
  print(birds[i])
}

#### Example reading files ####

#Download zips and extract them
# using an URL and then put the path for the destination

download.file("http://www.datacarpentry.org/semester-biology/data/locations.zip", "locations.zip")
unzip("locations.zip")

list.files() #list the files in my wd
list.files(pattern = "locations-*", full.names = TRUE) #select specific files

#use the for loop to fill in results

data_files <- list.files(pattern = "locations-*", full.names = TRUE) #create an object with this list
results <-  c() #empty object

for (i in 1:length(data_files)) {
data <- read.csv(data_files[i])
count <- nrow(data)
results [i] <- count
}

#how to do a loop through a data frame 
