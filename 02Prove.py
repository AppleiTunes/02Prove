from operator import itemgetter     # for sorting lists of lists

from sklearn import datasets
from sklearn.model_selection import train_test_split

from sklearn.neighbors import KNeighborsClassifier

# returns the distance between two points squared
def manhattan(matrix1, matrix2):
    total = 0
    for i in range(len(matrix2)):
        if (not isinstance(matrix1[i], str) and not isinstance(matrix2[i], str)):
            total += abs(matrix2[i] - matrix1[i])
    return total

class classList:
    def __init__(self, values, target):
        self.values = values                # list of values
        self.target = target                # target value

class ShaneCodedClassifier:
    def __init__(self, k):
        self.k = k
    def fit(self, data, targets):
        mappedData = []

        # load all data into list called mappedData
        for i in range(len(data)):
            mappedData.append(classList(data[i], targets[i]))
        return ShaneCodedModel(mappedData, self.k)

class ShaneCodedModel:
    def __init__(self, mappedData, k):
        self.mappedData = mappedData
        self.k = k
    def predict(self, testData):
        closestList = []
        for i in testData:
            formatedData = []

            # load all data into a list called formatedData
            # the data will be loaded into a tuple holding...
            # [0] the distance from the input to each point on mappedData and 
            # [1] the target value of the input
            for j in self.mappedData:
                formatedData.append((manhattan(i, j.values), j.target))

            # this format allows the data to be sorted easily from smallest to greatest using Python's sorted function
            # the first k values are saved into a new array called sortedList
            sortedList = sorted(formatedData, key = itemgetter(0))[0:self.k]                

            # the most common value in the tuple (at value [1]) is the answer
            closestList.append((max(set(sortedList), key = sortedList.count)[1]))

        # closestList now contains each answer
        return closestList

def displayResults(targets_predicted, targets_test):
    score = 0
    for i in range(len(targets_predicted)):
        if targets_predicted[i] == targets_test[i]:
            score += 1
    print("Accuracy: ", round(score / len(targets_predicted) * 100, 1), "%")

def custom(data, target):
    data_train, data_test, targets_train, targets_test = train_test_split(data, target, test_size = 0.3)
        
    classifier = ShaneCodedClassifier(3)
    model = classifier.fit(data_train, targets_train)
    targets_predicted = model.predict(data_test)

    displayResults(targets_predicted, targets_test)

def original(data, target):
    data_train, data_test, targets_train, targets_test = train_test_split(data, target, test_size = 0.3)

    classifier = KNeighborsClassifier(n_neighbors = 3)
    model = classifier.fit(data_train, targets_train)
    targets_predicted = model.predict(data_test)

    displayResults(targets_predicted, targets_test)

wine = datasets.load_wine()
iris = datasets.load_iris()

print("\nMy function:")
print("\twine: ", end="")
custom(wine.data, wine.target)
print("\tiris: ", end="")
custom(iris.data, iris.target)

print("\nSKlearn function:")
print("\twine: ", end="")
original(wine.data, wine.target)
print("\tiris: ", end="")
original(iris.data, iris.target)