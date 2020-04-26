
import pandas as pd
lyrics = pd.read_csv('/kaggle/input/380000-lyrics-from-metrolyrics/lyrics.csv')

#Look at data first rows
lyrics.head()
#replace new line with space
lyrics = lyrics.replace({'\n': ' '}, regex=True)
#get word count
lyrics['word_num'] = lyrics['lyrics'].str.split().str.len()

#Take out index
lyrics = lyrics.drop(columns = ['index’])

#take out observations that have 
#subset = lyrics[['genre','lyrics']]
#lyrics.dropna(subset=['genre', 'lyrics'], inplace=True)
print(lyrics.head())
#See what values are present for years
column_values = lyrics[["year"]].values.ravel()
unique_values =  pd.unique(column_values)
print(unique_values)
#remove the dates that do not make any sense
bad_year = ['702', '112', '67']
lyrics = lyrics[~lyrics['year'].isin(bad_year)]

#See what values are present for genre
column_values = lyrics[["genre"]].values.ravel()
unique_values =  pd.unique(column_values)
print(unique_values)
#get the counts of each 
#lyrics.value_counts()
index = pd.Index(lyrics['genre'])
index.value_counts()
#Remove all instrumental songs
lyrics = lyrics[~lyrics.lyrics.str.contains("instrumental")]
lyrics = lyrics[~lyrics.lyrics.str.contains("INSTRUMENTAL")]
lyrics = lyrics[~lyrics.lyrics.str.contains("[Instrumental]")]
