# [Sentiment-Analysis](https://github.com/PrakharPipersania/Sentiment-Analysis)
## INTRODUCTION
What is Sentimental Analysis? 
It is one of the Natural Language Processing fields. It is contextual mining of text which identifies and extracts subjective information in source material. It aims to extract people’s opinions, sentiments, and subjectivity from the texts. It analyses an incoming message and tells whether the underlying sentiment is positive, negative our neutral.

Sentiment Analysis Algorithms
* Rule-based approach
Rule-based sentiment analysis is based on an algorithm with a clearly defined description of an opinion to identify. Includes identify subjectivity, polarity, or the subject of opinion. The rule-based approach involves basic Natural Language Processing routine. It involves the following operations with the text corpus:
->Stemming
->Tokenization
->Parsing
->Lexicon analysis
Here’s how it works:
->There are three lists of words. One of them includes valence for the words, the other includes the words which negate the sentence, and the third contains booster words.
->The algorithm goes through the text, finds the words that match the criteria.
->After that, the algorithm calculates which type of words is more prevalent in the text. If there are more positive words, then the text is deemed to have a positive polarity.

* Automatic Sentiment Analysis
This type of sentiment analysis uses machine learning to figure out the gist of the message. Because of that, the precision and accuracy of the operation drastically increase and you can process information on numerous criteria without getting too complicated. In essence, the automatic approach involves supervised machine learning classification algorithms. In addition to that, unsupervised machine learning algorithms are used to explore data.
Overall, Sentiment analysis may involve the following types of classification algorithms:
->Linear Regression
->Naive Bayes
->Support Vector Machines
->RNN derivatives LSTM and GRU

## OVERVIEW

Data are imported using R and the data is cleaned by removing emoticons and URLs. Lexical Analysis is used to predict the sentiment of data.

## SYSTEM REQUIREMENTS

* Installation of R 


# FEATURES
* Cleaning Data
The Data is cleaned by removing:
->URLS/Email Address
->Punctuations
->Emoticons
->Redundant Blank spaces
->Stop Words
* Loading Word Database
Stop words are most commonly used words in a language like the, is, at, which, and, on, etc.
Negative words are most commonly words in a language which can reverse the sentiment of the sentence.
Sentimental Values & Booster words are a list of English words rated for valence with a value. The file is tab-separated.
All of the above are collected from NLTK Library.
* Algorithms Used
Lexical Analysis: By comparing uni-grams to the pre-loaded word database collected from nltk library, the data is assigned sentiment score which is used to calculate positive, negative or neutral and overall score.
* Calculation
I have presented the scores, the data as well as the percentage of positive / neutral / negative emotion in the text. This calculated using simple arithmetic to understand the overall sentiment.
* LIMITATIONS
Cannot get 100% efficiency in analysing sentiment of data.
* OUTPUT
The default output is a text that is one of these values:
Positive Sentiment
Negative Sentiment
Neutral Sentiment
Overall Sentiment