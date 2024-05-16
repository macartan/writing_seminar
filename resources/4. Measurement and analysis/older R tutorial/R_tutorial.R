# R Tutorial
# Sept 16, 2016

# This is a comment and it will not be executed.

# The Basics --------------------------------------------------------------

4 

"Hello World"

2 + 3

5^2

35/5

2*8

#Note that spaces do not make a difference
(3.5 + 2.7) / (900 * 2)

# Assigning Objects

x <- 3
x

y <- 5
y

z <- "abc" # this is a character string

x + y

x + z # do you think this will work?

# Logicals

x=5		# alt. syntax for assignment operator (do not use)

x

x==5	# this is a logical condition


x <- TRUE	# assign logical values to variables
x

y <- FALSE

x + y # TRUE evaluates to 1 and FALSE evaluates to 0


# Vectors

## The function c() allows you to concatenate a bunch of items into a vector

x <- c(1,2,3,4)
x

## You can grab specific elements of a vector. 

x[2]

## You can add vectors
y <- c(5,6,7,8,9)
x + y

## You can append one vector to another
z <- c(x,y)
z


## Vectors can also contain string values

stringvec <- c("one","neo","eon")
stringvec

# Matrices

matrix1 <- matrix(1:12, nrow=3, ncol=4)
matrix1

matrix2 <- matrix(13:24, nrow=3, ncol=4)
matrix2

# You can add or subtract them
matrix1 + matrix2
matrix1 - matrix2

# You can combine them row-wise or column-wise
rbind(matrix1, matrix2)
cbind(matrix1, matrix2)

## Subsetting: matrix1[row index, column index]

matrix1[2,2]
matrix1[3,4]
matrix1[,1] # first column
matrix1[2,] # second row
matrix1[1:2,] # row 1 and 2
matrix1[-1,-1]

# Data frames (think of a mini data set)

df1 <- as.data.frame(matrix1)
df1 

## Variable names

names(df1)

## Changing variable names

names(df1) <- c("A", "B", "C", "D")
names(df1)

## Checking how large your data set is

dim(df1) # 3 rows, 4 columns
nrow(df1) # 3 observations
ncol(df1) # 4 variables

## Subsetting works the same as with matrices

df1[2,2]
df1[3,4]

## But we can use the $ to refer to variables (not possible for a matrix):

df1$A
df1$C

## Other ways to subset using logical conditions

df1[df1$A > 1, ]
df1[df1$A < 2, 2]
df1[df1$A == 1, 2:3]
df1[df1$B != 6, ]

# Logical Operators
#	<	less than
#	<=	less than or equal to
#	>	greater than
#	>=	greater than or equal to
#	==	exactly equal to
#	!=	not equal to
#	!x	Not x
#	x | y	x OR y
#	x & y	x AND y
#	isTRUE(x)	test if X is TRUE

# Functions

## We have already used a whole bunch of built-in R functions so far. How can you learn about a function?

?matrix

# Before we move on to data, we need to learn about a couple of general things:

## Clearing your workspace 

rm(list=ls())

## Setting your working directory

setwd("~/Dropbox/2016_17_Class_Folder/2 Student Folders/Anna") # Replace Anna with your name

## Installing a package (you only need to do this once)

install.packages("foreign") # look into this!

## Loading a package

library(foreign)

# It is good practice to clear the workspace and load all the packages that you need at the beginning of your R script.


# Working with data -------------------------------------------------------

# Read in file

data <- read.csv(file = "04 Data/data_Rtutorial.csv") # For Stata files use read.dta

data

# Saving file as an .RData file
save(data, file = "04 Data/mydata.RData")

# can be loaded again with load("mydata.RData")

# Write a stata file

write.dta(data, "mystatafile.dta")

# use write.csv if you would like to write a csv file

# Look at data 

View(data)
head(data) # first couple of rows
tail(data) # last couple of rows
names(data) # variable names
dim(data) # dimensions of data frame
nrow(data) # number of rows (observations)
ncol(data) # number of columns (variables)

summary(data)

# Look at Variables

data$income

