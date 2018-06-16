#=================================================================

# Install the required packages

#

#=================================================================

 

 

Needed <- c("wordcloud", "rio","RTextTools","sentimentr","RSentiment","tm", "SnowballCC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", "cluster", "igraph", "fpc")  

install.packages(Needed, dependencies=TRUE)  

install.packages("sentimentr")

install.packages("Rcampdf", repos = "http://datacube.wu.ac.at/", type = "source") 

 

#=================================================================

# load the required packages.

#=================================================================

 

library(NLP)

library(tm)

library(rio)

library(SnowballC)

library(lsa)

 

library(rgl)

library(LSAfun)

library(RColorBrewer)

library(wordcloud)

library(SparseM)

library(RTextTools)

library(sentimentr)

library(RSentiment)

 

#=================================================================

# load the input file into a variable

#=================================================================

 

input <- read.csv(file = "C:\\KshitijBhuwanesh\\ConsumerAnalysis.csv",header=TRUE)

 

c<- file("C:\\KshitijBhuwanesh\\ConsumerAnalysis.csv")

v<-nrow(input)

 

#c<-read.csv()

 

#RSentiment::calculate_score(readLines(c,n=1))

file.create("C:\\KshitijBhuwanesh\\SentimentAnalysis.csv")

 

 

 

 

df <- data.frame(calculate_sentiment(readLines(c,n=v)))

 

 

write.table(df, file="C:\\KshitijBhuwanesh\\SentimentAnalysis.csv", sep=",", row.names=FALSE,

            col.names=FALSE, append=TRUE)

 

 

 

#=================================================================

#

# Module 1 finished. Module 2 starts

#

#=================================================================

 

 

 

#=================================================================

# Construct the path to a file from components

#=================================================================

 

cname <- file.path("C:", "data")  

cname  

dir(cname)

docs <- Corpus(DirSource(cname))

 

summary(docs)

 

inspect(docs[1])

 

#=================================================================

# Pre-processing the document.

#================================================================= 

 

docs <- tm_map(docs, tolower) 

 

docs <- tm_map(docs, removeWords, c("Â","&#39;")) 

 

docs <- tm_map(docs, stemDocument)

 

docs <- tm_map(docs, stripWhitespace) 

 

docs <- tm_map(docs,removeNumbers)

 

 

docs <- tm_map(docs, removeWords, stopwords("english"))

 

docs <- tm_map(docs, removeWords, c("the", "and","they","with","for","not","but","that"))

 

docs <- tm_map(docs, stemDocument) 

 

docs <- tm_map(docs, PlainTextDocument)

 

inspect(docs)

 

 

#=================================================================

# Create a document term matrix

#================================================================= 

 

dtm <- DocumentTermMatrix(docs)  

dtm  

#=================================================================

# transpose of this matrix

#================================================================= 

 

tdm <- TermDocumentMatrix(docs)  

tdm

 

#=================================================================

# export the matrix to Excel and Text Mining is done.

#================================================================= 

 

 

m <- as.matrix(dtm)  

dim(m)  

write.csv(m, file="C:\\KshitijBhuwanesh\\TextMiningAnalysis.csv")

 

#=================================================================

# TextMiningAnalysis.csv is the output for the above function,

# which shows the mining of all the words used

#=================================================================

 

source<-tm::VectorSource(docs)

 

t<-tm::writeCorpus(docs,path = "C:\\KshitijBhuwanesh\\corpusRep",filenames = NULL)

inspect(t)

 

freq <- colSums(as.matrix(dtm))

length(freq)

 

set.seed(142)

 

wordcloud(names(freq), freq, min.freq=50)

 

file_list = list.files("C:\KshitijBhuwanesh\corpusRep")

 

write.table(docs,file="C:\\KshitijBhuwanesh\\dtm1.csv")

 

 

#=================================================================

#The file C:\\KshitijBhuwanesh\\TextMiningAnalysis.csv contains the output for module 2.

 

#=================================================================

 

 

#=================================================================

#

# Module 2 finished. Module 3 starts

#

#=================================================================

 

k<-LSAfun::genericSummary("Having been on hold for one hour and 4 minutes now; I decided I had some time to write a review of this company. Â I have had one issue; a broken range; for the past several weeks. Â Â I have had 2 onsite tech visits so far; neither of which has resolved my issue. Â I&#39;m currently on hold to schedule a third. Â Clearly I&#39;m unimpressed with this company. Â No customer should have to be on hold for upwards of an hour to talk to a human. Â In my opinion; this demonstrates a clear lack of concern for customer service. Â However; every time I have managed to get ahold of their reps; they have been somewhat helpful. Â Now; they aren&#39;t specifically responsible for the inability for Sears techs to fix my problem. Â I&#39;ll have to write a different review about that. Â Going forward; when I purchase or sell my next house; I&#39;ll ensure the transaction does not include a warranty from this company.",2 )

 

 

###############################################

# The above Generic Summary function generates summary of the input text.

# However it could not be implemented taking input directly from the csv file as it only takes character vector.

# we could not find a way to convert the Corpus into character vector.

#The docs created in Module are lain text document, but the function is not compatible with the encoding.

# An attempt was made to encode the file into UTF-8, using the following commented code, but still the problem was not solved.

 

 

 

 

# fileName <- 'C:\\KshitijBhuwanesh\\corpusRep\\character0.txt'

# x<-readChar(fileName, file.info(fileName)$size)

# Encoding(x)

# Encoding(x) <- "UTF-8"

# x

 

 

###################################################

 

 

 

#########################################################################

 
