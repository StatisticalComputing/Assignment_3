### - Introduction - ###

# Opening the two datafiles and putting them in an matrix
gene_table2007 <- read.table(file = "subset2007.txt", header = FALSE, sep = " ")
gene_table2008 <- read.table(file = "subset2008.txt", header = FALSE, sep = " ")
vaccine_table2007 <- read.table("TITER2007_centered.txt")
vaccine_table2008 <- read.table("TITER2008_centered.txt")

# Interchanging rows and columns of outcome_2007 matrix
vaccine_table2007 <- t(vaccine_table2007)
vaccine_table2007 <- as.data.frame(vaccine_table2007)

# Changing the column names of the outcome variable
colnames(vaccine_table2008) <- "Y variable"
colnames(vaccine_table2007) <- "Y variable"

# Retrieving the 20 X variable values and the Y values of train data
train_data_2008 <- cbind(gene_table2008, vaccine_table2008)
print(train_data_2008)

# Retrieving the 20 X variabes values and the Y values of test data
test_data_2007 <- cbind(gene_table2007, vaccine_table2007)
print(test_data_2007)

### - Exercise 1 [1 point] - ###
# Since the best linear model can only be allowed to contain at most
# four predictors and there are 20 possible predictors in total.
# Hence, (20!/(19!*1!)) + (20!/(18!*2!)) + (20!/(17!*3!)) + (20!/(16!*4!)).

answer <- (factorial(20) / (factorial(19) * factorial(1))) +
(factorial(20) / (factorial(18) * factorial(2))) +
(factorial(20) / (factorial(17) * factorial(3))) +
(factorial(20) / (factorial(16) * factorial(4))) + 1
print(answer)

### - Exercise 2 [10 point] - ###

