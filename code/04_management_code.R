# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# COURSE:   DATA ANALYIS
# DATE:     SUMMER 2023
#
# TOPIC:    MANAGEMENT
# 
# AUTHOR:   Dr. Maik Bieleke (maik.bieleke@uni-konstanz.de)
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Load Package ------------------------------------------------------------

library(dplyr)
library(tidyr)





# R Functions -------------------------------------------------------------

#* Mathematical Functions ----

abs(-4)
sqrt(25)
ceiling(3.475)
floor(3.475)
trunc(5.99)
round(3.475, 2)
signif(3.475, 2)
cos(2)
log(5, 2)
log(10)
exp(2.3026)


#* Statistical Functions ----

x <- c(1, 2, 3, 4)

mean(x)
median(x)
sd(x)
var(x)
mad(x)
quantile(x, c(.3, .7))
range(x)
sum(x)
diff(x)
min(x)
max(x)


#* Probability Functions ----

# Density for value 110
dnorm(110, mean = 100, sd = 15)

# Probability of <= 110
pnorm(110, mean = 100, sd = 15)

# Quantile for p = .75
qnorm(0.75, mean = 100, sd = 15)

# Draw 3 random numbers
rnorm(3, mean = 100, sd = 15)


#* paste() ----

# paste objects of equal length
# default separator is space.
paste("Working with R", 24,
      "hours a day.")

# longer objects are matched
# omit any separator
paste(letters[1:5], LETTERS[1:5],
      sep = "_")

# shorter objects are recycled
# use dot as separator
paste("var", 1:3, sep = ".")

# collapse to one character string
# hyphen as collapse separator
paste(c("x", "y", "z"), 1:5,
      sep = "", collapse = "-")

# without collapsing
paste(c("x", "y", "z"), 1:5,
      sep = "")


#* Working With Strings ----

# number of characters
nchar(c("a", "ab",
        "abc", "abcdef"))

# NA behavior
nchar(c("abc", NA),
      keepNA = T)

nchar(c("abc", NA),
      keepNA = F)

# lower case folding
casefold("To LoweR caSe",
         upper = F)

# upper case folding
casefold("To UppeR caSe",
         upper = T)

# Characters 2 to 4
chr <- "abcdef"
substr(chr, 2, 4)

# Replace b by B
substr(chr, 2, 2) <- "B"
chr


#* grep() and grepl() ----

# Define a vector
x <- c("abc", "acb",
       "bac", "bca",
       "cab", "cba")

# matching element positions
grep("bc", x)

# matching elements values
grep("bc", x, value = T)

# non-matching element positions
grep("bc", x, invert = T)

# non-matching element values
grep("bc", x, value = T, invert = T)

# TRUE / FALSE output with grepl()
grepl("bc", x)


#* sub() and gsub() ----

# Define a vector
x <- c("abbaABBAabba",
       "baabBAABbaab")

# Replace first occurrence
sub("bb", "##", x)

# Ignore case
sub("bb", "##", x, ignore.case = T)

# Replace all occurrences
gsub("bb", "##", x)

# Ignore case
gsub("bb", "##", x, ignore.case = T)


#* strsplit() ----

# Split at each space
strsplit("Split these words.", " ")

# Split at each character
strsplit("Characters", "")

# Split dates at hyphens
(y <- strsplit(c("1999-05-23",
                 "2001-12-30",
                 "2004-12-17"), "-"))

# Unlist the dates
(z <- unlist(y))

# Convert dates to matrix
m <- matrix(z, ncol = 3, byrow = T)

# Convert to data frame
dfr <- as.data.frame(m)
colnames(dfr) <- c("Year", "Month", "Day")
dfr


#* Custom Functions ----

# Define your own squaring function
mySquare <- function(x, round = FALSE){
  out <- x*x
  if (round) {
    return(round(out, 1))
  } else {
    return(out)
  }
}

# no rounding per default
mySquare()

# specify rounding option
mySquare(1.25, round = T)


#* apply() ----

# 3 subjects answered 5 items
# generate random Likert-scale responses
(dfr <- data.frame(
  Sbj = factor(1:3),
  I1 = sample(1:7, 3, replace = T),
  I2 = sample(1:7, 3, replace = T),
  I3 = sample(1:7, 3, replace = T),
  I4 = sample(1:7, 3, replace = T),
  I5 = sample(1:7, 3, replace = T)))

# compute the 3 row (subject) means
# note: exclude the Sbj factor variable
apply(dfr[, -1], 1, mean)

# Compute column (item) variance
# exclude the Sbj factor variable again
apply(dfr[, -1], 2, var)

# add a missing value: subject 2 did not
# answer item 3
dfr[2, 3] <- NA

# compute row means again
apply(dfr[, -1], 1, mean)

# provide additional option to ignore NA
apply(dfr[, -1], 1, mean, na.rm = T)

# when there are several solutions,
# apply() returns them as a list
apply(dfr[, -1], 1, unique)





# Conditionals & Iterations -----------------------------------------------

#* Conditionals with if and else ----

# simple if conditional
x <- -5

if (x > 0) {
  print("Positive Number")
}

