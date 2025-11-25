# Minicurso: Análise de Sentimentos com R

Este repositório contém o material suplementar, roteiros e scripts utilizados na parte prática do minicurso **"Análise de Sentimentos com R"**, ofertado durante a **Semana da Estatística da UFRN 2025**.

## Objetivo

O minicurso visa introduzir técnicas de Processamento de Linguagem Natural (PLN) focadas em análise de sentimentos, utilizando a linguagem estatística R. A abordagem concentra-se em métodos baseados em léxicos (dicionários), como o *OpLexicon* e o *NRC*, aplicados a corpora literários e textos clássicos para extração de padrões latentes e séries temporais narrativas.

## 1. Pré-requisitos e Instalação

Para a execução dos scripts propostos, é necessária a instalação das bibliotecas listadas abaixo, que abrangem desde a manipulação e estruturação de dados até a visualização gráfica e mineração de texto.

```r
install.packages(c("tidyverse", "tidytext", "gutenbergr", "textdata", 
                   "syuzhet", "wordcloud", "pdftools", "stringr"))
```

## 2. Coleta de Dados: Projeto Gutenberg

A biblioteca `gutenbergr` permite o acesso direto e o download de obras de domínio público catalogadas no Projeto Gutenberg.

### Procedimento de Coleta:

1. **Carregamento da biblioteca:**
   ```r
   library(gutenbergr)
   ```

2. **Identificação da obra:**
   O identificador numérico (ID) do livro pode ser obtido por dois métodos:
   * **Via Web:** Consultando o campo `EBook-No.` na página da obra em [gutenberg.org](https://www.gutenberg.org/). (Exemplo: a URL `.../ebooks/1497` indica que o ID é **1497**).
   * **Via R:** Utilizando a função de busca `gutenberg_database`.

3. **Download e Armazenamento:**
   ```r
   # Exemplo: Download da obra "Frankenstein" (ID 84)
   livro <- gutenberg_download(84) 
   ```

## 3. Coleta de Dados: Arquivos Locais (PDF)

Para a análise de documentos não estruturados em formato PDF, utiliza-se a combinação dos pacotes `pdftools` (para extração de texto bruto) e `stringr` (para tratamento de strings e expressões regulares).

### Ferramentas de Pré-processamento

| Função | Pacote | Aplicação Técnica |
| :--- | :--- | :--- |
| `pdf_text()` | `pdftools` | Extrai o conteúdo textual do arquivo, retornando um vetor de caracteres onde cada elemento corresponde a uma página do documento original. |
| `str_squish()` | `stringr` | Normaliza espaços em branco, removendo tabulações, quebras de linha residuais e espaçamentos duplicados internos. |
| `str_replace_all()` | `stringr` | Aplica expressões regulares (Regex) para substituição de padrões. Essencial para correção de erros de codificação (OCR), remoção de cabeçalhos repetitivos ou caracteres de controle. |

## 4. Ferramentas Metodológicas

Abaixo estão descritas as funções centrais para a estruturação (tokenização) e análise semântica dos dados textuais.

### 4.1. Tokenização e Estruturação (`tidytext`)
A metodologia *Tidy Data* aplicada a texto exige que cada linha da tabela represente uma unidade analítica (token).

* **`unnest_tokens(tbl, output, input, token = ...)`**:
  * `token = "words"`: Segmenta o texto em **palavras**. Utilizado para análises de frequência (*Bag of Words*) e nuvens de palavras.
  * `token = "sentences"`: Segmenta o texto em **sentenças**. Essencial para análises temporais, preservação de fluxo narrativo e cálculo de densidade de sentimento por frase.

### 4.2. Atribuição de Polaridade (`syuzhet`)
Funções responsáveis por mapear tokens a valores numéricos de sentimento baseados em dicionários pré-definidos.

* **`get_sentiment(texto, method = "syuzhet", language = "portuguese")`**:
  * Retorna um vetor numérico de valência emocional.
  * **Método "syuzhet":** Utiliza uma escala contínua de valência. Indicado para visualização de trajetórias narrativas (arcos dramáticos).
  * **Método "nrc":** Classificação multicategórica em 8 emoções discretas (raiva, alegria, medo, confiança, tristeza, surpresa, antecipação, nojo) e duas polaridades (positivo, negativo).
  * **Método "bing":** Classificação binária estrita (positivo/negativo).

> **Nota sobre Limitações:** A análise baseada em léxicos pressupõe independência entre as palavras (*uni-gramas*). Portanto, este método apresenta limitações intrínsecas na detecção de **ironia**, **sarcasmo**, **negações complexas** e variações semânticas dependentes do contexto histórico (ex: deslocamento de sentido de termos em obras antigas).

### 4.3. Visualização de Frequência (`wordcloud`)
* **`wordcloud()`**: Gera representações visuais baseadas na frequência de termos. Recomenda-se estritamente a remoção prévia de *stop words* (artigos, preposições e conectivos sem carga semântica relevante) para evitar ruído na visualização.

## Referências e Material Complementar

* [OpLexicon: Léxico de sentimentos para o português](https://github.com/marlovss/OpLexicon)
* [Introduction to Sentiment Analysis with Syuzhet](https://programminghistorian.org/pt/licoes/analise-sentimento-R-syuzhet)
* [Silge, J., & Robinson, D. (2017). Text Mining with R: A Tidy Approach](https://www.tidytextmining.com/tidytext)
* [Automated Content Analysis with R](https://content-analysis-with-r.com/)
