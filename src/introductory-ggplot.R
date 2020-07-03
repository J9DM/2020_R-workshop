library(tidyverse)

# Again, we'll work with the iris dataset.
df_iris <- as_tibble(iris)
df_iris


# Today, we'll focus on the package ggplot2, which works with the rest of the tidyverse.
# See https://r4ds.had.co.nz/data-visualisation.html
?ggplot
# What arguments does ggplot() take?


# ggplot() constructs an initial plot object.
# Let's supply a data frame.
ggplot(data = df_iris)
# We didn't get an error, but we didn't get anything useful:
# mapping	  Default list of aesthetic mappings to use for plot.
#           If not specified, must be supplied in each layer added to the plot.


# We need to specify what R calls "aesthetics": mapping = aes()
# Aesthetics provide a way to "map" the data to some visual property.
# The concept of aesthetics includes x- and y-coordinates!
# Specify aesthetics in initial call to ggplot()
# or for more flexibility, add layers


# Maybe we want to see if there's a relationship between sepal length and sepal width.
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width))
# Still nothing.
# What's going on?


# Introducing geoms
??geom
# Use two question marks when you're not quite sure what you're looking for.
# "A geom is the geometrical object that a plot uses to represent data."
#   bar charts use bar geoms
#   line charts use line geoms
#   boxplots use boxplot geoms
#   scatterplots use the point geom


# Two continuous variables
# Ok, we need a way to visually represent the x-y data. Let's try the point geom.
# Notice the "+" sign. ggplot2 precedes the "%>%", but works in a similar way.
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()
# What other geoms might make sense for two continuous variables?
# Check a ggplot cheat sheet.
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_rug()
# not very useful here, but we can combine the two geoms:
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() + geom_rug()
# What do you think "alpha" does?
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(alpha = 0.2) + geom_rug(alpha = 0.2)
# What about "jitter"?
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(position = "jitter") + geom_rug(position = "jitter")
# Jitter maybe doesn't work well here when coordinate position means something- better for categorical data.


# Are there different groups in our data?
# dplyr functions again!
# Can be piped into ggplot!
df_iris %>% 
  filter(Species == "setosa") %>% 
  ggplot(mapping = aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()
# We can do something more useful.
# Add another aesthetic aside from x- y- position: color, shape, size
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(mapping = aes(color = Species))
# When do we put aesthetics in the call to ggplot() vs. the the call to geom_point()?
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()
# Compare:
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() + geom_rug()
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(mapping = aes(color = Species)) + geom_rug()
# Or:
ggplot(data = df_iris, mapping = aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  geom_smooth()



# Discrete and continuous variable
ggplot(data = df_iris, mapping = aes(x = Species, y = Sepal.Length)) +
  geom_boxplot()
# Compare with dplyr
df_iris %>% 
  filter(Species == "setosa") %>% 
  summary()

# Other geoms to try out
ggplot(data = df_iris, mapping = aes(x = Species, y = Sepal.Length)) +
  geom_violin()
# Again, you can specify other aesthetics
ggplot(data = df_iris, mapping = aes(x = Species, y = Sepal.Length)) +
  geom_violin(mapping = aes(fill = Species))

# What went wrong here?
ggplot(data = df_iris, mapping = aes(x = Species, y = Sepal.Length)) +
  geom_dotplot()
# I didn't find the documentation very helpful this time.
?geom_dotplot
# But checking out the cheat sheet gave me an idea
# https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf
ggplot(data = df_iris, mapping = aes(x = Species, y = Sepal.Length)) +
  geom_dotplot(binaxis = "y", stackdir = "center")
# What does changing binwidth do? Perform an experiment:
ggplot(data = df_iris, mapping = aes(x = Species, y = Sepal.Length)) +
  geom_dotplot(binaxis = "y", stackdir = "center", binwidth = 1)
ggplot(data = df_iris, mapping = aes(x = Species, y = Sepal.Length)) +
  geom_dotplot(binaxis = "y", stackdir = "center", binwidth = 1/15)

# Again, a powerful feature of ggplot is that you can layer graphics:
ggplot(data = df_iris, mapping = aes(x = Species, y = Sepal.Length)) +
  geom_violin(mapping = aes(fill = Species)) +
  geom_dotplot(binaxis = "y", stackdir = "center", binwidth = 1/15)





# Exercises




# Modifying an example from the web.
# https://www.r-graph-gallery.com/histogram_several_group.html


# library
library(ggplot2)
library(dplyr)
library(hrbrthemes)
# probably need: install.packages("hrbrthemes")

# Build dataset with different distributions
data <- data.frame(
  type = c( rep("variable 1", 1000), rep("variable 2", 1000) ),
  value = c( rnorm(1000), rnorm(1000, mean=4) )
)

# Represent it
p <- data %>%
  ggplot( aes(x=value, fill=type)) +
  geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity') +
  scale_fill_manual(values=c("#69b3a2", "#404080")) +
  theme_ipsum() +
  labs(fill="")
p


# Now modify code for our data set.
head(data)
# type value
df_iris
# Species Sepal.Length

p1 <- df_iris %>%
  ggplot( aes(x=Sepal.Length, fill=Species)) +
  geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity') +
  scale_fill_manual(values=c("#69b3a2", "#404080")) +
  theme_ipsum() +
  labs(fill="")
p1

# Error: Error: Insufficient values in manual scale. 3 needed but only 2 provided.
p1 <- df_iris %>%
  ggplot( aes(x=Sepal.Length, fill=Species)) +
  geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity') +
  scale_fill_manual(values=c("#69b3a2", "#404080", "green")) +
  theme_ipsum() +
  labs(fill="")
p1

# `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
p1 <- df_iris %>%
  ggplot( aes(x=Sepal.Length, fill=Species)) +
  geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity', binwidth = 1/4) +
  scale_fill_manual(values=c("#69b3a2", "#404080", "green")) +
  theme_ipsum() +
  labs(fill="")
p1






