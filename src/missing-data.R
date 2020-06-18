library(tidyverse)
library(naniar)

# See https://cran.r-project.org/web/packages/naniar/vignettes/naniar-visualisation.html
# https://towardsdatascience.com/data-cleaning-with-r-and-the-tidyverse-detecting-missing-values-ea23c519bc62
# https://datacarpentry.org/R-ecology-lesson/01-intro-to-r.html#missing_data

# airquality is an R dataset with missing values
help("airquality")
df_airquality <- as_tibble(airquality)

# Missing values appear as "NA"
glimpse(df_airquality)

# summary() quantifies the number of missing values for each column
summary(df_airquality)

# using the help function to learn about NA
help(NA)
# “NA” or “Not Available” is used for missing values.
# “NaN” or “Not a Number” is used for numeric calculations.
0/0


df_airquality$Ozone # review: the $ operator allows us to extract a column
is.na(df_airquality$Ozone) # results in logical vector
sum(is.na(df_airquality$Ozone)) # TRUE is treated as 1, FALSE as 0


# missing values are "contagious"
mean(df_airquality$Ozone)

df_airquality %>% 
  summarise(
    mean_ozone = mean(Ozone)
    )

# but R has ways to handle them
mean(df_airquality$Ozone, na.rm = TRUE)

df_airquality %>% 
  summarise(
    mean_ozone = mean(Ozone, na.rm = TRUE)
  )


