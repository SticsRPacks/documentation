# CRAN submission

This is the procedure to submit a package to CRAN, either for a new submission or a new version.

## Good practices

Before any submissions, please check that you follow SticsRPacks' good practices.

There are two things to do to ensure the basics:

- use [{goodpractices}](http://mangothecat.github.io/goodpractice/):

    ```r
    library(goodpractice)
    goodpractice::gp()
    ```
Special :
+When find "1:length(...)" replace by seq_along
+gp warn about setwd() use but the code looks correct by using on.exit

- Use [{styler}](https://styler.r-lib.org). Then use it from the add-in menu in R-Studio, or on the full package using:

    ```r
    library(styler)
    style_pkg()
    ```

    Or more simply `usethis::use_tidy_style()`

Make sure to make those steps on a clean git repository (*i.e.* make a commit **before**) to be able to revert the changes easily.

## Checks

Here is a checklist that you must follow before any submission to the CRAN:
- [ ] Update (aspirational) install instructions in README
- [ ] Check that all exported functions have @return (use "@return None" if nothing is returned), and @examples
- [ ] Exported functions examples: use of \dontrun when examples cannot really be executed or execution time is > 5 s
- [ ] Unexported functions: their documentation is useful for developers, but avoid producing Rd files using the keyword '@noRd' additionally to '@keywords internal'
- [ ] Functions calls (examples, tests): no need to use library(PackageName), PackageName:: or PackageName::
- [ ] In examples/vignettes/tests: writing in the user's home filespace (including the package directory and getwd()) is not allowed by CRAN policies.
      Use the 'tempdir()' for that.
- [ ] Do not use getwd() as a default value for function arguments
- [ ] Do not write in library directory or package directory
- [ ] Instead of print()/cat() rather use message()/warning()  or if(verbose)cat(..) (or maybe stop()) if you really have to write text to the console.
(except for print, summary, interactive functions) 
- [ ] Review extra-checks that may e useful: https://github.com/DavisVaughan/extrachecks
- [ ] Check that your licence is on [this list](https://svn.r-project.org/R/trunk/share/licenses/license.db). If not, you'll probably won't be able to publish your package.
- [ ] Check the name of the package is not in [this list](https://cran.r-project.org/src/contrib/Archive/).
- [ ] Check that all imported or suggested packages are available on CRAN. If any mentioned in ‘Suggests’ or ‘Enhances’ fields are not from such a repository, where to obtain them at a repository should be specified in an ‘Additional_repositories’ field of the DESCRIPTION file (as a comma-separated list of repository URLs)
- [ ] Tidy-up the DESCRIPTION file using `usethis::use_tidy_description()`
- [ ] Make sure the package is not larger than 5MB on disk. Data should be compressed when possible.
- [ ] Make sure you are running with one of the latest R versions
- [ ] Update all of your packages: `update.packages()`
- [ ] Check that your package does not return any error, warning or notes on you system (ctrl+shift+B)
- [ ] Check that all tests on Github actions are passing, including the ones in SticsRTests (this for us, not for CRAN). The actions should use R-devel too.
- [ ] Check your package using [{inteRgrate}](https://jumpingrivers.github.io/inteRgrate/):
  - `check_pkg()`
  - `check_lintr()`
  - `check_namespace()`
  - `check_r_filenames()`
  - `check_version()`
  - `check_gitignore()`
  - `check_readme()`
  - `check_tidy_description()`
  - `check_file_permissions()`
  - `check_line_breaks()`
- [ ] Check URLs are correct (CRAN checks it and can refuse your package):

    ```r
    # remotes::install_github("r-lib/urlchecker")
    urlchecker::url_check()
    urlchecker::url_update()
    ```

- [ ] Spell check (you have to add it first using `usethis::use_spell_check()`): `spelling::spell_check_package()`. Packages can be refused for spelling errors. Try to check that packages are spelled between `'` (*e.g.* 'dplyr') and acronyms capitalized in the DESCRIPTION file
- [ ] Make a good DESCRIPTION file, especially the Description section that should be a full paragraph.
- [ ] Generate the `cran-comments.md` file using `usethis::use_cran_comments()`. This file is used to prove everything works and allow us to add comments (*e.g.* to explain notes). Make sure the file is tracked by Git and add it to `.Rbuildignore`.
- [ ] Checking with Rhub is now done in the package repository as a github action (see how to install it [here](https://blog.r-hub.io/2024/04/11/rhub2/#set-up-r-hub-v2) done by default on the main branch
- [ ] Check the results from the Rhub action looking at the artefact for each platform (linux, win,mac). It shouldn't return any error, warning or notes. If some notes are returned, you should address them, or prepare to explain why they appear (must be a good reason!)
- [ ] Add the output of Rhub check to the `cran-comments.md` file, or write one following the example from the [R Packages book here](https://r-pkgs.org/release.html#release-process).
- [ ] Check for reverse-dependencies if it is not the first release. [See more information here](https://r-pkgs.org/release.html#release-deps). Add the output to the `cran-comments.md` file, if first submission, write that you don't have any downstream dependencies yet.
    - install devtools::install_github('r-lib/revdepcheck')
    - for the first time execute usethis::use_revdep()
    - execute dep_check <- revdepcheck::revdep_check(num_workers = 4)
    - revdep check results are written in a `revdep` folder 
- [ ] Update README.md (devtools::build_readme(), if necessary) and NEWS.md.

When everything is checked, you can finally:

```r
devtools::release()
```
or

```r
devtools::submit_cran()
```
At this stage, you should increment the version number of you package so you don't forget in the future.

You'll receive an email few minutes after you submission. Then CRAN maintainers will get in touch in about 1 to 5 days.

If your submission fails, follow [the steps from the R Packages book](https://r-pkgs.org/release.html#on-failure). You can also look into [these recommendations](https://github.com/DavisVaughan/extrachecks) to better understand rejections.

If your submission passes, **make a new release on Github**. 
After submission, a `CRAN-SUBMISSION` file has been created which can be used for creating a new release using:  
```r
usethis::use_github_release()
```

## Badges

We can add badges to our README to notify the version that is on CRAN, whether it passes official CRAN checks or not, and the number of downloads. More details here: <https://docs.r-hub.io/#badges>

### Cran badge

One example of CRAN badge would be this one: <https://www.r-pkg.org/badges/version-ago/{package}>

Which gives something like the following for *e.g.* {dplyr}: ![](https://www.r-pkg.org/badges/version-ago/dplyr)

### Download count

We can display the number of downloads using the following badge: <https://cranlogs.r-pkg.org/badges/grand-total/{package}>, *e.g.* for {dplyr}: ![](https://cranlogs.r-pkg.org/badges/grand-total/dplyr)

### CRAN tests

We can display a badge to show whether the package passes official CRAN checks or not: <https://cranchecks.info/badges/summary/{package}>, *e.g.* for {dplyr}: ![](https://cranchecks.info/badges/summary/dplyr)

One can also add the link to the CRAN checks like so:

```md
[![cran checks](https://cranchecks.info/badges/summary/{package})](https://cran.r-project.org/web/checks/check_results_{package}.html)
```

At the moment this badge will be red if any error, warning or notes are found in CRAN checks. This is very conservative.

## More resources

The CRAN policy to submit packages: <https://cran.r-project.org/web/packages/policies.html>

The writing R extension official page: <https://cran.r-project.org/doc/manuals/r-release/R-exts.html>

R Packages by Hadley Wickham and Jenny Bryan: <https://r-pkgs.org/>

ThinkR prepare for CRAN: <https://github.com/ThinkR-open/prepare-for-cran>

A 20 steps - checklist: <https://www.marinedatascience.co/blog/2020/01/09/checklist-for-r-package-re-submissions-on-cran/>
