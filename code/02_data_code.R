# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# COURSE:   DATA ANALYIS
# DATE:     SUMMER 2023
# 
# AUTHOR:   Dr. Maik Bieleke (maik.bieleke@uni-konstanz.de)
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



# VECTORS -----------------------------------------------------------------

#* Characterization ------------------------------ 

# create vector of type double with the combine function c()
vdouble <- c(-0.1, 2.7)

# determine length of vdouble with length()
length(vdouble)

# determine type of vdouble with typeof()
typeof(vdouble)


#* Combining Vectors ----

# create input vectors
a <- c(-0.1, 2.7)
b <- c(5.0, -3.3)

# create new vector ab
ab <- c(a, b)

# return vector ab
ab

# check length of ab
length(ab)

# check type of ab
typeof(ab)


#* Regular Sequences ----

# colon operator (:)
1:10
2.5:-3

# seq() function
seq(-1, 1, by = .5)
seq(0, 1, length.out = 3)

# rep() function
rep(1:5, each = 2)
rep(c("a", "b"), each = 2)

# letters and LETTERS
letters
LETTERS

#* Changing Types by Coercion ----

# combine logic and double
lognum <- c(TRUE, 1.5)

# return lognum
lognum

# check type
typeof(lognum)


#* Changing Types by Functions ----

# create logical vector
vlogi <- c(FALSE, FALSE, TRUE)

# use the addition operator (+)
vlogi + 1


#* Changing Types Manually ----

# create double vector
vdouble <- c(-0.1, 2.7)

# change type to character
as.character(vdouble)





# FACTORS -----------------------------------------------------------------

#* Attributes ----

# # create vector and request names
x <- 1:3
names(x)

# # assign and request names
names(x) <- c("a", "b", "c")
names(x)

# print named vector
x


#* Factor Attributes ----

# convert vector to factor
vchar <- c("a", "b", "b", "a")
vfact <- factor(vchar); vfact

# show factor class
class(vfact)

# show vector levels
levels(vfact)





# MATRICES & ARRAYS -------------------------------------------------------

#* Dimension Attribute ----

# Set an attribute with dim()
x <- 1:6
dim(x) <- c(3, 2)
x

y <- 1:12
dim(y) <- c(2, 3, 2)
y

# Use matrix() and array()
(x <- matrix(1:6, nrow = 3, ncol = 2))
(y <- array(1:12, c(2, 3, 2)))


#* Additional Attributes ----

# Matrix
x <- matrix(1:6, 3, 2)

length(x); dim(x)

nrow(x); ncol(x)

colnames(x); rownames(x)

rownames(x) <- c("R1", "R2", "R3")
colnames(x) <- c("C1", "C2")
x

colnames(x); rownames(x)

# Array
x <- array(1:12, c(2, 3, 2))

length(x); dim(x)

dimnames(x) <- list(
  c("D1.1", "D1.2"), c("D2.1", "D2.2", "D2.3"),
  c("D3.1", "D3.2")); x

dimnames(x)





# LISTS -------------------------------------------------------------------

#* Overview ----

(x <- list(1:3, 
           "a", 
           c(TRUE, FALSE, TRUE),
           c(2.3, 5.9)))


#* Inspecting Structure ----

str(x)


#* List and Vector Coercion ----

# Combination with c()
y <- c(list(1, 2), c(3, 4))
str(y)

# Combination with list()
x <- list(list(1, 2), c(3, 4))
str(x)


#* Working with Lists ----

# Create a list vector
x <- list(1:2, "a", TRUE, 2.3)

# Assess type
typeof(x)
length(x)

# Coerce vector to list
y <- as.list(c(1, 2, 3))
str(y)

# Coerce list to vector
unlist(x)





# DATA FRAMES -------------------------------------------------------------

#* Creating Data Frames ----

# Define the data frame
(df <- data.frame(
  x = 1:2, 
  y = c("y", "z"), 
  z = c(TRUE, FALSE)))

# Examine its structure
str(df)

# Suppress the conversion of character vectors to factors
df <- data.frame(x = 1:2, y = c("y", "z"), z = c(T, F),
                 stringsAsFactors = F); str(df)


#* Attributes of Data Frames ----
typeof(df)
class(df)





# FUNCTIONS ---------------------------------------------------------------

#* Example ----

# no input, only defaults
seq()

# input by name
seq(from = 1, to = 10, by = 2)
seq(by = 2, to = 10, from = 1)

# input by position
seq(1, 10, 2)
seq(2, 10, 1)

# mixture
seq(by = 2, 1, 10)

# abbreviations
seq(b = 2, t = 10, f = 1)


# IMPORT & EXPORT ---------------------------------------------------------

# Import and assign data
data <- import("forbes.csv")

# Examine the structure of the data frame
str(data)

# Export data
export(data, "forbes.xlsx")


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
