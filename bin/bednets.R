
# load required packages --------------------------------------------------

if (!requireNamespace("pacman")) {
  install.packages("pacman")
}

pacman::p_load(dplyr)
pacman::p_load(tidyr)
pacman::p_load(mosaic)


# read in data ------------------------------------------------------------

# requires internet connection
df <- read.csv("https://raw.githubusercontent.com/sahirbhatnagar/cleandata/master/data/bednets.csv",
               stringsAsFactors = FALSE)



# Tidy data ---------------------------------------------------------------


df_t <- df %>% 
  tidyr::gather(key = "key", value = "value", -month) %>% 
  tidyr::separate(key, into = c("type","exposure"), sep = "_") %>% 
  tidyr::spread(key = "type", value = "value") %>% 
  dplyr::mutate(exposure = factor(exposure, levels = c("standard","ppftreated")))


df_t <- df_t[-which(df_t$pt==0),]



# Run poisson regression --------------------------------------------------

fit <- glm(cases ~ exposure + offset(log(pt)), 
           data = df_t, family = poisson(link = log))
summary(fit)
exp(confint(fit))
exp(coef(fit))

ggformula::df_stats(cases ~ exposure, data = df_t, sum)
ggformula::df_stats(pt ~ exposure, data = df_t, sum)
