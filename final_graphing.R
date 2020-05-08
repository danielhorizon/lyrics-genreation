library(tidyverse)

df <- data.frame(
  genre = c("metal", "rock", "rap", "pop", "country", "jazz", "metal", "rock", "rap", "pop", "country", "jazz"),
  generated = c(1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0),
  avg_line_length = c(5.821, 4.873, 5.906, 4.816, 6.394, 5.775, 8.983, 8.484, 8.172, 7.333, 8.182, 7.165),
  in_song_word_variation = c(.43, .35, .404, .246, .413, .344, .538, .478, .424, .405, .482, .477),
  in_genre_word_variation = c(.482, .339, .34, .196, .426, .2, .547, .417, .36, .39, .616, .357),
  i_vs_you = c(7.8, .45, 20.5, 9.2, 26.4, 4.7, 1.348, 1.483, 4.714, 2.251, 1.427, 1.234),
  word_repetition = c(16.25, 8.2, 16.85, 3.6, 2.4, 31.25, 1.913, 2.032, 10.964, 5.384, 1.524, 1.69)
                 )




cos_sim <- function(v1, v2){
  dot <- v1 %*% v2
  mag <- sqrt(sum(v1^2)) * sqrt(sum(v2^2))
  return(dot / mag)
}

get_genre_cosine_similarity <- function(input_genre){
  v1 <- as.numeric(dplyr::select(filter(df, genre == input_genre, generated == 0), -c("genre", "generated")))
  v2 <- as.numeric(dplyr::select(filter(df, genre == input_genre, generated == 1), -c("genre", "generated")))
  print(v1)
  print(class(v1))
  
  return(cos_sim(v1, v2))
}

input_genres <- c("metal", "rock", "rap", "pop", "country", "jazz")
cosine_similarities <- sapply(input_genres, get_genre_cosine_similarity)

sims <- data.frame(genre = input_genres,
                   cosine_similarity = cosine_similarities)

p1 <- ggplot(sims, aes(x = genre, y = cosine_similarity)) +
  geom_bar(stat="identity") +
  ggtitle("Genre Cosine Similarities Actual vs. Generated") +
  xlab("Genre") +
  ylab("Cosine Similarity")


get_metric_cosine_similarity <- function(input_metric){
  v1 <- as.numeric(t(df)[c(input_metric),7:12])
  v2 <- as.numeric(t(df)[c(input_metric),1:6])
  print(v1)
  print(class(v1))
  
  return(cos_sim(v1, v2))
}

input_metrics <- c("avg_line_length", "in_song_word_variation",
                   "in_genre_word_variation", "i_vs_you", "word_repetition")
metric_cosine_similarities <- sapply(input_metrics, get_metric_cosine_similarity)

sims2 <- data.frame(metric = input_metrics,
                   metric_cosine_similarity = metric_cosine_similarities)

p2 <- ggplot(sims2, aes(x = metric, y = metric_cosine_similarity)) +
  geom_bar(stat="identity", fill = "blue") +
  ggtitle("Metric Cosine Similarities Actual vs. Generated") +
  xlab("Genre") +
  ylab("Cosine Similarity") +
  coord_flip()

require(gridExtra)
grid.arrange(p1, p2, ncol = 2)
