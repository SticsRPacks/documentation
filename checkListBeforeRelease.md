
* update doc: ctrl-shift-D
* build the package: ctrl-shift-B
* check the package: ctrl-shift-E
* check SticsRTest with the current state of the package and the last release of the other ones
* change version number: usethis::use_version(which="major" or "minor" or "patch")
* update the Date field in DESCRIPTION file
* update NEWS file (can use the script tools/git-changelog-with-tags.sh)
* commit and push changes
* check github actions tests
* check SticsRTest results (done with the master version of the other packages ...)
* create the new release in github (copy changes described in NEWS file in the changes section of the new release)
* check the package website (generated on release) 
