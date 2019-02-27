
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
head(df)
str(df)

ggformula::gf


ds <- read.csv("https://raw.githubusercontent.com/sahirbhatnagar/cleandata/master/data/hiv_transmission.csv",
            header=TRUE)
ds$n.hivneg= ds$n.pairs - ds$n.hivpos
str(ds)

ds %>% gather(key = "type",value="count",-caesarian,-m.advancedHIV, -n.periods.ART) %>% 
  spread(caesarian, count)

# ds$ART1or2 <- ifelse(ds$m.trimesters.tx==1.5, 1, 0)
# ds$ART3 <- ifelse(ds$m.trimesters.tx==3, 1, 0)
# ds$m.trimesters.tx <- NULL
# head(ds)
# write.table(ds, file = "hiv_Transmission.csv", quote = FALSE, row.names = FALSE, 
#             sep = ",")

ds$propn = round(ds$n.hivpos/ds$n.pairs,3)

#overall proportion hiv positive

round(sum(ds$n.hivpos)/sum(ds$n.pairs),3)

# intercept-only logit model

# devtools::install_github('droglenc/NCStats')
library(NCStats)

fit0=glm(cbind(n.hivpos,ds$n.hivneg) ~ 1,
         family=binomial, data=ds)
summary(fit0)