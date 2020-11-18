
* update dependencies in DESCRIPTION file (in part. version number of other Stics packages)
* change version number: usethis::use_version(which="major" or "minor" or "patch")
* update NEWS file
* generate pdf doc using build_manual()
* update doc: ctrl-shift-D
* build the package: ctrl-shift-B
* check the package: ctrl-shift-E
* update the website: pkgdown::build_site(lazy=TRUE)
* check TRAVIS ...
* trigger SticsRTest in TRAVIS and check it works fine
* commit and push changes
* Create the new release in github (copy changes described in NEWS file in the changes section of the new release)
