
# Avatar: The Last Airbender Dialogue Generator

Welcome!

This Shiny application uses a trigram Markov model to generate or complete lines of dialogue for six major characters from the Nickelodeon show <i>Avatar: The Last Airbender</i>. 

After scraping all lines of dialogue from episode transcripts on [Avatar Spirit](avatarspirit.net), I cleaned the data to be separated by speaker and quote. I kept just the top characters, according to their liens of dialogue: Aang, Sokka, Katara, Zuko, Toph, and Iroh. Sorry Azula, you didn't make the cut.

Once that was done, I created trigram Markov models for each character, counting the number of times that each triple of words (e.g. "I", "am", "cool") appeared in all of that character's quotes. I treated all punctuation (except apostrophes) as separate tokens, so the generated sentences would have as natural use of punctuation as possible. 

After I made the data tables storing the frequency of each trigram for each character, I made the quote generator - finally! The generator works on two, one, or zero input words. (If the user enters more than two words, it just strips the inout down to the last two.) It filters the trigram table down to instances that match the input words (e.g. inputWord="I have" -> "I have no"(15), "I have a" (10), etc.) and then uses the frequency to draw a weighted sample. I set a cap on the length of the generated quote so it wouldn't get stuck in an infinite loop. 

Finally, so the generated quotes looked as real as possible, I created a 'reformat' function that implements natural English capitalization, such as the first word in a sentence, the word after sentence-ending punctuation (e.g. . ? !), and words involving "I" (e.g. I, I'm, I'll, I'd). 

I created a simple Shiny application so that users (and myself) could interact with this generator in an easy & intuitive way. See the deployed beta version [here](https://kiratebbe.shinyapps.io/markov/).


### Credits:
* [Episode transcripts](http://atla.avatarspirit.net/transcripts.php?num=101)
* [Button inspiration](https://gist.github.com/aagarw30/2b46c89e686a956098e20cb90b1cf004)



