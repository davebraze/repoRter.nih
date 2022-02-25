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
    RePORTER (3:31, 11:65)
    tibble (14:15)
  
  Found the following \keyword or \concept entries
    JSON (10:67)
  which likely give several index terms:
    File 'get_nih_data.Rd':
      \keyword{NIH,}
      \keyword{coronavirus,}
      \keyword{covid-19,}
      \keyword{federal,}
      \keyword{funding,}
      \keyword{research,}
    File 'make_req.Rd':
      \keyword{grant,}
      \keyword{NIH,}
      \keyword{coronavirus,}
      \keyword{covid-19,}
      \keyword{federal,}
      \keyword{funding,}
      \keyword{grant,}
      \keyword{research,}

> On windows-x86_64-devel (r-devel)
  checking sizes of PDF files under 'inst/doc' ... NOTE
  Unable to find GhostScript executable to run checks on size reduction

> On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking examples ... NOTE
  Examples with CPU (user + system) or elapsed time > 5s
               user system elapsed
  get_nih_data 2.56   0.13   16.53

> On windows-x86_64-devel (r-devel)
  checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

0 errors | 0 warnings | 4 notes

* This is a new release.
