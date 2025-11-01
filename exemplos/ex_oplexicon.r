# Carregue os pacotes necessários
library(tidyverse)
library(tidytext)
library(readr)

# Baixe o léxico OpLexicon
# install.packages("lexiconPT")
library(lexiconPT)
data("oplexicon_v3.0")
oplexicon <- oplexicon_v3.0

# Prepare o texto
texto <- "Atentei para todas as obras que se fazem debaixo do sol, e eis que tudo era vaidade e aflição de espírito. Aquilo que é torto não se pode endireitar; aquilo que falta não se pode calcular. Falei eu com o meu coração, dizendo: Eis que eu me engrandeci, e sobrepujei em sabedoria a todos os que houve antes de mim em Jerusalém; e o meu coração contemplou abundantemente a sabedoria e o conhecimento. E apliquei o meu coração a conhecer a sabedoria e a conhecer os desvarios e as loucuras, e vim a saber que também isto era aflição de espírito. Porque na muita sabedoria há muito enfado; e o que aumenta em conhecimento, aumenta em dor."
df_texto <- tibble(
  id = 1,
  texto = texto
)

# 1 - Tokenização
palavras <- df_texto |>
  unnest_tokens(word, texto)

# 2 - Match com o léxico
sentimentos <- palavras |>
  inner_join(oplexicon, by = c("word" = "term"))

# 3 - Sentimento geral
sentimento_geral <- sentimentos |>
  summarise(
    sentimento_total = sum(polarity),
    n_palavras = n(),
    sentimento_medio = mean(polarity)
  )

# Resultado
sentimentos |>
  count(word, polarity) |>
  arrange(desc(abs(polarity)))
