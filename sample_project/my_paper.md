

```r
# Commands that are useful for extracting code and replicating results:
# knitr::purl("my_paper.qmd")
# knitr::spin("my_paper.R")

# A tool to help with citations
# devtools::install_github("crsh/citr")

# Packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(
  tidyverse,
  DeclareDesign,
  knitr,
  kableExtra,
  modelsummary)
```
```{rfig-1}
#| echo: true
#| fig-cap: "sample figure"

read_rds("data/data.rds") |>
  ggplot(aes(X, Y)) + geom_point()



```

```r
read_rds("data/data.rds") |>
  summarize(`mean Y` = mean(Y), 
            `mean X` = mean(X), 
            correlation = cor(X, Y)) |>
  kable(digits = 2, caption = "A sample table")
```



Table: A sample table

| mean Y| mean X| correlation|
|------:|------:|-----------:|
|  -0.03|   0.02|        0.69|

```ranalysis
#|
# generate a list of models
two_models <- 
  list(
  lm_robust(Y~1, data = read_rds("data/data.rds")),
  lm_robust(Y~X, data = read_rds("data/data.rds")))

```
```{rtbl-ols}
#| label: tbl-ols
#| echo: true
#| results: asis

# print nicely
two_models|>
  modelsummary(caption = ": some analyses", note = "some notes") 
```

