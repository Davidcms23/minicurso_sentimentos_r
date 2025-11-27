library(tidyverse); library(tidytext)
library(gutenbergr); library(lexiconPT)

# 1 - Dados: Dom Casmurro
livro <- gutenberg_download(55752)
data("oplexicon_v3.0")

# 2 - Stopwords em português
stop_pt <- tibble(word = tm::stopwords("pt"))

# 3 - Cruzamento (Filtra apenas palavras com sentimento)
palavras_sentimento <- livro |>
  unnest_tokens(word, text) |>
  anti_join(stop_pt) |>
  inner_join(oplexicon_v3.0, by = c("word" = "term"))

top_termos <- palavras_sentimento |>
  count(word, polarity, sort = TRUE) |>
  slice_max(n, n = 15)

ggplot(top_termos, aes(x = n, y = reorder(word, n))) +
  geom_col(aes(fill = as.factor(polarity))) +
  labs(title = "Sentimentos em Dom Casmurro",
       x = "Frequência",
       y = NULL,
       fill = "Polaridade") +
  theme_light()

library(wordcloud)

# 1 - Contar frequência das palavras emocionais
contagem <- palavras_sentimento |>
  count(word)

# 2 - Gerar a nuvem
wordcloud(words = contagem$word,
          freq = contagem$n,
          min.freq = 5,       
          max.words = 100,    
          colors = brewer.pal(8, "Dark2")) 
