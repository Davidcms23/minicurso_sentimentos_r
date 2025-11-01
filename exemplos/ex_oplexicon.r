## Analisando texto com OpLexicon

# 1. Carregue os pacotes necessários
library(tidyverse)
library(tidytext)
library(readr)

# 2. Baixe o léxico OpLexicon
# Instale o pacote
# install.packages("lexiconPT")
library(lexiconPT)
data("oplexicon_v3.0")
oplexicon <- oplexicon_v3.0


# 3. Prepare seu texto de exemplo
texto <- "Atentei para todas as obras que se fazem debaixo do sol, e eis que tudo era vaidade e aflição de espírito. Aquilo que é torto não se pode endireitar; aquilo que falta não se pode calcular. Falei eu com o meu coração, dizendo: Eis que eu me engrandeci, e sobrepujei em sabedoria a todos os que houve antes de mim em Jerusalém; e o meu coração contemplou abundantemente a sabedoria e o conhecimento. E apliquei o meu coração a conhecer a sabedoria e a conhecer os desvarios e as loucuras, e vim a saber que também isto era aflição de espírito. Porque na muita sabedoria há muito enfado; e o que aumenta em conhecimento, aumenta em dor."

# 4. Transforme o texto em um data frame
df_texto <- tibble(
  id = 1,
  texto = texto
)

# 5. Tokenize o texto (separe em palavras)
palavras <- df_texto |>
  unnest_tokens(word, texto)

# 6. Faça o match com o léxico
sentimentos <- palavras |>
  inner_join(oplexicon, by = c("word" = "term"))

# 7. Calcule o sentimento geral
sentimento_geral <- sentimentos |>
  summarise(
    sentimento_total = sum(polarity),
    n_palavras = n(),
    sentimento_medio = mean(polarity)
  )

# 8. Visualize os resultados
sentimentos |>
  count(word, polarity) |>
  arrange(desc(abs(polarity)))
