detach(package:tm, unload=TRUE)
library(arules)
#(a)
baskets = read.transactions("R/ratingsAsBasket.txt", 
                            format = "basket", sep = NULL)
summary(baskets)

#(b) use apriori()
rules = apriori(baskets, parameter = list(supp = 0.1, conf = 0.8))

# show top 10 rules 
inspect(head(sort(rules, by = "lift"),10))

#(c) List all rules with lift > 3.0
inspect (subset(rules, subset = lift >3.0 ))
