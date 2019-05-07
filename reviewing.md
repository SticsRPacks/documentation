# Reviewing

The SticsRPacks project has adopted a set of rules for proper coding, and one of the most important is the systematic review of each changes using pull requests.

The code review is an important process to ensure that the package is developed following the rules of the SticsRPacks project, but also that the changes proposed by a contributor are working, that they don't break the package or any other intercations with other packages.

This document present a step-by-step checklist for reviewing the code of other contributors:

+ The code follows the style guidelines of this project
+ The code is commented, particularly in hard-to-understand areas
+ The documentation has been updated if necessary
+ The changes generate no new errors, warnings or notes during the tests (package or CRAN tests)
+ New tests have been added on the package to prove the fix is effective or the new feature works
+ New and existing unit tests pass locally and remotely with those changes

The reviewer should always be nice to the contributor, regardless of the quality of the contribution. Everyone should have a chance to contribute, even begginers that do not have acquired yet the necessary knowledge to contribute nicely. The answer should always be positive, but also constructive. If the contributor made a mistake, try to guide him/her as much as possible on how to fix the issue. 

A more visual exemple of the workflow can be found in the sandbox vignette [here](https://sticsrpacks.github.io/sandbox/articles/use-git-and-github.html#review).
