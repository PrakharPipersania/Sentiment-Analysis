library(readr)
text=read_file('Input_Data.txt')
#text="I can definitely do it"
sentiments_values=read.csv('Sentiment_Values.csv',header=FALSE)
stop_words=unlist(read.csv("Stop_Words.csv",header=FALSE))
negate=unlist(read.csv("Negate.csv",header=FALSE))
boost=read.csv("Boost.csv",header=FALSE)
clean_data=function(text)
{
  text=tolower(text)
  text=gsub("http\\S+|www\\S+|@\\S+","",text)
  text=gsub("[[:punct:]]", "\\1",text)
  text=gsub("\\s{2,}|[[:cntrl:]]"," ",text)
  return (text)
}
tokenize_text=function(text)
{
  words=unlist(strsplit(text," "))
  return (words)
}
remove_stopword=function(words,stop_words)
{
  cleared_words=c()
  for(i in words)
    if(length(i)>0& !i %in% stop_words)
      cleared_words=c(cleared_words,i)
  return (cleared_words)
}

scalar=function(word,valence,boost)
{
  scalar=0
  map=new.env(T,emptyenv())
  for(i in 1:nrow(boost))
    map[[boost[i,1]]]=boost[i,2]
  if (word %in% boost[,1])
  {
    scalar=map[[word]]
    if (valence<0)
      scalar=scalar*-1
  }
  return (scalar)
}
negated=function(words,negate)
{
  for(i in words)
    if(i %in% negate)
      return (TRUE)
  return (FALSE)
}
never_check=function(valence,sentitext,i,j,negate)
{
  if(negated(sentitext[i],negate)||negated(sentitext[i-j],negate))
    valence=valence*-0.74
  return (valence)
}
sentiment_val=function(valence,sentitext,item,i,sentiments,sentiments_values,boost,negate)
{
  map=new.env(T,emptyenv())
  for(j in 1:nrow(sentiments_values))
    map[[sentiments_values[j,1]]]=sentiments_values[j,2]
  if(item %in% sentiments_values[,1])
  {
    valence=map[[item]]
    for(j in 0:2)
    {
      if(i>j&&is.null(map[[sentitext[i-j]]]))
      {
        s=scalar(sentitext[i-j],valence,boost);
        if(s!=0)
        {
          if(j==1)
            s=s*0.95
          if(j==2)
            s=s*0.9
        }
        valence=valence+s
        valence=never_check(valence,sentitext,j,i,negate)
      }
    }
  }
  sentiments=c(sentiments,valence)
  return (sentiments)
}

polarity_scores=function(words,sentiments_values,boost,negate)
{
  sentiments=c()
  for(i in 1:length(words))
  {
    if(words[i] %in% boost[,1])
    {
      sentiments=c(sentiments,0)
      next
    }
    sentiments=sentiment_val(0,words,words[i],i,sentiments,sentiments_values,boost,negate)
  }
  compound=pos=neg=neu=0
  if(length(sentiments)>0)
  {
    sumofsent=sum(sentiments)
    compound=round(sumofsent/sqrt((sumofsent**2)+15),2)
    pos_sum=neg_sum=neu_sum=0
    for(i in sentiments)
    {
      if(i>0)
        pos_sum=pos_sum+i+1
      else if(i<0)
        neg_sum=neg_sum+i-1
      else
        neu_sum=neu_sum+1
    }
    neg_sum=abs(neg_sum)
    total=(pos_sum+neg_sum+neu_sum)
    pos=round(abs(pos_sum/total),4)*100
    neu=round(abs(neu_sum/total),4)*100
    neg=round(abs(neg_sum/total),4)*100
  }
  print(paste("Postive Sentiment:",pos,"%"))
  print(paste("Neutral Sentiment:",neu,"%"))
  print(paste("Negative Sentiment:",neg,"%"))
  if(compound>=0.05) 
    print("Overall Sentiment: Positive") 
  else if(compound<=-0.05) 
    print("Overall Sentiment: Negative") 
  else
    print("Overall Sentiment: Neutral")
  return (list("pos"=pos,"neu"=neu,"neg"=neg,"compound"=compound))
}
cleaned_text=clean_data(text)
tokenized_words=tokenize_text(cleaned_text)
cleared_words=remove_stopword(tokenized_words,stop_words)
result=polarity_scores(cleared_words,sentiments_values,boost,negate)
