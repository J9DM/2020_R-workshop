library(dplyr)
library(tidyr)
library(magrittr)
# alternatively:
# library(tidyverse)

df_iris <- as_tibble(iris)
df_iris


# select() to pick variables by their names
select(df_iris, Species) # just Species, no quotes necessary
select(df_iris, -Species) # all but Species
select(df_iris, Sepal.Length, Sepal.Width) # use commas to select more than one column
select(df_iris, Sepal.Length:Petal.Width) # slicing also works here
select(df_iris, starts_with("P"))
select(df_iris, contains("Width"))
select(df_iris, Species, everything()) # use select with or without everything() to reorder columns
df_iris <- select(df_iris, Species, everything()) # assignment
df_iris # now columns are reordered



# filter() to subset rows, i.e. pick observations by their value
levels(df_iris$Species) # recall that factors provide a way of handling categorical data
filter(df_iris, Species == "versicolor") # filter by logical criterion, note "==" NOT "="
filter(df_iris, Species == "versicolor", Sepal.Length >= 6.5) # or by multiple criteria, don't need & for different columns
# filtering can get arbitrarily complicated, separate lines can improve readability
filter(df_iris, Sepal.Length > 6.7, 
       Species == "versicolor" | Species == "virginica") # pipe operator represents "or"
# don't forget the "%in%" operator
filter(df_iris, Sepal.Length > 6.7, 
       Species %in% c("versicolor", "virginica" )
       )

# Additional row subsetting
slice(df_iris, 1:6) # by position
df_iris[1:6, ] # equivalently

top_n(df_iris, 5, Sepal.Length) # sometimes you want to see the top results

# also check out these related functions to filter rows within a selection of variables:
?filter_all(); ?filter_if(); ?filter_at() # the semicolon separates statements- you might see this, I generally avoid it
# for random sub-sampling of rows, set seed for reproducibility
?sample_n; ?sample_frac; ?set.seed



# arrange() to reorder rows. I find this most helpful for exploration.
arrange(df_iris, Sepal.Length) # ascending
arrange(df_iris, desc(Sepal.Length)) # descending
arrange(df_iris, -Sepal.Length) # alternative for descending



# summarise() or summarize() to collapse many values down to a single summary
summarize(df_iris, sep_len_mean = mean(Sepal.Length))
# Can be used with other functions that return a summary value.
summarize(df_iris,
          n = n(),
          sep_len_mean = mean(Sepal.Length)) # n() is generally useful when summarizing
# Here we see that n = 150. That's the entire data frame, but that's maybe not what we want.



# group_by() changes the scope of the dplyr "verbs"
group_by(df_iris, Species) # A tibble: 150 x 5, Groups: Species [3]
# It's not so helpful here, but we can group by multiple variables.
group_by(df_iris, Species, Sepal.Length) # Groups: Species, Sepal.Length [57]
# powerful when combined with summarize()
summarize(group_by(df_iris, Species),
          n = n(),
          sep_len_mean = mean(Sepal.Length)) # scope is now each species
# ungroup, if necessary, with
?ungroup



# mutate() to	create new variables that are functions of existing variables
mutate(df_iris, Petal.Length.x.Width = Petal.Length * Petal.Width)
df_iris # results are transient unless you use assignment



# Avoid nested functions with the pipe operator from magrittr!
# Pipe the output of one function to the input of another, <CTRL> + <SHIFT> + M.
df_iris %>%
  group_by(Species) %>% 
  summarize(
    n = n(),
    sep_len_mean = mean(Sepal.Length))
# You can make pipes arbitrarily long (but for clarity create intermediate variables if steps > ~10).
df_iris %>%
  mutate(
    Petal.Length.x.Width = Petal.Length * Petal.Width) %>% 
  group_by(Species) %>% 
  summarize(
    n = n(),
    Petal.Length.x.Width.mean = mean(Petal.Length.x.Width)
  )




# use backticks, ``, to handle non-syntactic variable names
tb <- tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
)
tb
tb$`:)`



# Exercises
# https://www.r-exercises.com/2017/10/19/dplyr-basic-functions-exercises/
df_iris <- as_tibble(iris)
colnames(df_iris)

# Return all columns that contain "Length"
# Which verb?
select(df_iris, contains("Length"))
df_iris %>% select(contains("Length"))
# Return first four columns
select(df_iris, 1:4)
select(df_iris, -Species)

# Return all observations Sepal.Length >= 6.6 and Petal.Width >= 2.5
# Which verb?
filter(df_iris, Sepal.Length >= 6.6, Petal.Width >= 2.5)

# Arrange observations in descending order of Petal.Length
# Which verb?
arrange(df_iris, desc(Petal.Length))

# Create a new column called proportion (ratio of Sepal.Length to Sepal.Width).
# Which verb?
mutate(df_iris, proportion = Sepal.Length / Sepal.Width)

# Compute the mean of Sepal.Length and name the value “avg_slength”.
# Which verb?
summarize(df_iris, avg_slength = mean(Sepal.Length))

# Split the iris data frame by the Species, then calculate mean Sepal.Length as above.
# Which verbs?
df_iris %>% 
  group_by(Species) %>% 
  summarize(avg_slength = mean(Sepal.Length))

