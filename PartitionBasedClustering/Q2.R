
data = read.table("az-5000.txt",header = TRUE)
letterData = data[,2:19]
## Applying kmeans to the data set without first column
clusters = kmeans(letterData,26)

## Finding withinss for the initial number of 26 clusters
clusters$withinss

## Finding average withinss
sum = 0
for( i in 1:26)
{
  sum = sum + clusters$withinss[i]
}
avgWithinss = 1/26 * sum
print(avgWithinss)


#(a) Repeating kmeans for k = 2..26
averageWithinssVector = c(length(25))
for(i in 2:26)
{
  averageWithinssVector[i-1] = 1/i * sum(kmeans(letterData,i)$withinss)
}
averageWithinssVector




#(b) Plot goodness of fit for all K and K = 15..26
plot(c(2:26),averageWithinssVector,ylab = "goodness of fit", xlab = "K",type = "l",col ="red")

plot(c(15:26), averageWithinssVector[14:25],ylab = "goodness of fit", xlab = "K",type ="l", col = "green")


