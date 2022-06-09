table2007 <- read.table(file='subset2007.txt', header=FALSE, sep = " ")
table2008 <- read.table(file='subset2008.txt', header=FALSE, sep = " ")
matrix2007 <- as.matrix(table2007)
matrix2008 <- as.matrix(table2008)
print(matrix2007)
print(matrix2008)

# yhat <- matrix(c(1, matrix2008, nrow = 1) %*% matrix(fit$coefficients, ncol = 1)