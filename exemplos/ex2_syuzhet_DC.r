library(syuzhet)
library(gutenbergr)
library(tidyverse)

# 1 - Dados: Baixar Dom Casmurro e pegar uma amostra
livro <- gutenberg_download(55752)

# pegando apenas as primeiras 500 linhas para o exemplo
amostra_texto <- head(livro$text, 500)

# removendo linhas vazias
amostra_texto <- amostra_texto[amostra_texto != ""]

# 2 - Análise de Emoções (NRC)
emocoes <- get_nrc_sentiment(amostra_texto, language = "portuguese")

# 1 - Preparar e Traduzir
df_emocoes <- data.frame(emo = names(emocoes), total = colSums(emocoes)) |>
  filter(emo %in% c("anger", "anticipation", "disgust", "fear", 
                    "joy", "sadness", "surprise", "trust")) |>
  mutate(emo_pt = recode(emo,
                         "anger"        = "Raiva",
                         "anticipation" = "Antecipação",
                         "disgust"      = "Aversão",
                         "fear"         = "Medo",
                         "joy"          = "Alegria",
                         "sadness"      = "Tristeza",
                         "surprise"     = "Surpresa",
                         "trust"        = "Confiança")
         )

# 2 - Visualização em Português
ggplot(df_emocoes, aes(x = reorder(emo_pt, total), y = total)) +
  geom_col(aes(fill = emo_pt), show.legend = FALSE) +
  coord_flip() +
  labs(title = "Perfil Emocional: Dom Casmurro",
       x = NULL, 
       y = "Frequência") +
  theme_minimal()
