# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# COURSE:   DATA ANALYIS
# DATE:     SUMMER 2023
#
# TOPIC:    OPERATIONS
# 
# AUTHOR:   Dr. Maik Bieleke (maik.bieleke@uni-konstanz.de)
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Load Package ------------------------------------------------------------

library(dplyr)





# Indexing Vectors --------------------------------------------------------

#* Positive Indexing ----

# Specify example vector
x <- c("a", "b", "c", "d", "e")

# Specify the vector inside []:
x[c(3, 1)]

# Use a separate vector:
idx <- c(2, 4)
x[idx]

# Specify twice to duplicate
x[c(3, 3)]

# Example 1: colon
x[4:1]

# Example 2: seq()
x[seq(1, 5, 2)]

# Example 3: rep()
x[rep(c(1, 5), 2)]


#* Negative Indexing ----

# Compare the output to the last slide:
x[c(-3, -1)]

x[-seq(1, 5, 2)]


#* Logical Indexing ----

# Specify TRUE and FALSE manually
# in a logical vector
x[c(T, T, F, F, T)]

# Use a logical operator
x[x == "c"]

# Why did [x == "c"] work?
# Because it tests each element of c
x == "c"

# Shorter logical vectors are
# recycled to the same length.
x[c(T, F)]

# the latter is equivalent to
x[c(T, F, T, F, T)]

# Missings in the logical vector
# are reproduced in the output:
x[c(T, T, NA, F)]


#* Character Indexing ----

y <- c(l = 1, m = 2, n = 3, o = 4, p = 5)
y[c("m", "p", "p", "m")]

z <- c(abc = 1, def = 2)
z[c("a", "d")]


#* Indexing Factors ----

(f <- factor(c("a", "a", "b", "c", "c", "c")))

f[1:3]

f[1:3, drop = T]


#* Indexing Within Dimensions ----

# create and inspect a matrix
m <- matrix(letters[1:9], nrow = 3)
colnames(m) <- c("A", "B", "C"); m

# Select rows 1+3 and
# columns "B"+"A"
m[c(1, 3), c(1, 2, 3)]

# pos/neg indices can be mixed
# across different dimensions
m[c(1, 3), -1]

# blank retains everything
# e.g., rows 1+2 and all columns
m[1:2, ]


#* Indexing Across Dimensions ----

(m <- matrix(letters[1:9], nrow = 3))

m[c(2, 6)]





# Indexing Lists ----------------------------------------------------------

#* Generic Lists ----

# Example: Negative indexing
lst <- list(x = 1:5, y = "a", z = c(T, F))
lst[-1]

# Example: Character indexing
lst <- list(x = 1:5, y = "a", z = c(T, F))
lst["x"]


#* Data Frames ----

# Create a data frame
(df <- data.frame(x = 1:2, y = 2:1,
                  z = letters[1:2]))

# Matrix-like indexing
df[, c("x", "y")]

# List-like indexing
df[c("x", "z")]

# Note: When selecting a single
# column, list vs. matrix style
# produce different results.
# List-style yields a data frame
str(df["x"])

# Matrix-style yields a vector
str(df[, "x"])


#* [[ Examples ----

# Create a list
(lst <- list(a = c(1, 2, 3, 2, 1),
             b = c(2, 3, 1, 1, 2)))

# Using a single positive integer
lst[[1]]

# Using a single string
lst[["a"]]

# Result is indeed a vector
is.vector(lst[["a"]])

# Create a nested list
(lst <- list(a = list(b = 1:5),
             y = list(z = 6:10)))

# We can use a vector of names
lst[[c("a", "b")]]

# or two subsequent [[ operators
lst[["a"]][["b"]]


#* The $ operator ----

# Create a data frame
(dfr <- data.frame(x = 1:3, y = 3:1,
                   z = letters[1:3]))

# Chose column x by name
dfr$x

# ... is equivalent to
dfr[["x"]]





# Applications ------------------------------------------------------------

#* Replacing Elements ----

# Create a vector
(x <- 1:5)

# Replace elements 1 and 2
x[c(1, 2)] <- 2:3
x

# If the assignment is shorter
# it will be recycled
x[1:4] <- 1:2
x

# Duplicate indices get the
# last value assigned
x[c(1, 1)] <- 2:3
x

# Create a list
l <- list(x = 1, y = 2, z = 3)
# Remove list element "y"
l[["y"]] <- NULL
str(l)


#* Missing Value Examples ----

# Define vector x with missings
x <- c(1, 2, NA, NA, 5)

# Find missing values
is.na(x)

# Find complete cases
complete.cases(x)

# Replace missing by values
x[is.na(x)] <- 3:4
x

# Replace values with NA
x[c(3, 4)] <- NA
x

# Compute mean
mean(x)

# Compute mean again
mean(x, na.rm = TRUE)

# Determine length
length(x)

# Remove missing values
x <- na.omit(x)
str(x)



#* Select Rows ----

# Create a data frame
dfr <- data.frame(
  x = 1:3,
  y = c("a", "b", "c"))

# Index logically
dfr[dfr$x <= 2, ]
filter(dfr, x <= 2)

# Index by position
dfr[1:2, ]
slice(dfr, 1:2)


#* Order Rows ----


# Base R
dfr <- data.frame(
  x = c(5, 5, 3, 10),
  y = c("a", "b", "b", "c"))

order(dfr$x) # increasing

order(dfr$x, decreasing = TRUE) # decreasing

dfr[order(dfr$x),] # x only
dfr[order(dfr$y, -dfr$x),] # by y then -x

# dplyr
dfr <- data.frame(
  x = c(5, 5, 3, 10),
  y = c("a", "b", "b", "c"))

desc(dfr$x)

arrange(dfr, x) # by x only

arrange(dfr, y, desc(x)) # by y then -x


#* Sample Rows ----

# Create a data frame
dfr <- data.frame(
  x = 1:10,
  y = letters[1:10])

# Set seed for reproducibility
set.seed(123456)
dfr[sample(nrow(dfr), 2), ]

# Set seed for reproducibility
set.seed(12345)
sample_n(dfr, 2)


#* Select Columns ----

dfr <- data.frame(
  x = 1:2,
  y = letters[1:2],
  z = c(T, F))

# More than one column:
# returns new data frame
dfr[, c("x", "y")]

# One column: atomic vector
dfr$x

# More than one column:
# returns new data frame
select(dfr, x, y)

# One column: data frame
select(dfr, x)


#* Create Columns ----

dfr <- data.frame(
  a = 1:2, b = 3:4)

# Using the $ operator
dfr$x <- dfr$a + dfr$b
dfr

# Using with()
dfr$y <- with(dfr, a + b); dfr

# Using within()
dfr <- within(dfr, z <- a + b); dfr

dfr <- data.frame(
  a = 1:2, b = 3:4)

(dfr <- mutate(dfr, x = a + b))
(dfr <- mutate(dfr, y = a/2 + b))
(dfr <- mutate(dfr, z = a * b))


#* Renaming Columns ----

dfr <- data.frame(
  a = 1:2, b = 3:4)

# Use the name() attribute
names(dfr)[2] <- "z"
dfr

dfr <- data.frame(
  a = 1:2, b = 3:4)

dfr <- rename(dfr, z = b)
dfr


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