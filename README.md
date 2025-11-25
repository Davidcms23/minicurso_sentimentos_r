# Minicurso: Análise de Sentimentos com R

Este repositório contém o material utilizado na parte prática do minicurso **"Análise de Sentimentos com R"**, oferecido durante a **Semana da Estatística da UFRN 2025**.

O objetivo do minicurso é apresentar uma introdução à análise de sentimentos utilizando o R, explorando léxicos como o OpLexicon e o NRC, e aplicando técnicas de *Text Mining* em obras literárias e textos clássicos.

## 1. Instalação de Pacotes

Para reproduzir os exemplos deste minicurso, certifique-se de ter os seguintes pacotes instalados:

```r
install.packages(c("tidyverse", "tidytext", "gutenbergr", "textdata", 
                   "syuzhet", "wordcloud", "pdftools", "stringr"))
```

## 2. Analisando Livros (Projeto Gutenberg)

O pacote `gutenbergr` nos permite baixar obras de domínio público diretamente para o R.

### Passo a passo:

1. **Carregue a biblioteca:**
   ```r
   library(gutenbergr)
   ```

2. **Encontre o ID do livro:**
   Podemos baixar os livros com base no seu ID no [Projeto Gutenberg](https://www.gutenberg.org/).
   * **(i) No site:** Procure por `EBook-No.` na seção "About this eBook" ou observe a URL (ex: `https://www.gutenberg.org/ebooks/1497` -> ID é **1497**).
   * **(ii) No R:** Utilize a função `gutenberg_database`.

3. **Baixe o livro:**
   ```r
   # Exemplo: Baixando "Frankenstein" (ID 84)
   livro <- gutenberg_download(84) 
   ```

## 3. Analisando PDFs

Para textos que não estão no Gutenberg (como relatórios ou PDFs específicos), usamos uma combinação dos pacotes `pdftools` (leitura) e `stringr` (limpeza).

### Carregando as ferramentas
```r
library(pdftools)
library(stringr)
```

### Funções Essenciais de Limpeza

| Função | Pacote | Descrição |
| :--- | :--- | :--- |
| `pdf_text("arquivo.pdf")` | `pdftools` | Lê o PDF e retorna um vetor de caracteres, onde cada elemento é uma página. **Dica:** Use `paste(..., collapse = " ")` para juntar tudo em um texto só. |
| `str_squish()` | `stringr` | A "faxina pesada". Remove espaços duplicados, tabulações e quebras de linha (`\n`) desnecessárias que sujam o texto. |
| `str_replace_all()` | `stringr` | Substitui padrões específicos (Regex). Essencial para remover cabeçalhos, rodapés ou erros de codificação do PDF. |

## 4. Funções Importantes

Abaixo, explicamos as funções que formam o "coração" da nossa análise.

### Estruturação (`tidytext`)
A base da metodologia *Tidy* é ter um token por linha.

* **`unnest_tokens(tbl, output, input, token = ...)`**:
  * `token = "words"`: Quebra o texto em **palavras**. Útil para contagem de frequência e nuvens de palavras.
  * `token = "sentences"`: Quebra o texto em **frases**. Fundamental para analisar a evolução da narrativa (ex: fluxo de sentimento frase a frase).

### Análise de Sentimentos (`syuzhet`)
Atribui valores numéricos às palavras.

* **`get_sentiment(texto, method = "syuzhet", language = "portuguese")`**:
  * Retorna um valor numérico (Positivo > 0, Negativo < 0).
  * **Método "syuzhet":** Escala contínua, ótimo para plotar arcos narrativos (história).
  * **Método "nrc":** Classifica em 8 emoções discretas (raiva, alegria, medo, confiança, tristeza, surpresa, antecipação, nojo).
  * **Método "bing":** Classificação binária simples (apenas positivo/negativo).

### Visualização (`wordcloud`)
* **`wordcloud()`**: Cria a nuvem de palavras baseada na frequência. Lembre-se de remover as *stop words* (artigos, preposições) antes de gerar o gráfico para que ele seja informativo.

## 🔗 Links Importantes

* [OpLexicon (Léxico para Português)](https://github.com/marlovss/OpLexicon)
* [Tutorial: Análise de Sentimento com Syuzhet](https://programminghistorian.org/pt/licoes/analise-sentimento-R-syuzhet)
* [Livro: Text Mining with R (Tidy Approach)](https://www.tidytextmining.com/tidytext)
* [Automated Content Analysis with R](https://content-analysis-with-r.com/)