summary(data$income)

# Subsetting with indices

data$income[532] # income

data[,2] # second column (also income)

data[532, 6]


# Subsetting based on a logical condition

data$income[data$gender == "Female"]
data[data$private_school == 0,]

# Creating a frequency table

table(data$gender, useNA = "always")
table(data$private_school, useNA = "always")


# Creating a frequency table for a sub-group

table(data$gender[data$income > 100], useNA = "always")

# Creating a cross-table

table(data$gender, data$private_school, useNA = "always")

table(data$motivation, data$private_school, useNA = "always")

# Creating a histogram

hist(data$parents_income, breaks=15, main="Histogram of Parent's Income", xlab="Parent's Income")
hist(data$years_education, breaks=15, main="Histogram of Education Years", xlab= "Years of Education")

# Creating a scatter plot

plot(data$years_education, data$income, main="Scatterplot of Education on Parent's Income", pch=16)
plot(data$parents_income, data$income,  main="Scatterplot of Income on Parent's Income", pch=16)


# Looking at a correlation

## Pearson correlation coefficient is a measure of LINEAR dependence
## Ranges from -1 to 1
## cov(X,Y)/(sd_x * sd_Y)

cor(data$parents_income, data$income, use = "complete.obs")

cor(data$years_education, data$income, use = "complete.obs")


# Running a regression

model <- lm(income ~ years_education, data = data)

summary(model)


# Now, back to the question of confounding, what can we do? Control for other variables

model_2 <- lm(income ~ years_education + iq, data = data)
summary(model_2)

# Estimate decreases: correlation is positive  
# Can this be interpreted as the estimate of a causal effect now?
# What about other confounders?

model_3 <- lm(income ~ years_education + iq + parents_income, data = data)
summary(model_3)

  
# Running a regression with an interaction term

# Mean SAT in four groups defined by student's school and motivation
mean(data$sat_score[data$motivation == 0 & data$private_school==0], na.rm = TRUE)
mean(data$sat_score[data$motivation == 1 & data$private_school==0], na.rm = TRUE)
mean(data$sat_score[data$motivation == 0 & data$private_school==1], na.rm = TRUE)
mean(data$sat_score[data$motivation == 1 & data$private_school==1], na.rm = TRUE)

# Model with interaction
interaction_model <- lm(sat_score ~ motivation*private_school, data = data)

summary(interaction_model)

# Uncovering the means from the coefficients
coef(interaction_model)[1]
coef(interaction_model)[1] + coef(interaction_model)[2]
coef(interaction_model)[1] + coef(interaction_model)[3]
coef(interaction_model)[1] + coef(interaction_model)[2] + coef(interaction_model)[3] + coef(interaction_model)[4]

# Effect of motivation for students in public schools
coef(interaction_model)[2]

# Effect of motivation for students in private schools
coef(interaction_model)[2] + coef(interaction_model)[4]

# Effect of private school for unmotivated students 
coef(interaction_model)[3]

# Effect of private school for motivated students 
coef(interaction_model)[3] + coef(interaction_model)[4]

# Note that interaction term is significant. What does this tell us?

# Additional Material -----------------------------------------------------

# Functions and Loops

# sample function that adds two vectors

# input arguments are:
#	a is a vector of numbers
# b is a vector of numbers
# a and b are of the same length

# define function

addVectors <- function(a,b) {
  out.vec <- a + b
  return(out.vec)
}

# define objects that are input arguments

a <- c(1,2,3,4,5)
b <- c(15,14,13,12,11)

# invoke function

addVectors(a,b)

out.vec			# object 'out.vec' is local to the function!

sum.vec <- addVectors(a,b)		# we can assign the returned object to another object
sum.vec



#Loops do a single action many times

means <- rep(NA,times=5)
for(i in 1:5){
  means[i] <- mean(c(a[i],b[i]))
}

means


# Creating Regression Tables using the Stargazer Package

#install.packages("stargazer")
library(stargazer)

stargazer(model, type = "text")

my_models <- list(model, model_2, model_3)

stargazer(my_models, type = "text")


