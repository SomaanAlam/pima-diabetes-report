# What Is Linked to Diabetes? An R Analysis of the Pima Indians Diabetes Data

A short, reproducible analysis of the Pima Indians Diabetes dataset, written up in R Markdown as a simple report for a non-specialist reader.

**Read the report:** [`reports/diabetes-report.md`](reports/diabetes-report.md) , or download the self-contained [`reports/diabetes-report.html`](reports/diabetes-report.html).

## What it does

1. **Cleans the data.** The raw file has no headers, and missing values are hidden as zeros in five columns (e.g. a blood pressure of 0). These are recoded as missing and the impact is quantified.
2. **Summarises it.** Tables and charts show how glucose, BMI, age and other measurements differ between women with and without diabetes.
3. **Runs a logistic regression.** Odds ratios with 95% confidence intervals, on rescaled predictors so each one is for a meaningful step (e.g. +10 mg/dL glucose).
4. **Checks performance honestly.** 5-fold cross-validation (AUC and accuracy against a "always guess no diabetes" baseline).
5. **Explains it plainly**, including limitations: one specific population, association rather than causation, and glucose being part of the diagnosis itself.

## Headline results

| | |
|:--|:--|
| Women in the data | 768 (35% with diabetes) |
| Women used in the regression | 724 (complete records) |
| Clearest associations | Glucose and BMI; also pregnancies and family-history score |
| Not clearly associated | Age and diastolic blood pressure, once other factors are included |
| Cross-validated AUC | 0.84 |

The report computes every figure from the data, so the text and numbers cannot drift apart.

## Repository layout

```
.
├── data/
│   └── pima-indians-diabetes.raw.csv   # raw data, no header row (768 rows, 9 columns)
├── R/
│   └── clean_data.R                    # column names, zero-to-missing recoding, derived groups
├── reports/
│   ├── diabetes-report.Rmd             # the report source (analysis + write-up)
│   ├── diabetes-report.md              # rendered for GitHub
│   ├── diabetes-report.html            # rendered, self-contained
│   └── diabetes-report_files/          # figures used by the .md
└── README.md
```

## Reproduce it

Requires R (4.1 or later, for the `|>` pipe) and these packages:

```r
install.packages(c("dplyr", "ggplot2", "knitr", "rmarkdown"))
```

Then, from the project root:

```r
rmarkdown::render("reports/diabetes-report.Rmd", output_format = "all")
```

This rebuilds both the HTML and the GitHub-friendly Markdown. (Pandoc is needed; it comes with RStudio, or install it separately.) The cross-validation uses a fixed seed, so results are repeatable.

## Data

The Pima Indians Diabetes dataset comes from the US National Institute of Diabetes and Digestive and Kidney Diseases and is widely distributed through the UCI Machine Learning Repository and Kaggle. The copy in `data/` was downloaded from the public mirror at <https://github.com/jbrownlee/Datasets> (`pima-indians-diabetes.data.csv`). The data are not my own; please check the terms of the original source before reusing them.

## Caveats

This is a learning and portfolio project. It describes associations in one specific, historical group of women and is not medical advice or a clinical risk tool.
