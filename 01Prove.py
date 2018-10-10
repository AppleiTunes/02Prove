from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import GaussianNB

iris = datasets.load_iris()
data = iris.data
target = iris.target
target_names = iris.target_names

data_train, data_test, targets_train, targets_test = train_test_split(data, target, test_size = 0.3, shuffle=True)


""" Built classifier """

classifier = GaussianNB()
model = classifier.fit(data_train, targets_train)
targets_predicted = model.predict(data_test)

score = 0
for i in range(len(targets_predicted)):
    if targets_predicted[i] == targets_test[i]:
        score += 1
print(round(score / len(targets_predicted) * 100, 1), "%")


""" Custom classifier """

class HardCodedClassifier:
    def fit(self, data, targets):
        return HardCodedModel(data, targets)

class HardCodedModel:
    def __init__(self, data, targets):
        self.data = data
        self.targets = targets
    def predict(self, data):
        tempList = []
        for i in data:
            tempList.append(0)
        return tempList

classifier = HardCodedClassifier()
model = classifier.fit(data_train, targets_train)
targets_predicted = model.predict(data_test)

score = 0
for i in range(len(targets_predicted)):
    if targets_predicted[i] == targets_test[i]:
        score += 1
print(round(score / len(targets_predicted) * 100, 1), "%")

# print(target_names[targets_predicted[0]])
# print name
