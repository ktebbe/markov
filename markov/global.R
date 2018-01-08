##------ read in trigrams -------##
library(data.table)
tophTrigram <- as.data.table(read.csv("tophTrigram.csv", as.is=T))
tophTrigram <- tophTrigram[, -1]

aangTrigram <- as.data.table(read.csv("aangTrigram.csv", as.is=T))
aangTrigram <- aangTrigram[, -1]

sokkaTrigram <- as.data.table(read.csv("sokkaTrigram.csv", as.is=T))
sokkaTrigram <- sokkaTrigram[, -1]

kataraTrigram <- as.data.table(read.csv("kataraTrigram.csv", as.is=T))
kataraTrigram <- kataraTrigram[, -1]

zukoTrigram <- as.data.table(read.csv("zukoTrigram.csv", as.is=T))
zukoTrigram <- zukoTrigram[, -1]

irohTrigram <- as.data.table(read.csv("irohTrigram.csv", as.is=T))
irohTrigram <- irohTrigram[, -1]
##------------------------------------##

##----- functions ----------------##
generateWord <- function(inputWords, trigram){
  inputWords <- tolower(unlist(strsplit(inputWords, " ")))
  
  if(length(inputWords > 1) && nrow(trigram[w1 == inputWords[1] & w2 == inputWords[2], ]) > 0){ #use trigram
    options <- trigram[w1 == inputWords[1] & w2 == inputWords[2],]
    probs <- (options$N)/sum(options$N)
    return(paste(inputWords[1], inputWords[2], sample(options$w3, 1, prob = probs)))
    
  } else if(nrow(trigram[w1 == inputWords[1], ]) > 0){ #use bigram
    options <- trigram[w1 == inputWords[1], ]
    probs <- (options$N)/sum(options$N)
    return(paste(inputWords[1], sample(options$w2, 1, prob = probs)))
    
  } else{ #use unigram
    options <- trigram[trigram$w1 == "sstart" & trigram$w2 == "sstart", ] #use words that are sentence starters
    probs <- (options$N)/sum(options$N)
    return(sample(options$w3, 1, prob = probs))
  }
  
}

## iterating function
generateSentence <- function(sentence, trigram, duration){
  tokens <- tolower(unlist(strsplit(sentence, " "))) # split into words/punctuation
  num <- length(tokens)
  if(num > 2) { # keep only last two tokens, in case user entered more
    tokens <- c(tokens[num - 1], tokens[num])
  }
  ########
  
  for(i in 1:duration){
    num <- length(tokens)
    if(num == 1 | num == 0){ # zero or one word input
      sentence <- generateWord(tokens, trigram) # new one- or two-word sentence
    } else{ #2+ word input
      newestQuote <- unlist(strsplit(generateWord(c(tokens[num-1], tokens[num]), trigram), " "))
      
      if(length(newestQuote) == 2){ # second input word not there -> replace
        sentence <- paste(newestQuote, collapse = " ")
      } else{
        sentence <- paste(sentence, newestQuote[length(newestQuote)])
      }
    }
    
    ## check for sentence ending token
    tokens <- unlist(strsplit(sentence, " "))
    num <- length(tokens)
    if(tokens[num] == "eend"){
      sentence <- paste(tokens[-num], collapse = " ")
      return(sentence)
    }
  }
  return(sentence)
}
## change ppause, pperiod, eexclamation, qquestion, ddash, ccomma
reformat <- function(sentence){
  sentence <- gsub(" pperiod", ".", sentence)
  sentence <- gsub(" eexclamation", "!", sentence)
  sentence <- gsub(" qquestion", "?", sentence)
  sentence <- gsub(" ddash", "-", sentence)
  sentence <- gsub(" ccomma", ",", sentence)
  
  ## find start of line, tokens with sentence ending punctuation, "i" words, proper nouns
  tokens <- unlist(strsplit(sentence, " "))
  sentenceEnds <- c(0, c(which(grepl("\\.", tokens)), which(grepl("!", tokens)), which(grepl("\\?", tokens))))
  sentenceEnds <- sentenceEnds[sentenceEnds != length(tokens)] #remove last token index (if in)
  tokensToUpper <- sentenceEnds + 1
  tokensToUpper <- c(tokensToUpper, which(tokens == "i"), which(tokens == "i'll"), which(tokens == "i'd"),  which(tokens == "i'm")) ## or "I" words
  tokensToUpper <- unique(tokensToUpper) ## remove duplicates
  
  for(i in 1:length(tokensToUpper)){
    index <- tokensToUpper[i]
    tokens[index] <- paste(toupper(substring(tokens[index], 1, 1)), substring(tokens[index], 2), sep="", collapse=" ")
  }
  sentence <- paste(tokens, collapse = " ")
  sentence <- gsub(" ppause ", "...", sentence)
  return(sentence)
}