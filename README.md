# Understanding Diabetes Progression

An applied data-analysis project in R on patient characteristics and diabetes progression, prepared as part of the Erasmus+ LEAP course *Data Analytics and Statistics with Applications* (AUTH eLearning), Scenario 1.

## Overview

The project investigates which baseline patient characteristics are associated with diabetes progression one year later, what simple and multiple linear regression models tell us, and what conclusions can reasonably be drawn from observational data.

**Research question:** Which patient characteristics are associated with diabetes progression, what do the regression models tell us, and what conclusions can reasonably be drawn from the data?

## Dataset

- 442 patients, one row per patient.
- Outcome: a continuous measure of disease progression one year after baseline (`progression`, called `Y` in the source file).
- Predictors: age, sex (coded 1 and 2, treated as categorical), BMI, blood pressure (`bp`) and six serum measurements (`s1` to `s6`).
- Source: the NCSU-hosted copy of the diabetes dataset, <https://www4.stat.ncsu.edu/~boos/var.select/diabetes.tab.txt>. A local copy is in [`data/diabetes.tab.txt`](data/diabetes.tab.txt).
- The supplied files do not define the units of progression, the serum variables, or which sex code is female or male, so sex is reported as "sex coded 1" and "sex coded 2".

## Research Questions

1. **Understand and prepare the data:** what data are available, and are there data-quality or data-use issues?
2. **Explore the data:** what are the most important characteristics of the dataset before modelling?
3. **Investigate relationships:** which variables look most promising for further analysis, and why?
4. **Build and interpret regression models:** what do the simple and multiple regression models tell us?
5. **Evaluate the analysis:** how much confidence should we have in the results, and what are the main uncertainties?
6. **Draw appropriate conclusions:** what can and cannot reasonably be concluded?

## Methods

- **Data preparation:** import, structure and type checks; sex converted to a factor; checks for missing values, duplicates and implausible values.
- **Exploratory analysis:** mean, median, SD, IQR and range; histograms and boxplots; outcome and BMI distributions; skewness and boxplot-fence counts.
- **Correlation analysis:** Pearson correlation matrix of the numerical variables (sex excluded), labelled heatmap, and scatterplots of progression against BMI and s5.
- **Simple regression:** progression on BMI, with s5 as a comparison.
- **Multiple regression:** model A (BMI + s5), model B (BMI + BP + s5), and model C (B plus sex as a categorical variable), compared using R², adjusted R², residual SE, AIC, BIC and nested F-tests.
- **Diagnostics and uncertainty:** residuals versus fitted values, Cook's distance and leverage, variance inflation factors, and coefficient estimates with 95% confidence intervals, t-values and p-values. Progression is left untransformed so coefficients stay easy to interpret.

## Key Findings

All numbers come from the R analysis in this repository.

- **Data quality:** no missing values, no duplicated rows and no impossible values. A few high serum values are kept in the analysis and noted as a caution.
- **Strongest associations with progression** (Pearson r): BMI 0.59, s5 0.57, blood pressure 0.44, s4 0.43. s1 and s2 are strongly correlated with each other (r = 0.90).
- **Simple regression:** progression = -117.77 + 10.23 x BMI; R² = 0.344. Patients with a BMI one unit higher have, on average, progression about 10.2 points higher.
- **Multiple regression:** model B explains R² = 0.480 (adjusted 0.477) versus 0.459 for model A. Holding the other predictors constant, one more BMI unit goes with about 6.5 points higher progression (95% CI 5.1 to 7.9), one more s5 unit with about 49.6 (38.0 to 61.2), and one more blood pressure unit with about 0.9 (0.5 to 1.3).
- **Evaluation:** variance inflation factors are at most 1.34 in models A and B. The residual plot shows a mild warning sign at low fitted values, and no single observation is highly influential. The residual standard error of model B is 55.8, compared with a standard deviation of progression of 77.1, so individual-level error is large.
- **Conclusion:** BMI and s5 are the most strongly associated characteristics, followed by blood pressure. The analysis is descriptive and makes no causal claims.

## Repository Structure

```
.
├── README.md
├── analysis/
│   ├── diabetes_analysis.R        # full analysis; saves figures to figures/
│   ├── diabetes_analysis.pdf      # the R script exported as PDF
│   └── export_script_pdf.R        # helper that exports the script as PDF
├── data/
│   └── diabetes.tab.txt           # the dataset
├── figures/                       # selected final figures (PNG and PDF)
├── report/
│   ├── analytical_report.Rmd      # report source
│   └── analytical_report.pdf      # final analytical report
├── presentation/
│   ├── presentation.Rmd           # slide source
│   └── presentation.pdf           # decision-maker presentation
└── assignment/
    ├── scenario1_brief.pdf        # project brief
    ├── portfolio_instructions.pdf # portfolio instructions
    └── starter_script.R           # original starter script
```

## Reproducibility

Requirements: R (4.x) with internet access on the first run, and a LaTeX installation (xelatex) plus pandoc to render the report and slides.

From a clean R session, run the analysis from the repository root:

```sh
Rscript analysis/diabetes_analysis.R
```

The script installs any missing packages (`ggplot2`, `dplyr`, `broom`), reads `data/diabetes.tab.txt` using relative paths, and saves the final figures into `figures/`. It also runs from inside `analysis/`.

To rebuild the report, the slides and the script PDF:

```sh
Rscript -e 'rmarkdown::render("report/analytical_report.Rmd")'
Rscript -e 'rmarkdown::render("presentation/presentation.Rmd")'
Rscript analysis/export_script_pdf.R
```

All numbers in the report and slides are computed in R from the data when they are rendered.

## Limitations

- The data appear to be observational, so associations should not be read as causal effects.
- Possible confounders are not in the data (for example diet and physical activity, medication, disease duration and severity, family history, smoking and socioeconomic factors).
- Progression has an unknown definition and units, the serum variables are unlabelled, and sex coding is undocumented.
- The residual plot shows a mild warning sign at low fitted values, and the models leave much individual-level variation unexplained.
- The source population is not described, and the models were fitted and evaluated on the same patients with no external validation.

## Deliverables

- Analysis: [`analysis/diabetes_analysis.R`](analysis/diabetes_analysis.R) ([PDF version](analysis/diabetes_analysis.pdf))
- Analytical report: [`report/analytical_report.pdf`](report/analytical_report.pdf) (source: [`report/analytical_report.Rmd`](report/analytical_report.Rmd))
- Presentation: [`presentation/presentation.pdf`](presentation/presentation.pdf) (source: [`presentation/presentation.Rmd`](presentation/presentation.Rmd))
- Figures: [`figures/`](figures/)

## Reflection

I found the course detailed but easy to follow. It was well structured, and the knowledge was introduced step by step in a logical order. The foundation paths were especially interesting, and the interactive plots were very helpful for understanding how regression works. The main difficulty was timing: most of the material was released close to the deadline, which left little time for detailed study.

Working on this project taught me how much care is needed to interpret regression results. A statistically significant coefficient is not necessarily large in practical terms, the BMI coefficient changed depending on which other predictors were in the model, and an association in observational data is not evidence of causation. With more time, I would like to check the models on separate data and examine the weaker fit at low predicted progression more closely.

## Author

Vasilis Chatzitolios
