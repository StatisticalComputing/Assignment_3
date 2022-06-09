### - Introduction - ###

# Opening the two datafiles and putting them in an matrix
table2007 <- read.table(file='subset2007.txt', header=FALSE, sep = " ")
table2008 <- read.table(file='subset2008.txt', header=FALSE, sep = " ")
matrix2007 <- as.matrix(table2007)
matrix2008 <- as.matrix(table2008)
print(matrix2007)
print(matrix2008)

### - Exercise 1 [1 point] - ###

# Since the best linear model can only be allowed to contain at most
#four predictors and there are 20 possible predictors in total.
# Hence, (20!/(19!*1!)) + (20!/(18!*2!)) + (20!/(17!*3!)) + (20!/(16!*4!)).
answer <- (factorial(20) / (factorial(19) * factorial(1))) +
(factorial(20) / (factorial(18) * factorial(2))) +
(factorial(20) / (factorial(17) * factorial(3))) +
(factorial(20) / (factorial(16) * factorial(4)))
print(answer)

### - Exercise 2 [10 point] - ###


