
setwd("D:/Text mining")
chunk_2<-readLines("Acknowledgment.txt")
chunk_2
chunk_pasted2<-paste(chunk_2,collapse = "")
head(chunk_pasted2)
clean_data1<-tolower(chunk_pasted2)
head(chunk_pasted2)
#remove punctutaion
clean_data2<-gsub(pattern = "\\W",replace = " ", clean_data1)
head(clean_data2)

#remove all digits
clean_data3<-gsub(pattern = "\\d",replac = " ", clean_data2)
head(clean_data3)

#clening the stop words
install.packages("tm")
library(tm)

#lets preview of stopwords
stopwords()[1:10]

#let us remove them using function removewords()
clean_data4<-removeWords(clean_data3,stopwords())
head(clean_data4)

clean_data5<-gsub(pattern = "\\b[A-Z]\\b{1}",replace = " ", clean_data4)
head(clean_data5)

# removing the space
clean_data6<-stripWhitespace(clean_data5)

# 'ed' and 'ing'
install.packages("SnowballC")
library(SnowballC)
clean_data6<-stemDocument(clean_data6,language = "english")

clean_data7<-strsplit(clean_data6," ")

word_freq1<-table(clean_data7)
head(word_freq1)


positive<-scan("positive.txt",
               what = "character",
               comment.char = ";")

negative<-scan("negative.txt",
               what = "character",
               comment.char = ";")

senti_analysis<-unlist(clean_data7)
match(senti_analysis,positive)[1:40]
match(senti_analysis,negative)[1:40]

p_score <- sum(!is.na(match(senti_analysis,positive)))
p_score
n_score<-sum(!is.na(match(senti_analysis,negative)))
n_score

sentiment_score = p_score - n_score
sentiment_score

----------------------------
  
#install.packages("RColorBrewer")
#install.packages("wordcloud")

library(RColourBrewer)
library(wordcloud)


class(clean_data7)
word_cloud1<-unlist(clean_data6)
class(word_cloud1)

wordcloud(word_cloud1)
wordcloud(word_cloud1,min.freq = 2,
          random.order = FALSE,scale = c(5,1),
          colors = rainbow(7))