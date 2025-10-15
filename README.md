# Minicurso: Análise de Sentimentos com R
Este repositório contém o material utilizado na parte prática do minicurso "Análise de Sentimentos com R", oferecido durante a Semana da Estatística da UFRN 2025. O objetivo do minicurso é apresentar uma introdução a análise de sentimentos utilizando o R, por meio de léxicos como o OpLexicon e o NRC.
## Pacotes

```r
install.packages(c("tidyverse", "tidytext", "gutenbergr", "textdata", "readr"))
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

## Links importantes

- [OpLexicon](https://github.com/marlovss/OpLexicon)
- [syuzhet](https://programminghistorian.org/pt/licoes/analise-sentimento-R-syuzhet)
- [Text Mining with R: A Tidy](https://www.tidytextmining.com/tidytext)
- [Automated Content Analysis with R](https://content-analysis-with-r.com/)
