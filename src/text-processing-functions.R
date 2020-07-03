# Functions for processing text file output of CRaQ program.

find_delim <- function(text) which(str_detect(text, fixed(pattern = "==")))

find_starts <- function(loc_delim) loc_delim + 2

find_ends <- function(loc_delim, text) {
  c((loc_delim[-1] -2), length(text))
}

get_variables <- function(loc_delim, text) text[loc_delim[1] + 1]

text_to_df <- function(text, ix_exp, loc_starts, loc_ends, variables) {
  tibble(vars = text[(loc_starts[ix_exp]):loc_ends[ix_exp]]) %>% 
    separate(vars, 
             str_split(variables, pattern = "\t", simplify = TRUE), sep = "\t", convert = TRUE)
}

add_meta <- function(df, ch_LU, files, text, ix_file, ix_exp, loc_delim) {
  channel <- ch_LU[[str_sub(files[ix_file], 1, 3)]]
  inFile <- str_sub(files[ix_file], 1, -5)
  cellID <- text[loc_delim[ix_exp]] # NOT ix_file
  as_tibble(cbind(inFile = inFile, channel = channel, cellID = cellID, df_10col))
}