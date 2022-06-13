### - Introduction - ###

# Required libraries
library(ISLR)
library(boot)

# Opening the two datafiles and putting them in an matrix
gene_table2007 <- read.table(file = "subset2007.txt", header = FALSE, sep = " ")
gene_table2008 <- read.table(file = "subset2008.txt", header = FALSE, sep = " ")
vaccine_table2007 <- read.table("TITER2007_centered.txt")
vaccine_table2008 <- read.table("TITER2008_centered.txt")

# Interchanging rows and columns of outcome_2007 matrix
vaccine_table2007 <- t(vaccine_table2007)
vaccine_table2007 <- as.data.frame(vaccine_table2007)

# Changing the column names of the outcome variable
colnames(vaccine_table2008) <- "Y"
colnames(vaccine_table2007) <- "Y"

# Retrieving the 20 X variable values and the Y values of train data
train_data_2008 <- cbind(gene_table2008, vaccine_table2008)

# Retrieving the 20 X variabes values and the Y values of test data
test_data_2007 <- cbind(gene_table2007, vaccine_table2007)

### - Exercise 1 [1 point] - ###
# Since the best linear model can only be allowed to contain at most
# four predictors and there are 20 possible predictors in total.
# Hence, (20!)/(20!*0!) + (20!/(19!*1!)) + (20!/(18!*2!)) + (20!/(17!*3!))
# + (20!/(16!*4!)).

answer <- 1 + (factorial(20) / (factorial(19) * factorial(1))) +
(factorial(20) / (factorial(18) * factorial(2))) +
(factorial(20) / (factorial(17) * factorial(3))) +
(factorial(20) / (factorial(16) * factorial(4)))
print(answer)

### - Exercise 2 [10 point] - ###

# Extracting the names of the X variables
predictors_list <- colnames(gene_table2008)

# Creating different combination of predictor variables for 1,2,3 and 4
# sets of predictor variables respectively.

one_predictors_set <- combn(predictors_list, 1)
two_predictors_set <- combn(predictors_list, 2)
three_predictors_set <- combn(predictors_list, 3)
four_predictors_set <- combn(predictors_list, 4)

# Function to create MSE for ALL the combinations of predictor variables for
# the 1-set, 2-set, 3-set and 4-set combinations.

LOOCV <- function(predictor_set, comb_number) {
    MSE <- NULL
    x_var_formula <- NULL
    predictors <- NULL
    formula_list <- NULL
    for (i in 1:(length(predictor_set)/comb_number)) { # nolint
    for (j in 1:comb_number) {
        predictor <- predictor_set[j, i]
        predictors <- c(predictors, predictor)
    }
    for (j in 1:comb_number) {
        if (j != comb_number) {
            x_var_formula <- paste(x_var_formula, predictors[j], "+")
        }
        else{
            x_var_formula <- paste(x_var_formula, predictors[j])
        }
    }
    formula <- paste("Y ~", x_var_formula)
    formula_list <- c(formula_list, formula)
    model <- glm(formula, data = train_data_2008)
    MSE[i] <- cv.glm(train_data_2008, model)$delta[1]
    predictors <- NULL
    formula <- NULL
    x_var_formula <- NULL
}
min_MSE <- min(MSE)
min_MSE_index <- match(min_MSE, MSE)
best_model <- formula_list[min_MSE_index]

result <- c(min_MSE, best_model)
return(result)
}

MSE_1 <- LOOCV(one_predictors_set, 1)
MSE_2 <- LOOCV(two_predictors_set, 2)
MSE_3 <- LOOCV(three_predictors_set, 3)
MSE_4 <- LOOCV(four_predictors_set, 4)

# Displaying the best regression models along with the CV error
print(MSE_1)
print(MSE_2)
print(MSE_3)
print(MSE_4)

# Displaying the histogram for the CV errors for all the models
MSE_list = c(MSE_1, MSE_2, MSE_3, MSE_4)
print(MSE_list)

hist(MSE_list, main = 'CV error histogram', xlab = 'CV errors',  # nolint
ylim = c(0, 2000), col = '#5d995d', border = 'black') # nolint

# Fitting the best model on the training data.
formula <- "Y ~ V10 + V13 + V17"
model <- lm(formula, data = train_data_2008)
summar <- summary(model)
coeff <- summar$coefficients[, 1]
print(coeff)
