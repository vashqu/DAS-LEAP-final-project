# Export analysis/diabetes_analysis.R as a PDF listing (code is not executed).
# Run from the repository root or from analysis/.
root <- if (file.exists("analysis/diabetes_analysis.R")) "." else ".."
script <- normalizePath(file.path(root, "analysis", "diabetes_analysis.R"))
tmp <- tempfile(fileext = ".Rmd")
writeLines(c(
  "---", "title: \"diabetes_analysis.R\"", "author: \"Vasilis Chatzitolios\"",
  "output:", "  pdf_document:", "    latex_engine: xelatex",
  "geometry: margin=1.5cm", "fontsize: 10pt", "---", "",
  "```{r, eval=FALSE, code=readLines(script)}", "```"
), tmp)
rmarkdown::render(tmp, output_file = "diabetes_analysis.pdf",
                  output_dir = normalizePath(file.path(root, "analysis")),
                  envir = list2env(list(script = script)), quiet = TRUE)
