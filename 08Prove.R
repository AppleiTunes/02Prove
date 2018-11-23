# Include the LIBSVM package
library(e1071)

calcRand <- function(species, trainSet, testSet, it) {
  for (i in 0:it) {
    gamma = (runif(1000, 1) / 1000)[[1]]
    cost = (sample.int(100, 1))[[1]]
    
    cat("Gamma = ", gamma, " Cost = ", cost)
    
    # Create model
    model <- svm(species, data = trainSet, kernel = "radial", gamma = gamma, cost = cost)
    
    # For prediction with testSet excluding the Speaker column
    prediction <- predict(model, testSet[-1])
    
    # Produce a confusion matrix
    confusionMatrix <- table(pred = prediction, true = testSet[,1])
    
    # Calculate the accuracy, by checking the cases that the targets agreed
    agreement <- prediction == testSet[[names(trainSet)[[1]]]]
    accuracy <- prop.table(table(agreement))
    
    # Print our results to the screen
    # print(confusionMatrix)
    print(accuracy)
  }
}

# SVM function
calc <- function(species, trainSet, testSet, gamma, cost) {
  # Create model
  model <- svm(species, data = trainSet, kernel = "radial", gamma = gamma, cost = cost)
  
  # For prediction with testSet excluding the Speaker column
  prediction <- predict(model, testSet[-1])
  
  # Produce a confusion matrix
  confusionMatrix <- table(pred = prediction, true = testSet[,1])
  
  # Calculate the accuracy, by checking the cases that the targets agreed
  agreement <- prediction == testSet[[names(trainSet)[[1]]]]
  accuracy <- prop.table(table(agreement))
  
  # Print our results to the screen
  # print(confusionMatrix)
  print(accuracy)
}



# Read in the data from the vowel file
data <- read.csv("vowel.csv", head=TRUE, sep=",")
summary(data)

# Partition the data into training and test sets
# by getting a random 30% of the rows as the testRows
index <- 1:nrow(data)
testRows <- sample(index, trunc(length(index) * 0.3))

# The test set contains all the test rows
testSet <- data[testRows,]

# The training set contains all the other rows
trainSet <- data[-testRows,]

# Excluded column
species = as.formula(paste(names(trainSet)[[1]], "~ ."))

# calc(species, trainSet, testSet, 0.001, 1)    # 0.1178451
# calc(species, trainSet, testSet, 0.001, 10)   # 0.5319865 
# calc(species, trainSet, testSet, 0.001, 100)  # 0.7676768 

# calc(species, trainSet, testSet, 0.01, 1)     # 0.5319865 
# calc(species, trainSet, testSet, 0.01, 10)    # 0.8148148
# calc(species, trainSet, testSet, 0.01, 100)   # 0.95286195 

# calc(species, trainSet, testSet, 0.1, 1)      # 0.8855219 
# calc(species, trainSet, testSet, 0.1, 10)     # 0.97979798
# calc(species, trainSet, testSet, 0.1, 100)    # 0.97979798

# calc(species, trainSet, testSet, 0.5, 1)      # 0.97306397
# calc(species, trainSet, testSet, 0.5, 10)     # 0.97306397
# calc(species, trainSet, testSet, 0.5, 100)    # 0.97306397

# calc(species, trainSet, testSet, 1, 1)        # 0.96296296
# calc(species, trainSet, testSet, 1, 10)       # 0.96296296
# calc(species, trainSet, testSet, 1, 100)      # 0.96296296

calcRand(species, trainSet, testSet, 10)

# Read in the data from the letters file
data <- read.csv("letters.csv", head=TRUE, sep=",")
summary(data)

# Partition the data into training and test sets
# by getting a random 30% of the rows as the testRows
index <- 1:nrow(data)
testRows <- sample(index, trunc(length(index) * 0.3))

# The test set contains all the test rows
testSet <- data[testRows,]

# The training set contains all the other rows
trainSet <- data[-testRows,]

# Excluded column
species = as.formula(paste(names(trainSet)[[1]], "~ ."))

# calc(species, trainSet, testSet, 0.001, 1)    # 0.7075
# calc(species, trainSet, testSet, 0.001, 10)   # 0.8285
# calc(species, trainSet, testSet, 0.001, 100)  # 0.8706667

# calc(species, trainSet, testSet, 0.01, 1)     # 0.851
# calc(species, trainSet, testSet, 0.01, 10)    # 0.92
# calc(species, trainSet, testSet, 0.01, 100)   # 0.95516667

# calc(species, trainSet, testSet, 0.1, 1)      # 0.97333333
# calc(species, trainSet, testSet, 0.1, 10)     # 0.966
# calc(species, trainSet, testSet, 0.1, 100)    # 0.96933333

# calc(species, trainSet, testSet, 0.5, 1)      # 0.9695
# calc(species, trainSet, testSet, 0.5, 10)     # 0.9475
# calc(species, trainSet, testSet, 0.5, 100)    # 0.94966667

# calc(species, trainSet, testSet, 1, 1)        # 0.9475
# calc(species, trainSet, testSet, 1, 10)       # 0.94966667
# calc(species, trainSet, testSet, 1, 100)      # 0.94966667

calcRand(species, trainSet, testSet, 10)
