# Just as we did in the Console, we can write and run R statements from a script.
x <- 2
# Try the shortcut <ALT> + "-" for the assignment operator.

# To run the current line you can:
# 1. click "Run" button
# 2. select "Run Selected Lines" from the "Code" menu
# 3. hit <Ctrl> + <Return> in Windows or  <Cmd> + <Return> on OS X
#    Note that you do NOT need to be at the end of the line for this to work.

# Run the entire file with Source or using the source() function.

# You've probably guessed that "#" begins a comment line!
x # You can also add in-line comments.

# Check out your "History"
# You can rerun commands in your "History" or write them to source

# Try out <Ctrl>-L

# and
ls()

# What do you think the following line does?
# rm(list = ls())





# Now let's bring in some data.
# R has built-in data sets for exploration and practice.
# The iris data set is a popular one
?iris

# Let's coerce it to a tibble, which is a newer version of an R data frame
# First we need to load the tidyverse collection of packages:
library(tidyverse)
# It's good practice to put such statements at the top of a script.
# Note that any conflicts are flagged.
# Here, filter() is a function used by both dplyr and by stats.
# If you want to use the stats' filter() you'll have to make this explicit:
# stats::filter()
df_iris <- as_tibble(iris)
df_iris
# By default, only the first 10 rows of a tibble is printed to the Console.
# You can inspect the entire data frame with
View(df_iris)
# or by clicking on it in the Environment tab
# To examine the first few lines you can also use
head(df_iris)


# You can see that this is a heterogenous data set with columns:
# <dbl>, <dbl>, <dbl>, <dbl>, and <fct>
# that is, double and factor
# We haven't discussed factors yet.
# They're a special way that R can work with categorical data.
levels(df_iris$Species)
# So there are 3 "levels" of Species, 3 possible values Species can take.
# The $ operator allowed us to specify the Species column 
# and is an important way to subset the data frame.
df_iris$Species
# Note that, even though a data frame can have columns of different types,
# data within the same column must all be of the same type.


# Some useful functions for understanding the structure of a data frame:
# We can ask what columns are in our data frame:
colnames(df_iris)
# How many rows?
nrow(df_iris)
# dimensions
dim(df_iris)
# overall structure
str(df_iris)
summary(df_iris)





# Subsetting data frames
df_iris
# extract column
df_iris$Sepal.Length
# notice that the result is a numeric vector
typeof(df_iris$Sepal.Length)
# so you can access components as before
df_iris$Sepal.Length[1:5]

# But if you want to maintain the data frame, use bracket indexing
df_iris["Sepal.Length"]

# We could go deeper into subsetting lists using brackets, 
# but practically, I find the "verbs" of the tidyverse to be more relevant
# to the kinds of analyses I generally do.


