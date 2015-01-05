
# load this data into R for a-z5000.txt
fileContents = read.table("/Users/deeksha/az-5000.txt", header = TRUE,sep ="")
head(fileContents, n = 1)
tail(fileContents, n = 1)
dim(fileContents)

# Randomly select 80% of the data for training and 20% for Test
indexes = sample(1:nrow(fileContents), size = 0.8 * nrow(fileContents), replace = FALSE)
trainingData = fileContents[indexes,]
dim(trainingData)
testData = fileContents[-indexes,]
dim(testData)
classLabel = trainingData[, 1]
freqEachClass = table(classLabel)
print(freqEachClass)

#create a vector of prior probabilities equal to 1/26 for each class.

probability = c(rep(1/26, 26))
print (probability)

#Running LDA
library(MASS)
fit = lda(char~.,trainingData, prior = probability)
predictTestResult = predict(fit, testData[,c(2:19)])$class
testMatrix = table(estimate = predictTestResult, truth = testData[,1])
print(testMatrix)

correctResultEachChar = diag(testMatrix)
totalEachChar = colSums(testMatrix)
rankEachChar = correctResultEachChar/totalEachChar
print(rankEachChar)
max(rankEachChar)
min(rankEachChar)

#replace diagnol elements with 0
diag(testMatrix) <- 0
print (testMatrix)

# Visualize confusion matrix for test
image(testMatrix col = terrain.colors(6))
xLabel = letters
yLabel = letters
label = 1:26
diff = label/26
axis(1, diff, labels = letters)
axis(2, diff, labels = letters)

















