
# load required packages --------------------------------------------------

if (!requireNamespace("pacman")) {
  install.packages("pacman")
}

pacman::p_load(dplyr)
pacman::p_load(tidyr)


# read in data ------------------------------------------------------------

# requires internet connection
df <- read.csv("https://raw.githubusercontent.com/sahirbhatnagar/cleandata/master/data/bednets.csv",
               stringsAsFactors = FALSE)
head(df)
str(df)
