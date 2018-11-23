# Include the LIBSVM package
library(e1071)

# Read in the data from the csv file
dataSet <- read.csv("vowel.csv", head=TRUE, sep=",")
summary(dataSet)

# Partition the data into training and test sets
# by getting a random 30% of the rows as the testRows
index <- 1:nrow(dataSet)
testRows <- sample(index, trunc(length(index) * 0.3))

# The test set contains all the test rows
testSet <- dataSet[testRows,]
summary(testSet)

# The training set contains all the other rows
trainSet <- dataSet[-testRows,]
summary(trainSet)

# SVM function
testIteration <- function(gamma, cost) {
  # Train an SVM model
  # Tell it the attribute to predict vs the attributes to use in the prediction,
  #  the training data to use, and the kernal to use, along with its hyperparameters.
  model <- svm(Speaker ~ ., data = trainSet, kernel = "radial", gamma = gamma, cost = cost)
  
  # For prediction with testSet excluding the Speaker column
  prediction <- predict(model, testSet[,-1])
  
  # Produce a confusion matrix
  confusionMatrix <- table(pred = prediction, true = testSet[,1])
  
  # Calculate the accuracy, by checking the cases that the targets agreed
  agreement <- prediction == testSet$Speaker
  accuracy <- prop.table(table(agreement))
  
  # Print our results to the screen
  # print(confusionMatrix)
  print(accuracy)
}

testIteration(0.001, 1)   # true = 0.1178451
testIteration(0.001, 10)  # true = 0.5319865 
testIteration(0.001, 100) # true = 0.7676768 
testIteration(0.01, 1)    # true = 0.5319865 
testIteration(0.01, 10)   # true = 0.8148148
testIteration(0.01, 100)  # true = 0.95286195 
testIteration(0.1, 1)     # true = 0.8855219 
testIteration(0.1, 10)    # true = 0.97979798
testIteration(0.1, 100)   # true = 0.97979798

# gamma = 0.5 returned the highest overall accuracy
testIteration(0.5, 1)     # true = 0.97306397
testIteration(0.5, 10)    # true = 0.97306397
testIteration(0.5, 100)   # true = 0.97306397

testIteration(1, 1)       # true = 0.96296296
testIteration(1, 10)      # true = 0.96296296
testIteration(1, 100)     # true = 0.96296296