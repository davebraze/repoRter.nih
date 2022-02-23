## build and test setup
## following https://www.mzes.uni-mannheim.de/socialsciencedatalab/article/r-package/#subsection4-4
## maybe some other things I found

devtools::document()
devtools::check()

usethis::use_news_md()
usethis::use_vignette("repoRter_nih.Rmd", "repoRter.nih: a convenient R interface to the NIH RePORTER Project API")
usethis::use_testthat()
devtools::test()
devtools::test_coverage()

usethis::use_build_ignore("build_test.R")

library(covr) # Test Coverage for Packages
covr::codecov(token = Sys.getenv("CODECOV_TOKEN"))

rhub::check_for_cran()

#check for win-builder
devtools::check_win_devel()


# Check for CRAN specific requirements using rhub and save it in the results 
# objects
results <- rhub::check_for_cran()

# Get the summary of your results
results$cran_summary()

# Generate your cran-comments.md, then you copy-paste the output from the function above
usethis::use_cran_comments()


## skipping this for now, may revisit later release
libary(goodpractice)
goodpractice::gp()

devtools::install_git("https://github.com/jumpingrivers/inteRgrate")
library(inteRgrate)
check_lintr() # lots to fix
check_tidy_description()
check_gitignore()

