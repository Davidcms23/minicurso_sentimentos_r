library(tidyverse)
library(tidytext)
library(gutenbergr)

# 1 - Download: Werther vs Pollyanna 
# ID 2527: The Sorrows of Young Werther
# ID 1450: Pollyanna
livros <- gutenberg_download(c(2527, 1450), meta_fields = "title")

# 2. Limpeza e Tokenização em bloco
analise_comparativa <- livros |>
  unnest_tokens(word, text) |>
  anti_join(stop_words) |>
  inner_join(get_sentiments("bing")) |> 
  count(title, sentiment) |>
  spread(sentiment, n, fill = 0) |>
  mutate(
    total = positive + negative,
    saldo = (positive - negative)/total,
    titulo_curto = ifelse(str_detect(title, "Werther"), "Werther", "Pollyanna")
  )

# 3 - Visualização
ggplot(analise_comparativa, aes(x = titulo_curto, y = saldo, fill = titulo_curto)) +
  geom_col(show.legend = FALSE, alpha = 0.8) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_text(aes(label = round(saldo, 2)), vjust = -0.5, size = 5) +
  scale_fill_manual(values = c("Pollyanna" = "forestgreen", "Werther" = "firebrick")) +
  labs(title = "Comparação de Saldo Emocional",
       subtitle = "Saldo = (Positivos - Negativos) / Total de palavras emotivas",
       y = "Saldo (Negativo < 0 < Positivo)",
       x = NULL) +
  theme_classic()

livros |>
  filter(title == "Pollyanna") |>
  unnest_tokens(word, text) |>
  inner_join(get_sentiments("bing")) |>
  count(word, sentiment, sort = TRUE) |>
  filter(sentiment == "negative") |>
  head(10)

# USANDO O afinn
analise_afinn <- livros |>
  unnest_tokens(word, text) |>
  anti_join(stop_words) |>
  inner_join(get_sentiments("afinn")) |> 
  group_by(title) |>
  summarise(saldo_medio = mean(value)) # intensidade de -5 a 5

# Visualizando
ggplot(analise_afinn, aes(x = title, y = saldo_medio, fill = title)) +
  geom_col(show.legend = F) +
  labs(title = "Comparação com Léxico AFINN (Intensidade)",
       y = "Média de Sentimento")
