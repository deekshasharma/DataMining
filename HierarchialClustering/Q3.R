
data = read.table("az-5000.txt",header = TRUE)
letterData = data[,2:19]
## Applying kmeans to the data set without character column
clusters = kmeans(letterData,26)

## Finding the centers
clusters$centers

#(a) Show the dendogram
distance= dist(clusters$centers, method = "euclidean")
dendogram = (hclust(distance, method = "average"))
plot(dendogram)


#(b) Assign letter labels and create the 26 x 26 matrix

letterMatrix = table(data[,1],clusters$cluster)
commonLetters = c(length(25))
for(i in 1:26)
{
  commonLetters[i] = which.max(matrix1[,i])
}
plot(dendogram,labels = letters[commonLetters])


 



