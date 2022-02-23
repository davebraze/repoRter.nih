## build and test setup

devtools::document()
devtools::check()

usethis::use_news_md()
usethis::use_vignette("repoRter_nih.Rmd", "repoRter.nih: a convenient R interface to the NIH RePORTER Project API")
usethis::use_testthat()
devtools::test()
devtools::test_coverage()

library(covr) # Test Coverage for Packages
covr::codecov(token = Sys.getenv("CODECOV_TOKEN"))