# if-else conditional
if (x > 0) {
  print("Non-negative number.")
} else {
  print("Negative number.")
}

# nested if-else conditional
x <- +1

if (x > 0) {
  print("Positive number.")
} else if (x < 0) {
  print("Negative number.")
} else {
  print("Zero.")
}


#* The ifelse() Function ----

# Example 1
(x <- -1:1)

ifelse(x < 0, "negative", "non-negative")

# Example 2
(x <- c("a", "B", "c", "D"))

ifelse(x %in% letters, "lower-case", "upper-case")


#* Iterate with for and while ----

# Example 1: for() loop
# that uses the index variable
for (i in 1:5) {
  print(i)
}

# Example 2: for() loop
# that does not use the index variable
for (index in 1:3) {
  print("done")
}

# Example 3: while() loop
i <- 1
while (i <= 3) {
  print(paste("Count to ", i))
  i <- i + 1
}


#* Merging Applications ----

# Create two data frames
# with the shared key variable "id"
dfA <- data.frame(
  id = c(1, 2, 3),
  w = c(10, 8, 15),
  x = c(7, 9, 12))

dfB <- data.frame(
  id = c(1, 2, 4),
  y = c(2, 10, 11),
  z = c(5, 5, 3))

# inner join
merge(dfA, dfB)

# left join
merge(dfA, dfB, all.x = T)

# right join
merge(dfA, dfB, all.y = T)

# full join
merge(dfA, dfB, all.x = TRUE, all.y = T) # or all = T


#* Common Problems ----

# different names of the id variable
dfB <- data.frame(ID = c(1, 2, 4), z = c(5, 5, 3))
merge(dfA, dfB, all = T, 
      by.x = "id", 
      by.y = "ID")

# multiple id variables
dfA <- data.frame(id = c(1, 1, 2, 2), wave = c(1, 2, 1, 2),
                  anx = c(10, 8, 15, 16), dep = c(7, 9, 12, 11))
dfB <- data.frame(id = c(1, 1, 3, 3), wave = c(1, 2, 1, 2),
                  ang = c(2, 4, 11, 11), dis = c(5, 5, 3, 5))

merge(dfA, dfB, 
      by = c("id", "wave"), all.x = T)





# Reshape & Aggregate -----------------------------------------------------

#* Example Dataset ----

# Average baseline jump heights of CMJs and hops
dfA <- data.frame(
  id = c(1, 2, 3, 4) # subject id
  , base_cmj = c(26, 28, 35, 41) # average cmj height
  , base_hop = c(10, 7, 15, 12) # average hop height
)
# Average post-intervention jump heights of CMJs and hops
dfB <- data.frame(
  id = c(1, 2, 3, 4) # subject id
  , post_cmj = c(33, 32, 38, 45) # average cmj height
  , post_hop = c(12, 5, 10, 8) # average hop height
)
dfr <- merge(dfA, dfB); dfr


#* Reshape: pivot_longer() ----

# go from wide to long
dfr_long <- pivot_longer(
  dfr
  , cols = c(base_cmj, base_hop, post_cmj, post_hop)
  , names_to = "measure"
  , values_to = "height"
); head(dfr_long, 5)


#* Hidden Identifiers ----

# go from wide to long + tidy
dfr_long <- pivot_longer(
  dfr
  , cols = c(base_cmj, base_hop, post_cmj, post_hop)
  , names_to = c("time", "jump")
  , names_sep = "_"
  , values_to = "height"
); head(dfr_long, 5)


#* Reshape: pivot_wider() ----

# go from long to wide (create time columns)
dfr_wide <- pivot_wider(
  dfr_long
  , names_from = "time"
  , values_from = "height"
); dfr_wide


#* Reshape: New Variables ----

# compute cmj difference score in wide data frame
dfr_wide_diff <- mutate(
  dfr_wide
  , diff_post_base = post - base
); dfr_wide_diff


#* Aggregate: summarize ----

# average height difference across observations
dfr_agg <- summarize(
  dfr_wide_diff
  , mean = mean(diff_post_base)
); dfr_agg

# average height difference by jump type
dfr_agg <- summarize(
  group_by(dfr_wide_diff, jump)
  , mean = mean(diff_post_base)
); dfr_agg

# count number of observations for each participant
dfr_agg <- summarise(
  group_by(dfr_wide_diff, id)
  , mean = mean(diff_post_base)
); dfr_agg





# SESSION INFO ------------------------------------------------------------

sessionInfo()
# R version 4.1.3 (2022-03-10)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 22000)
# 
# Matrix products: default
# 
# locale:
# [1] LC_COLLATE=English_United States.1252 
# [2] LC_CTYPE=English_United States.1252   
# [3] LC_MONETARY=English_United States.1252
# [4] LC_NUMERIC=C                          
# [5] LC_TIME=English_United States.1252    
# system code page: 65001
# 
# attached base packages:
# [1] stats     graphics  grDevices
# [4] utils     datasets  methods  
# [7] base     
# 
# loaded via a namespace (and not attached):
# [1] compiler_4.1.3 tools_4.1.3
