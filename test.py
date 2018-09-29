from operator import itemgetter     # for sorting lists of lists

from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import GaussianNB

def manhattan(matrix1, matrix2):
    total = 0
    for i in range(len(matrix2)):
        total += abs(matrix2[i] - matrix1[i])
    return total

class classList:
    def __init__(self, values, target):
        self.values = values
        self.target = target

class ShaneCodedClassifier:
    def fit(self, data, targets):
        mappedData = []
        for i in range(len(data)):
            mappedData.append(classList(data[i], targets[i]))
        return ShaneCodedModel(mappedData)

class ShaneCodedModel:
    def __init__(self, mappedData):
        self.mappedData = mappedData
    def predict(self, testData, k):
        closestList = []
        for i in testData:
            temp = []
            for j in self.mappedData:
                temp.append((manhattan(i, j.values), j.target))
            sortedList = sorted(temp, key = itemgetter(0))[0:k]
            closestList.append((max(set(sortedList), key = sortedList.count)[1]))

        return closestList


def main():
    iris = datasets.load_iris()
    data = iris.data                        # load data from library
    target = iris.target                    # organize data
    target_names = iris.target_names        # get target names

    data_train, data_test, targets_train, targets_test = train_test_split(data, target, test_size = 0.3)
        
    classifier = ShaneCodedClassifier()
    model = classifier.fit(data_train, targets_train)
    targets_predicted = model.predict(data_test, 20)

    score = 0
    for i in range(len(targets_predicted)):
        if targets_predicted[i] == targets_test[i]:
            score += 1
        print(target_names[targets_predicted[i]], target_names[targets_test[i]], targets_predicted[i] == targets_test[i])
    print(score / len(targets_predicted))

main()