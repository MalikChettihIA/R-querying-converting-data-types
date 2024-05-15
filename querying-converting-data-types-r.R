
### Module: Understanding Dataset Structures
#           and Formats

## RStudio Overview
# Install R library:
# install.packages(" ")

# Activate R library:
# library()

## Required Libraries
# Use the interface or run:
install.packages("dplyr", "data.table",
                 "stringr", "chron",
                 "tibble")
# Activate libraries in each session

## Exercise Datasets
# Help section
?airmiles

# Data exploration
head(airmiles)

tail(airmiles)

summary(mtcars)

# Visual exploration
plot(mtcars)

hist(airmiles)

# Working with a data.frame
head(mtcars)

sum(mtcars$wt)

attach(mtcars)
sum(wt)
detach(mtcars)
sum(wt)

# Indexing operator [row, column]
mtcars[2,6]
mtcars[c(2,5,8),6]


## Course Datasets

?mtcars
View(mtcars)

?iris
View(iris)


## The Tabular Format: Data.frame
View(mtcars)


## Alternatives to a Data.frame
# Libraries required
library(data.table)
library(dplyr) #or tibble

class(iris)

irisdt = data.table(iris)
class(irisdt)
head(irisdt)

iristibble = as_tibble(iris)
class(iristibble)
head(iristibble)



### Module: Selecting and Converting Data Types

## Type conversion: Numeric and Integer
mydata = c(4.5, 4.999, 3.43)

mydata = as.numeric(mydata)
is.numeric(mydata)

mydata = round(mydata, 0)
is.numeric(mydata)

mydata = as.integer(mydata)
is.integer(mydata)

# Type conversion on a data.frame
View(iris)
newsepal = as.integer(iris$Sepal.Length)
head(iris)
head(newsepal)

newsepal2 = as.integer(round(
                       iris$Sepal.Length),0)
head(newsepal2)


## Type conversion: Character and Factor
summary(iris)
is.factor(iris$Species)

myspecies = as.character(iris$Species)
myspecies = as.factor(myspecies)
levels(myspecies)

## Boolean or Logical Values
x = iris$Sepal.Length > mean(iris$Sepal.Length)
x

x = as.numeric(x)
x

# Class complex
?complex


## List or Data Frame
# Defining list components
myvector = c(4, 6, 3)
mydf = iris
mymatrix = matrix(c(4,4,5,5), nrow = 2)

mylist = list(myvector, mydf, mymatrix)


## Dates and Time
# POSIXt classes in R
x = as.POSIXct("2019-12-25 11:45:34")
y = as.POSIXlt("2019-12-25 11:45:34")

# Give the same output
x; y
unclass(x)
unclass(y)

# What does the number mean?
(50 * 365 * 24 * 60 * 60) - (5.5 * 60 * 60) #approx.
unclass(x)

# Extracting date and time components
y$zone
x$zone #not possible

# A further class based on days
x = as.Date("2019-12-25")
x; class(x)
unclass(x)
50 * 365 - 5 #approx.

# Time zone naive date time class
library(chron)
x = chron("12/25/2019", "23:34:09")
x
class(x)
unclass(x)


## Type conversion: String to Date/Time
?strptime

a = as.character(c("1993-12-30 23:45", 
                   "1994-11-05 11:43", 
                   "1992-03-09 21:54"))
class(a)

b = strptime(a, format = "%Y-%m-%d %H:%M")
b; class(b)



### Module: Querying and Filtering Data

## R Base Queries
# Filtering with indexing operator
# [rows, columns]
mtcars[2,3]

mtcars[2, ]

mtcars[, "cyl"]

mtcars[c(2,4,7:12), ]


## Conditional Queries (Logical Tests)
subset(mtcars, cyl < 6)

subset(mtcars, cyl == 6)

subset(mtcars, !cyl == 6)

subset(mtcars, cyl == 6 & gear > 3)

subset(mtcars, cyl == 6 | gear == 3)

subset(mtcars, cyl == 6 | gear == 3,
       select = c("mpg", "cyl", "gear"))


## Simple Data.table Queries
library(data.table)

mydt = data.table(mtcars)
class(mydt)
head(mydt)
mydt[2,]
mydt[,2]

mydt[cyl == 6, ]
mydt[cyl == 6 & gear > 3, ]


## Complex Queries with Data.table
# Subsetting (i) and aggregating (j)
mydt[cyl == 6, sum(mpg)]

# Query: j, by
mydt[, by = cyl, .N]

# Query: i, j
mydt[cyl == 6, .N]

# Query: i, by, j
mydt[cyl == 6, by = gear, .N]

# Query by interval
?data.table::between
mydt[between (cyl, 4, 7)]
mydt[cyl %between% c(4,7)]
mydt[cyl %in% c(4,7)]

# Sort
mydt[order(-mpg)]


## Queries with Dplyr (Tbl)
library(dplyr)

mytbl = as_tibble(mtcars)
?arrange

select(mytbl, cyl)
select(mtcars, cyl)

# Subsetting - observations
filter(mytbl, cyl == 6 & gear == 5)
filter(mytbl, cyl < 6)
slice(mytbl, c(1,3,6))

# Reorder
arrange(mytbl, cyl)
arrange(mytbl, -cyl)
arrange(mytbl, desc(cyl))

# Subsetting - variables
select(mytbl, cyl, gear)
select(mytbl, -cyl)

# Rename headers
rename(mytbl, Cylinder = cyl)

# Find unique values
distinct(select(mytbl, cyl))
        
# Add new variable
mutate(mytbl, cons_adj = mpg/hp)

# Collapse table
summarise(mytbl, mean = mean(mpg))
         
       
## Filtering with Strings
mydata = cbind(mtcars,
               names = rownames(mtcars))
summary(mydata)
mydata$names = as.character(mydata$names)

library(stringr)
?str_detect
str_detect(mydata$names, pattern = "Mazda")

mydata$Mazda = str_detect(mydata$names,
                          pattern = "Mazda")
mydata



### Module: Course Summary and Further Resources
















