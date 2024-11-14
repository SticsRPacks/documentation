
* update doc: ctrl-shift-D
* build the package: ctrl-shift-B
* check the package: ctrl-shift-E
* check and correct URLs: `urlchecker::url_update(path = ".", results = urlchecker::url_check("."))`, and then `urlchecker::url_check(".")` to check if everything has been updated
* check using Rhub: `check = rhub::check_for_cran()`.
* check the results from Rhub: `check$cran_summary()`. It shouldn't return any error, warning or notes. If some notes are returned, you should address them, or prepare to explain why they appear (must be a good reason!)
* add the output of `check$cran_summary()` to the `cran-comments.md` file, or write one following the example from the [R Packages book here](https://r-pkgs.org/release.html#release-process).
* check for reverse-dependencies if it is not the first release. [See more information here](https://r-pkgs.org/release.html#release-deps). Add the output to the `cran-comments.md` file, if first submission, write that you don't have any downstream dependencies yet.
* rebuild and check README.md
* check SticsRTest with the current state of the package and the last release of the other ones
* change version number: usethis::use_version(which="major" or "minor" or "patch")
* update the Date field in DESCRIPTION file
* update NEWS file (can use the script tools/git-changelog-with-tags.sh)
* commit and push changes
* check github actions tests
* check SticsRTests results (done with the main branch of the other packages ...)
* change the version number in the citation.cff file (it will be automatically updated with dependencies information when a release is published)
* create the new release in github (copy changes described in NEWS file in the changes section of the new release)
* check the package website (generated on release) 
