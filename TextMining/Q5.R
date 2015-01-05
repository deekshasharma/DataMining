library(tm)
#(a) Use DirSource and Corpus to load the data in R
pathToData = "/Users/deeksha/Box Sync/COEN281/HomeWork Assignment/HW4/R/Newsgroup_data"
newsCorpus = Corpus(DirSource(pathToData, recursive = TRUE), 
                    readerControl = list(reader = readPlain))

# Length of news corpus
length(newsCorpus)
# print the corpus entry for rec.autos/103806
newsCorpus[["103806"]]

# (b) Pre-processsing the corpus data
newsCorpus = tm_map(newsCorpus,removePunctuation)
newsCorpus[["103806"]]

newsCorpus = tm_map(newsCorpus,removeNumbers)
newsCorpus[["103806"]]

newsCorpus = tm_map(newsCorpus, content_transformer(tolower))
newsCorpus[["103806"]]

newsCorpus = tm_map(newsCorpus, removeWords, stopwords("english"))
newsCorpus[["103806"]]

newsCorpus = tm_map(newsCorpus, stripWhitespace)
newsCorpus[["103806"]]

# Corpus elements to plain text
newsCorpus = Corpus(VectorSource(newsCorpus))

#(c) Create Document Term matrix with TFIDF weights

docTermMatrix = DocumentTermMatrix(newsCorpus, 
                                   control = list(weighting = weightTfIdf, 
                                                  minWordLength = 1,
                                                  minDocFreq = 1))                                                  
                                                  


# Dimensions of resulting matrix
dim(docTermMatrix)

#inspect DocumentTermMatrix
#docNumber = which(names(newsCorpus) == "103806")
inspect(docTermMatrix[docNumber, "bmw"])
inspect(docTermMatrix[docNumber, "clutch"])
inspect(docTermMatrix[docNumber, "mother"])






