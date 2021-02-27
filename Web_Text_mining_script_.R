####Text mining Hands on####

####setting directory###

setwd("C:\\Users\\JANE ODUM\\Desktop\\Lab\\Text-mining")


###load library
library(NLP)
library(tm)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)

###load text from URL
filePath = "https://acadgild.com/artificial-intelligence.txt"


text_file = readLines(filePath) ##read all lines in the filePath and store it in text_file

head(text_file) ####texts are on diff lines


text_file1 = paste(text_file, collapse = " ") 
####This chunks the data together into a single column. It starts and ends with "double quotes" due to collapse = " "

head(text_file1)



####store in a  coorpus###
corpus = VCorpus(VectorSource(text_file1))

corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removeNumbers)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords("english"))
corpus = tm_map(corpus, stemDocument)
corpus = tm_map(corpus, stripWhitespace)

as.character(corpus[[1]])

####Creating a DTM

dtm = DocumentTermMatrix(corpus)  ###creating DTM from corpus

dim(dtm) ####checking the dimension of dtm

##word frequency

freq = sort(colSums(as.matrix(dtm)), decreasing = T)  ####sum up the frequencies and sort in decreasing order

findFreqTerms(dtm, lowfreq = 20) ###finding text that appear more than 20times in dtm


###Lets create a column for words and their frequencies respectively

word_freq = data.frame(word = names(freq), freq = freq)
View(word_freq)

####Getting word cloud

#wordcloud(words = word_freq$word,  freq = word_freq$freq, max.words = 100, random.order = F,
          #          rot.per = 0.35, colors = brewer.pal(3, "Dark2"))

wordcloud2(word_freq, color = "random-dark", minSize = 40, shape = "triangle", rotateRatio = 0.35)

 