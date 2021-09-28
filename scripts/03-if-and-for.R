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




