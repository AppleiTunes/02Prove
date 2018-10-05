import numpy as np
from sklearn.model_selection import KFold
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score
from random import randint as rand

""" 
Just reading data from a file 
"""
def loadData(textFile):
    file = open(textFile)
    data = file.read()
    file.close()
    return data

""" 
The old, boring read data function that could only split files that used commas.
"""
# def readData(data):
#     dataList, targetList = [], []
#     for i in data.split("\n"):
#         split = i.split(",")
#         dataList.append(split[:-1])
#         targetList.append(split[-1])
#     return (np.array(dataList[:-1]), np.array(targetList[:-1]))

"""
My new, awesome read data function which can read data from files with any format.
"""
def readData(data):
    
    # Each word, number, or data point will be built in tempString and later added to tempList.
    tempString = ""
    
    # Everytime we find a break in the data, we add tempString to tempList and reset tempString.
    tempList = []
    
    # Each time we finish loading a specific input (after we hit \n), load tempList into a 
    # permanent list called targetList and reset tempList.
    dataList = []
    
    # The last entry in a line is probably the result we're looking for, so we add it to 
    # targetList instead of dataList.
    targetList = []
    
    # Each time we hit a quote, we know to start recording the following string as a whole instead 
    # of looking for breaks.
    record = False
    
    # Data files will annoyingly use either single quotes or double quotes at random. Luckily, 
    # they usually only use one or the other so we just look for which one they used.
    typeOfQuotes = "\"" if "\"" in data else "\'"
    
    for i in data:
        if i == typeOfQuotes:
            if record:
                record = False
            else:
                record = True
                if tempString != "":
                    tempList.append(tempString)
                    tempString = ""
        else:
            if i == "\n":
                if tempString != "":
                    targetList.append(tempString)
                    tempString = ""
                dataList.append(tempList)
                tempList = []
            else:
                if not record:
                    if i == " " or i == ",":
                        if tempString != "":                    
                            tempList.append(tempString)
                            tempString = ""
                    else:
                        tempString += i
                else:
                    tempString += i
    dataList.append(tempList)
    targetList.append(tempString)
    return (np.array(dataList), np.array(targetList))

"""
Replace missing data with a random value from the same row.
"""
def handleMissingData(data):
    for (x, y), value in np.ndenumerate(data):
        if value == "?" or value == "NA":
            while data[x][y] == "?" or data[x][y] == "NA":
                data[x][y] = data[rand(0, len(data) - 1)][y]

"""
Assign a number to each nun-numeric value.
"""
def quantifyData(data):
    stringMap = {}
    it = 0.0
    for (x, y), value in np.ndenumerate(data):
        try:
            data[x][y] = float(value)
        except:
            if not value in stringMap:
                stringMap[data[x][y]] = it
                it += 1
            data[x][y] = stringMap[value]

def classify(data, targets):
    clf = KNeighborsClassifier()
    kf = KFold(n_splits = 10)

    for train_index, test_index in kf.split(data):
        X_train, X_test = data[train_index], data[test_index]
        y_train, y_test = targets[train_index], targets[test_index]
        clf.fit(X_train, y_train)
        y_pred = clf.predict(X_test)
        print(str(round(accuracy_score(y_test, y_pred) * 100, 1)) + "% correct")

def main():
    # Three files were downloaded to test this program.
    files = ["census-data.txt", "autism.txt", "mpg.txt"]
    readFile = loadData(files[1])

    data, targets = readData(readFile)
    handleMissingData(data)
    quantifyData(data)

    classify(data, targets)

main()
