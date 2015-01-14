platform = "linux"
rfhome = "/Users/deeksha/Library/R/3.1/R_Rulefit"
source("/Users/deeksha/Library/R/3.1/R_Rulefit/rulefit.r")
install.packages("akima", lib=rfhome)

library(gdata)
data = read.xls("Diamond_data/Diamond_Data.xls")
head(data)
plot(data$Cut, data$Price, xlab = "Cut", ylab = "Price")
hist(data$Price, col="red", xlab="Price", ylab="Distribution", labels = TRUE)
cutData = as.numeric(data$Cut)
hist(cutData, col="green", xlab="Cut", ylab="Distribution", labels = TRUE)


library(akima, lib.loc=rfhome)
indexes = sample(1:nrow(data),5000)
trainingData = data[indexes,]
testData = data[-indexes,]

#(b) Use rulefit to fit regression model
ruleFitModel = rulefit(trainingData[,1:8], trainingData[,9],rfmode = "regress",
                       cat.vars = c("Cut","Color","Clarity","Polish","Symmetry","Report"), 
                       test.reps = 10,test.fract = 0.1)

rfmodinfo(ruleFitModel)

#(c) use the rules() to view top 10 rules 
x = trainingData[,1:8]
rules(beg = 1,end = 10, x)

#(d)
varimp(range = 1:3, col = "cyan")

#(e) Error on Test Data
testPrediction = rfpred(testData[,1:8])
testActual = testData[,9]
averageAbsoluteError = 1/1000 * (sum(testActual - testPrediction))
print(abs(averageAbsoluteError))


#(f) Decision Tree 
trainingData$Cut = as.factor(trainingData$Cut)
trainingData$Color = as.factor(trainingData$Color)
trainingData$Clarity = as.factor(trainingData$Clarity)
trainingData$Polish = as.factor(trainingData$Polish)
trainingData$Symmetry = as.factor(trainingData$Symmetry)
trainingData$Report = as.factor(trainingData$Report)


library(rpart) # Recurisve Partitioning(rpart)
dTree <- rpart(Price~., method = "anova", data = trainingData, cp=0.0001)

# Finding the split with minimal xross validation error
plotcp (dTree)
treeTable = dTree$cptable
min(treeTable[,4])


# Find the complexity parameter for the best split 
cp = treeTable[which.min(treeTable[,4]),"CP"] 
prunedTree = prune(dTree,cp)


# predicion over test data 
predictPruneTree = predict(prunedTree, testData[,1:8],type = "vector")

# calculating error on the best pruned tree
averageErrorPrunedTree = 1/1000 * (sum(testActual - predictPruneTree))
print(abs(averageErrorPrunedTree))







