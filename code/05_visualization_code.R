# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# COURSE:   DATA ANALYIS
# DATE:     SUMMER 2022
#
# TOPIC:    VISUALIZATION
# 
# AUTHOR:   Dr. Maik Bieleke (maik.bieleke@uni-konstanz.de)
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Load Package ------------------------------------------------------------

library(ggplot2)






# Grammar -----------------------------------------------------------------

#* Plot Setup with ggplot() ----

(p <- ggplot(data = mpg, aes(x = displ, y = hwy)))


#* Add Data with geom_* ----

# add points as geometric objects
p + geom_point()


#* Define Aesthetics with aes() ----

# use color for car class as aesthetic
p <- ggplot(mpg, aes(displ, hwy, color = class))
p + geom_point()


#* Combining Layers ----

# add layer with a smoothed line (linear) without standard errors
p <- ggplot(data = mpg, aes(displ, hwy))
p + 
  geom_point() + 
  geom_smooth(method = "lm", se = F)


#* Global & Local Aesthetics ----

# global mapping: for all layers
p <- ggplot(data = mpg, aes(displ, hwy,
                            color = drv))

p + geom_point() + geom_smooth(method = "lm")

# local mapping: only selected layer
p <- ggplot(data = mpg, aes(displ, hwy))

p + geom_point(aes(color = drv)) + geom_smooth()


#* Grouping ----

# one line connects all observations
ggplot(nlme::Oxboys, aes(age, height)) +
  geom_point() + geom_line()

# group maps one line per subject
ggplot(nlme::Oxboys, aes(age, height,
                         group = Subject)) +
  geom_point() + geom_line()








# Geoms -------------------------------------------------------------------


#* Boxplots and Violin Plots ----

# boxplot: factorial x variable
p <- ggplot(data = mpg, aes(drv, hwy))
p + geom_boxplot()

# continuous x variable with cut_width()
p <- ggplot(data = mpg, aes(cty, hwy))
p + geom_boxplot(aes(group =
                       cut_width(cty, 10)))

# violin plot: factorial x-variable
p <- ggplot(data = mpg, aes(drv, hwy))
p + geom_violin()

# continuous x variable with cut_width()
p <- ggplot(data = mpg, aes(cty, hwy))
p + geom_violin(aes(group =
                      cut_width(cty, 10)))


#* Histograms and Frequency Polygons ----

# histogram with default bin width
p <- ggplot(data = mpg, aes(hwy))
p + geom_histogram()

# bin width of .5
p + geom_histogram(binwidth = .5)

# frequency plot with default bin width
p + geom_freqpoly()

# bin width of .5
p + geom_freqpoly(binwidth = .5)


#* Comparing Distributions ----

# comparing distributions: frequency plot
ggplot(mpg, aes(displ, colour = drv)) +
  geom_freqpoly(binwidth = 0.5)

# comparing distributions: density plot
ggplot(mpg, aes(displ, fill = drv)) +
  geom_density(alpha = 0.2)


#* Barplots ----

# simple barplot
p <- ggplot(data = mpg,
            aes(manufacturer))
p + geom_bar()

# stacked barplot
p <- ggplot(data = mpg,
            aes(manufacturer))
p + geom_bar(aes(fill = drv))


#* Example: A Complex Plot ----

# Values for x, y, and z and standard error (se) of y
dfr <- data.frame(
  x = c(0.5, 1.0, 2.0, 0.5, 1.0, 2.0),
  y = c(13.23, 22.70, 26.06, 7.98, 16.77, 26.14),
  y_se = c(1.41, 1.24, 0.84, 0.87, 0.80, 1.52),
  z = c("a", "a", "a", "b", "b", "b"))

# Example: Line Graph
pd <- position_dodge(0.2)

(p1 <- ggplot(dfr, aes(x, y, color = z)) +
    geom_point(position = pd) +
    geom_line(position = pd) +
    geom_errorbar(aes(ymin = y - y_se,
                      ymax = y + y_se),
                  position = pd, width = .1))

# Example: Bar Graph
(p2 <- ggplot(dfr, aes(factor(x), y, fill = z)) +
    geom_bar(position = position_dodge(),
             stat="identity") +
    geom_errorbar(aes(ymin = y - y_se,
                      ymax = y + y_se),
                  width = .2,
                  position = position_dodge(0.9)))






# Overplotting ------------------------------------------------------------

# Subset the mpg data frame with dplyr::filter
mpg2 <- filter(mpg, cyl != 5 & drv %in% c("4", "f") & class != "2seater")


#* facet_wrap() ----

# create basic plot
p <- ggplot(mpg2, aes(displ, hwy))

# top left: wrap into three columns
# highest values are bottom right
p + facet_wrap(~ class, ncol = 3)

# top right: wrap into three columns
# highest values are top right
p + facet_wrap(~ class, ncol = 3,
               as.table = F)

# bottom left: wrap into three rows
p + facet_wrap(~ class, nrow = 3)

# bottom right: change wrap direction
p + facet_wrap(~ class, ncol = 3,
               dir = "v")


#* facet_grid() ----

# create basic plot
p <- ggplot(mpg2, aes(displ, hwy))

# spread the values of cyl across columns
p + facet_grid(. ~ cyl)

# spread the values of drv across rows
p + facet_grid(drv ~ .)

# spread the values of cyl across columns
# and the values of drv across rows
p + facet_grid(drv ~ cyl)






# Scales, Axes, and Legends -----------------------------------------------

#* Overview ----

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class))

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  scale_x_continuous() + # displ is scaled to a continuous x-axis
  scale_y_continuous() + # hwy is scaled to a continuous y-axis
  scale_colour_discrete() # class is scaled to a discrete color


#* Scales ----

# This command:
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_continuous("Label 1") +
  scale_x_continuous("Label 2")

# is equivalent to:
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_continuous("Label 2")


#* Example: Labeling Axes ----

# Define a plot object p
p <- ggplot(mpg, aes(displ, hwy)) + geom_point(aes(color = class))

# setting name for each scale
p +
  scale_x_continuous(name = "x axis") +
  scale_y_continuous(name = "y axis") +
  scale_color_discrete(name = "legend")

# naming with the helper function labs()
p +
  labs(x = "x axis",
       y = "y axis",
       color = "legend")





# Themes ------------------------------------------------------------------

#* Example ----

# very basic plot
(p1 <- ggplot(mpg, aes(cty, hwy)) +
   geom_jitter(aes(color = factor(cyl))) +
   geom_abline())

# advanced plot
(p2 <- p1 + labs(
  x = "City mileage/gallon",
  y = "Highway mileage/gallon",
  color = "Cylinders",
  title = "Highway and city mileage are highly correlated"))

# highly customized plot
(p3 <- p2 + theme_bw() + theme(
  plot.title = element_text(face = "bold", size = 12),
  legend.background = element_rect(fill = NA, color = NA),
  legend.justification = c(0, 1),
  legend.position = c(0.02, .98),
  axis.ticks = element_line(color = "gray70", size = .2),
  panel.grid.major = element_line(color = "gray70", size = .2),
  panel.grid.minor = element_blank()))





# Export ------------------------------------------------------------------

#* Overview ----

# Save a plot as .jpg without specifying size
ggsave("examplePlot.jpg")

# Save a plot as 12x5 inch .eps file
ggsave("examplePlot.eps", width = 12, height = 5)







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
