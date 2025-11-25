# Minicurso: Análise de Sentimentos com R
Este repositório contém o material utilizado na parte prática do minicurso "Análise de Sentimentos com R", oferecido durante a Semana da Estatística da UFRN 2025. O objetivo do minicurso é apresentar uma introdução a análise de sentimentos utilizando o R, por meio de léxicos como o OpLexicon e o NRC.
## Pacotes

```r
install.packages(c("tidyverse", "tidytext", "gutenbergr", "textdata", "syuzhet", "wordcloud"))
```

## Analisando texto

## Analisando livro

 - **1. Carregue a biblioteca do projeto**
```{r}
library(gutenbergr)
```

 - **2. Escolha um livro.**

Podemos baixar os livros com base no seu ID em [Projeto Gutenberg](https://www.gutenberg.org/).
Podemos achar o ID do livro desejado em

 - (i) Em About this eBook: `EBook-No.` no final da página do livro.
 - (ii) Na URL: `https://www.gutenberg.org/ebooks/1497` nesse caso o ID é 1497.
 - (iii) No R: `gutenberg_database`

```r
livro <- gutenberg_download(84) #frankenstein
```

## Funções importantes

Usando o pacote `tidytext`
`unnest_tokens()`: "Quebra" o texto em pedaços menores(tokens).
 - `token = "words"`: Quebra em palavras.
 - `token = "sentences`: Quebra em frases.

Usando o pacote `syuzhet`
`get_sentiment(texto, method = "syuzhet", language = "portuguese")`: Analisa o texto e retorna um valor numérico (Positivo > 0, Negativo < 0)
 - Métodos: O método "syuzhet" é ótimo para plotar arcos narrativos. Outros métodos incluem "bing" (apenas positivo/negativo) ou "nrc" (8 emoções: raiva, alegria, medo, etc.).

Usando o pacote `wordcloud`
`wordcloud()`: Cria a nuvem de palavras baseada na frequência.

### Limpeza de PDFs

Vamos usar os pacótes `pdftools` e `stringr` para carregar e limpar o pdf.
```r
library(pdftools)
```

`pdf_text("arquivo.pdf")`: Lê o PDF e retorn um vetor de textos, onde cada elemento é uma página.
 - *Dica*: Use `paste(texto, collapse = " ")` logo depois para juntar todas as páginas em um único texto.

`str_squish()`: Remove espaços duplicados, tabulações e quebras de linhas(`\n`) desnecessárias.

`str_replace_all()`: Substitui padrões específicos. Essencial para remover caracteres estranhos que vêm da conversão do PDF.



## Links importantes

- [OpLexicon](https://github.com/marlovss/OpLexicon)
- [syuzhet](https://programminghistorian.org/pt/licoes/analise-sentimento-R-syuzhet)
- [Text Mining with R: A Tidy](https://www.tidytextmining.com/tidytext)
- [Automated Content Analysis with R](https://content-analysis-with-r.com/)
