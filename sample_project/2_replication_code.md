


---
title: "Replication code for 'Paper title'"
date: "09 April 2025"
author: Your name
---

Generated by `knitr::spin()` from `code.R`.

You can add any text you want to appear in the replication -- but not in the paper -- in chunks like this.

You can run the replication by executing the lines below

knitr::purl("1_analysis.qmd",  "2_replication_code.R")

knitr::spin("2_replication_code.R")  

## Set up



``` r
pacman::p_load(tidyverse, DeclareDesign, foreign, knitr)

Ys <- c("videoLikep1r", "videoSharep1r", "videoBookmarkp1r", "videoCommentTickedp1r", "watch_percentage_", "skipped_video_")

Y_labels <- c("Like", "Share", "Bookmark", "Comment", "Watch", "Skip")
```

``` r
# fabricate(N = 100, X = rnorm(N), W = rnorm(N), Y = X + rnorm(N)) |> write.csv("assets/my_data.csv")

df <- read.csv("assets/my_data.csv")
```


# Figure (title that will appear on replication material)


``` r
figure_1 <-
  df |> 
  ggplot(aes(Y, X)) +
  geom_point() +
  theme_bw()

figure_1  
```

![A caption](figure/figure-1.png)


# Table (title that will appear on replication material)


``` r
models <-
list(
`this one` = lm_robust(Y ~ X, data = df),
`that one` = lm_robust(Y ~ X + W, data = df)
)

models |> 
  texreg:::htmlreg(include.ci = FALSE)
```

<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<caption>Statistical models</caption>
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">this one</th>
<th style="padding-left: 5px;padding-right: 5px;">that one</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">(Intercept)</td>
<td style="padding-left: 5px;padding-right: 5px;">0.04</td>
<td style="padding-left: 5px;padding-right: 5px;">0.04</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.09)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.09)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">X</td>
<td style="padding-left: 5px;padding-right: 5px;">1.01<sup>&#42;&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">1.01<sup>&#42;&#42;&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.08)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.08)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">W</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.01</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.07)</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.52</td>
<td style="padding-left: 5px;padding-right: 5px;">0.52</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Adj. R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.52</td>
<td style="padding-left: 5px;padding-right: 5px;">0.51</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">100</td>
<td style="padding-left: 5px;padding-right: 5px;">100</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">RMSE</td>
<td style="padding-left: 5px;padding-right: 5px;">0.85</td>
<td style="padding-left: 5px;padding-right: 5px;">0.85</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="3"><sup>&#42;&#42;&#42;</sup>p &lt; 0.001; <sup>&#42;&#42;</sup>p &lt; 0.01; <sup>&#42;</sup>p &lt; 0.05</td>
</tr>
</tfoot>
</table>

``` r
save.image("saved/analysis.Rdata")
```

