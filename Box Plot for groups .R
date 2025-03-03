# Load necessary libraries
library(ggplot2)
library(dplyr)

# Set working directory
setwd("/Users/zanevickery/Desktop/Van Krevelen for soil paper")

# Prompt the user to select a single CSV file manually
file_path <- file.choose()  # This will open a file dialog to choose the CSV

# Read the selected CSV file
data <- read.csv(file_path, stringsAsFactors = FALSE)


# Check if there are zeros in the denominator and remove rows where needed
data <- data %>% filter(C != 0 & N != 0 & P != 0 & S != 0 & O != 0 & H != 0)

# Calculate ratios
data$C_to_N <- data$C / data$N
data$C_to_P <- data$C / data$P
data$C_to_S <- data$C / data$S
data$O_to_C <- data$O / data$C
data$H_to_C <- data$H / data$C

# Remove rows with non-finite values (NA, NaN, Inf)
data_clean <- data %>%
  filter(is.finite(C_to_N) & is.finite(C_to_P) & is.finite(C_to_S) &
           is.finite(O_to_C) & is.finite(H_to_C))

# Check the cleaned data (first few rows)
head(data_clean)

# Create boxplots for each ratio
# C/N ratio boxplot
ggplot(data_clean, aes(x = SoilType, y = C_to_N)) +
  geom_boxplot() +
  labs(title = "C/N Ratio across Soil Types", x = "Soil Type", y = "C/N Ratio")

# C/P ratio boxplot
ggplot(data_clean, aes(x = SoilType, y = C_to_P)) +
  geom_boxplot() +
  labs(title = "C/P Ratio across Soil Types", x = "Soil Type", y = "C/P Ratio")

# C/S ratio boxplot
ggplot(data_clean, aes(x = SoilType, y = C_to_S)) +
  geom_boxplot() +
  labs(title = "C/S Ratio across Soil Types", x = "Soil Type", y = "C/S Ratio")

# O/C ratio boxplot
ggplot(data_clean, aes(x = SoilType, y = O_to_C)) +
  geom_boxplot() +
  labs(title = "O/C Ratio across Soil Types", x = "Soil Type", y = "O/C Ratio")

# H/C ratio boxplot
ggplot(data_clean, aes(x = SoilType, y = H_to_C)) +
  geom_boxplot() +
  labs(title = "H/C Ratio across Soil Types", x = "Soil Type", y = "H/C Ratio")


