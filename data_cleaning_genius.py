import pandas as pd
import matplotlib as plt
rappers = pd.read_csv("/Users/harrisonsgill/Documents/Junior Semester 2/LING 380/Final_Project/rappers.csv")

#Take out Unnamed column
rappers = rappers.drop(columns = ["Unnamed: 0"])
#Look at data first rows
rappers.head()
#take out observations that have NaN for ‘genre’ or ‘lyrics’
subset = rappers[['genre','lyrics']]
rappers.dropna(subset=['genre', 'lyrics'], inplace=True)
#replace new line with space
rappers = rappers.replace({'\n': ' '}, regex=True)
#get word count
rappers['word_num'] = rappers['lyrics'].str.split().str.len()
#observe that there are lots of songs w/ 1 word
rappers.sort_values(by = "word_num").head(100)
#remove entries where only 1 word in song
rappers['word_num'].astype('int32')
rappers = rappers[rappers.word_num != 1]
#anything with rap genius comments is way to long and includes comments
rappers = rappers[~rappers['lyrics'].str.contains("RAP GENIUS")]
#notice that 124/130 of the songs with "Lyrics are just some string saying how there are no lyrics"
rappers = rappers[rappers['word_num'] !=18]
#anything less than 10 seems to be junk lyrics
rappers = rappers[rappers['word_num'] > 10]
