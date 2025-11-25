library(tidyverse)
library(tidytext)
library(gutenbergr)
library(syuzhet)

livro <- gutenberg_download(84)

# Limpeza: adicionar número de linha
livro_linha <- livro |> 
  mutate(linha = row_number()) |> 
  filter(text != "") # remove linhas vazias

# Tokenização
livro_tokenizado <- livro_linha |>
  unnest_tokens(word, text)

# Remove "stop words"
data("stop_words")
livro_limpo <- livro_tokenizado |> 
  anti_join(stop_words)

# Análise de polaridade
ncr_sentimentos <- livro_limpo |> 
  inner_join(get_sentiments("bing")) |>  # léxico BING (positivo/negativo)
  count(index = linha %/% 80, sentiment) |> # agrupa a cada 80 linhas
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) |> 
  mutate(sentiment = positive - negative)

# Visualização
ggplot(ncr_sentimentos, aes(x = index, y = sentiment)) +
  geom_col(aes(fill = sentiment > 0), show.legend = F) +
  geom_smooth(se = F, color = "black")

# Usando sentimentos + 8 emoções com Syuzhet
syuzhet <- get_nrc_sentiment(livro$text)

barplot(colSums(syuzhet),
        las = 2,
        col = rainbow(10))
