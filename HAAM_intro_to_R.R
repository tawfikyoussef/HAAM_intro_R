############################################################
# HAAM Summer School – Introduction to R 
############################################################

############################################################
# 1. Getting started with R
############################################################

2 + 2
10 / 2
sqrt(25)

x <- 10
x
x + 5

numbers <- c(1, 2, 3, 4, 5)
numbers

mean(numbers)
sd(numbers)
length(numbers)

# Exercise 1 example
ages <- c(18, 21, 25, 30, 34)
mean(ages)

############################################################
# 2. Working with a data frame
############################################################

data(iris)

head(iris)
str(iris)
summary(iris)
dim(iris)
colnames(iris)

unique(iris$Species)

iris$Petal.Length

iris[1:5, ]
iris[iris$Species == "setosa", ]
iris[iris$Petal.Length > 5, ]
iris[, c("Species", "Petal.Length", "Petal.Width")]

# Exercise 2 example
iris[iris$Species == "versicolor", ]
iris[, c("Sepal.Length", "Petal.Length", "Species")]

############################################################
# 3. Data manipulation with tidyverse
############################################################

library(tidyverse)

iris_df <- iris

iris_df %>%
  head()

iris_df %>%
  dplyr::filter(Species == "setosa")

iris_df %>%
  dplyr::filter(Petal.Length > 5)

iris_df %>%
  dplyr::select(Species, Petal.Length, Petal.Width)

iris_df %>%
  dplyr::mutate(
    Petal.Ratio = Petal.Length / Petal.Width
  )

iris_df %>%
  dplyr::group_by(Species) %>%
  dplyr::summarise(
    mean_petal_length = mean(Petal.Length),
    mean_petal_width = mean(Petal.Width),
    n = dplyr::n()
  )

# Exercise 3 example
iris_df %>%
  dplyr::group_by(Species) %>%
  dplyr::summarise(
    mean_sepal_length = mean(Sepal.Length),
    mean_petal_length = mean(Petal.Length)
  )

############################################################
# 4. Plotting with ggplot2
############################################################

ggplot(data = iris_df, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point()

ggplot(data = iris_df, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point()

ggplot(data = iris_df, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point(size = 3, alpha = 0.8) +
  labs(
    title = "Petal measurements in iris species",
    x = "Petal length",
    y = "Petal width",
    color = "Species"
  ) +
  theme_bw()

ggplot(data = iris_df, aes(x = Species, y = Petal.Length, fill = Species)) +
  geom_boxplot() +
  labs(
    title = "Petal length differs between iris species",
    x = "Species",
    y = "Petal length"
  ) +
  theme_bw()

iris_df %>%
  dplyr::filter(Species != "setosa") %>%
  ggplot(aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point(size = 3) +
  theme_bw()

# Exercise 4 example
ggplot(data = iris_df, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 3) +
  labs(
    x = "Sepal length",
    y = "Sepal width",
    color = "Species"
  ) +
  theme_bw()

############################################################
# 5. Saving a plot
############################################################

p <- ggplot(data = iris_df, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point(size = 3, alpha = 0.8) +
  labs(
    title = "Petal measurements in iris species",
    x = "Petal length",
    y = "Petal width",
    color = "Species"
  ) +
  theme_bw()

p

ggsave("iris_petal_plot.png", p, width = 6, height = 4, dpi = 300)

############################################################
# 6. Final challenge example
############################################################

iris_df2 <- iris_df %>%
  dplyr::filter(Species != "setosa") %>%
  dplyr::mutate(
    Petal.Ratio = Petal.Length / Petal.Width
  )

iris_df2 %>%
  dplyr::group_by(Species) %>%
  dplyr::summarise(
    mean_petal_ratio = mean(Petal.Ratio)
  )

ggplot(iris_df2, aes(x = Species, y = Petal.Ratio, fill = Species)) +
  geom_boxplot() +
  labs(
    x = "Species",
    y = "Petal length / petal width"
  ) +
  theme_bw()
