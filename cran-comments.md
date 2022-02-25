## Test environments
- R-hub windows-x86_64-devel (r-devel)
- R-hub ubuntu-gcc-release (r-release)
- R-hub fedora-clang-devel (r-devel)

## R CMD check results
> On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... NOTE
  Maintainer: '"Michael Barr, ACAS, MAAA, CPCU" <mike@bikeactuary.com>'
  
  New submission
  
  Possibly misspelled words in DESCRIPTION:
    JSON (10:67)
    RePORTER (3:31, 11:65)
    tibble (14:24)

> On windows-x86_64-devel (r-devel)
  checking sizes of PDF files under 'inst/doc' ... NOTE
  Unable to find GhostScript executable to run checks on size reduction

> On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking examples ... NOTE
  Examples with CPU (user + system) or elapsed time > 5s
               user system elapsed
  get_nih_data 4.29   0.08   19.18

> On windows-x86_64-devel (r-devel)
  checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

0 errors v | 0 warnings v | 4 notes x

* This is a new release.
* There were no ERRORs or WARNINGs
