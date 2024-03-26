# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# COURSE:   DATA ANALYIS
# DATE:     SUMMER 2023
#
# TOPIC:    STATISTICS
# 
# AUTHOR:   Dr. Maik Bieleke (maik.bieleke@uni-konstanz.de)
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Load Package ------------------------------------------------------------

library(rio)
library(effsize)
library(tidyverse)
library(easystats)
library(afex)
library(emmeans)

dfr <- import("players_22.csv")




# t-tests -----------------------------------------------------------------

#* Single Sample t-Test ----

# Single sample t-test
t.test(dfr$overall)


#* Paired and Unpaired t-Test ----

# Paired t-test
t.test(dfr$overall, dfr$potential, paired = T)


#* Function Notation ----

# Independent t-test in function notation
t.test(dfr$overall ~ dfr$preferred_foot)


#* Effect Size ----

# compute cohen's d as effect size measure
cohen.d(dfr$overall ~ dfr$preferred_foot, 
        data = dfr)









# Correlation -------------------------------------------------------------


#* The correlation() Function ----

# select variables
d <- select(dfr, age, height_cm, weight_kg,
            overall, value_eur, international_reputation)

# compute correlations
r <- correlation(d, p_adjust = "bonferroni"); r


#* Matrix Output ----

# summarize correlations
s <- summary(r); s


#* Plotting the Matrix ----

plot(s, show_data = "points") +
  theme_bw()


#* Partial Correlations ----

r <- correlation(d, partial = T); r











# Categorical Data --------------------------------------------------------

#* Contingency Tables ----

# create contingency table
tbl <- table(dfr$preferred_foot,
             dfr$international_reputation); tbl

# compute margins column-wise as percentages
prop.table(tbl, 2)
round(prop.table(tbl, 2) * 100, 2)


#* Statistical Inference: One Variable ----

# create contingency table with one variable
tbl <- table(factor(dfr$preferred_foot))

# compute binomial test
binom.test(tbl)

# compute chi-squared test
chisq.test(tbl)


#* Statistical Inference: Two Variables ----

# create contingency table with two variables
tbl <- table(dfr$preferred_foot, 
             dfr$international_reputation)

# compute fisher test
fisher.test(tbl)

# compute chi-squared test
chisq.test(tbl)










# Regression --------------------------------------------------------------

#* Simple Regression ----

# estimate regression model with a single predictor
m1 <- lm(wage_eur ~ overall, data = dfr)

# get summary information about the result
summary(m1)


#* Using ggplot2 to Plot the Regression ----

# plot the data with a regression line
ggplot(dfr, aes(overall, wage_eur)) + 
  geom_point() + 
  geom_smooth(method = "lm")

# compute performance parameters
model_performance(m1)


#* Check Model Assumptions ----

# check model assumptions
check_model(m1)


#* Multiple Regression ----

# estimate a multiple regression model and get summary of the results
m2 <- lm(wage_eur ~ overall + international_reputation, data = dfr)
summary(m2)


#* Summary of Model Parameters ----

# print model parameters
model_parameters(m2)

# print standardized model parameters
model_parameters(m2, standardize = "refit")


#* Comparing Models ----

# estimate a third model
m3 <- lm(wage_eur ~ overall + international_reputation +
           preferred_foot, data = dfr)

# compare performance of all three models and rank by model fit
compare_performance(m1, m2, m3, rank = TRUE)







# ANOVA -------------------------------------------------------------------

#* One-Factorial ANOVA ----

# compute a one-factorial ANOVA
(m <- aov_4(wage_eur ~ work_rate + (1|sofifa_id), 
            data = dfr))


#* Estimated Marginal Means ----

# compute estimated marginal means
(emm <- emmeans(m, ~ work_rate))

# get pairwise post-hoc comparisons with holm adjustment
# (output is truncated)
contrast(emm, "pairwise", adjust = "holm")


#* ANCOVA ----

# compute an ANCOVA
(m <- aov_4(wage_eur ~ work_rate +
              international_reputation + (1|sofifa_id), data = dfr))


#* Estimated Marginal Means ----

# compute estimated marginal means adjusted by the covariate
(emm <- emmeans(m, ~ work_rate))


#* Plotting Adjusted Means ----

# plot the estimated marginal means
ggplot(as.data.frame(emm), aes(work_rate, emmean)) +
  geom_errorbar(aes(ymin = emmean - SE,
                    ymax = emmean + SE), width = .2) +
  geom_point() +
  geom_line(aes(as.numeric(work_rate), emmean))


#* Two-Factorial ANOVA ----

# compute a two-factorial ANOVA
(m <- aov_4(overall ~ work_rate * preferred_foot +
              (1|sofifa_id), data = dfr))


#* Estimated Marginal Means ----

# get estimated marginal means for all factor level combinations
(emm <- emmeans(m, ~ work_rate * preferred_foot))


#* Simple Effects ----

# simple main effects of work_rate
joint_tests(emm, by = "preferred_foot")


#* Pairwise Post Hoc Tests ----

# pairwise post hoc tests (truncated output)
contrast(emm, "pairwise")


#* Mixed ANOVA ----

df15 <- import("players_15.csv")[, c("sofifa_id", "overall")]
df16 <- import("players_16.csv")[, c("sofifa_id", "overall")]
df17 <- import("players_17.csv")[, c("sofifa_id", "overall")]
df18 <- import("players_18.csv")[, c("sofifa_id", "overall")]
df19 <- import("players_19.csv")[, c("sofifa_id", "overall")]
df20 <- import("players_20.csv")[, c("sofifa_id", "overall")]
df21 <- import("players_21.csv")[, c("sofifa_id", "overall")]
df22 <- import("players_22.csv")[, c("sofifa_id", "overall")]

df15$year <- 2015
df16$year <- 2016
df17$year <- 2017
df18$year <- 2018
df19$year <- 2019
df20$year <- 2020
df21$year <- 2021
df22$year <- 2022

drm <- bind_rows(df22, df21)
drm <- bind_rows(drm, df20)
drm <- bind_rows(drm, df19)
drm <- bind_rows(drm, df18)
drm <- bind_rows(drm, df17)
drm <- bind_rows(drm, df16)
drm <- bind_rows(drm, df15)

# keep only players who are in all data sets
drm <- drm[drm$sofifa_id %in% names(table(drm$sofifa_id)[table(drm$sofifa_id) == 8]),]

# add club position in 2022
drm <- merge(drm, dfr[, c("sofifa_id", "club_position")])


# compute mixed-factorial ANOVA (see code for information about drm)
(m <- aov_4(overall ~ club_position + year + (1 + year|sofifa_id), data = drm))


#* Mixed ANOVA ----

# plot overall attribute by year, coloring by position
ggplot(drm, aes(factor(year), overall, color = club_position)) +
  geom_boxplot()


#* Estimated Marginal Means ----

# compute estimated marginal means
(emm <- emmeans(m, ~ year * club_position))


#* Simple Effects ----

# compute the simple effect of year
joint_tests(emm, by = "year")


#* Pairwise Post Hoc Tests ----

# compute pairwise contrasts
contrast(emm, "pairwise")











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
