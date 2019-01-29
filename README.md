# SticsRPacks documentation

This document aims at enhancing the collaboration between authors in the project, and makes it as frictionless as possible. Experienced developers will find a brief description of the workflow and tools in the TL;DR, others will find a short introduction to each along with some recommended sources.

## TL;DR

Confirmed developers will certainly already know the tools used in this project. Here is a little summary of the workflow and tools we use:
+ RStudio
+ GIT for versioning
+ Github as a remote repository, along with several integrated tools:
    + TRAVIS CI and AppVeyor for continuous integration (build package + run unit tests)
    + Github issues for collaboration
    + Github pages for documentation as a website
    + ZENODO for citation + versioning
+ H. Wickham for [R style guide](http://adv-r.had.co.nz/Style.html), except `=` is accepted because `<-` has no added value.
+ Package features:
    + pkgdown is used for building the website from package documentation
    + roxygen2 is used with markdown option for documentation
    + usethis is used to start the package skeleton (with news + readme + code of conduct)
    + testthat is used for unit tests
    + vignettes are used to describe the package features and workflow with figures when possible

The following paragraphs add more details on the workflow.

## TOOLS

1.	RSTUDIO  
The IDE used in our projects is [RSTUDIO](https://www.rstudio.com/). This IDE is free and is widely used in the R community because of the numerous tools that comes along. The best resource to develop R packages is the book from Hadley Wickham available freely [here](http://r-pkgs.had.co.nz/intro.html).

1.	GIT  
The cornerstone of efficient collaboration is [GIT](https://git-scm.com/). If you do not know what GIT is, it is probably the most important tool you will learn, and the one that will help you the most for coding.
There are many resources available on the internet to learn about GIT. In our opinion, the most intuitive is the tutorial from Atlassian available [here](https://www.atlassian.com/git/tutorials) or in French [here](https://fr.atlassian.com/git/tutorials). The reference among all references is the [GIT book](https://git-scm.com/book/en/v2), which is available on many languages (including French), and can be downloaded to read as a PDF or better, as an e-book. Another good reference is the one from [Github](https://guides.github.com/). The main benefit to follow the latter is that we use Github in the project, so all examples are already adapted to our workflow.

1.	GITHUB  
In the project, we use GIT as a tool for code versioning, and we have a remote repository on Github. When you learn GIT, you will learn about how both GIT and Github combine in a very powerful tool.
A good introduction to the way GIT, GITHUB and RSTUDIO link together is available from [the book of Hadley Wickham](http://r-pkgs.had.co.nz/git.html). GIT and GITHUB can be managed directly from RSTUDIO, but it is possible to use different tools such as [Github-desktop](https://desktop.github.com/) along with [Atom](https://atom.io/) for the text editing. The main benefit of using these is that Github develop them so they integrate well with the different tools integrated in their website.

  If you want to develop a new package, please ask the maintainer of `SticsRpacks`  to create a new repository with the name of your package in the STICS organisation from GITHUB. He will then add you as a collaborator in the repository. If you want to contribute to a package, please read first the “Contributor Code of Conduct”.

## ASKING FOR HELP

1.	HELP  
Type your issue with keywords into your favourite search engine and search for answers in websites such as [Stack Overflow](https://stackoverflow.com/), where someone else has certainly already encountered the same issue.

1.	Github issues  
It is highly recommended to use the Issues from Github to improve the collaboration. It centralizes all issues of a project so users can filter them by labels, view if their issue has been already issued and/or answered, and can be managed from GIT. Please find some help [here](https://guides.github.com/features/issues/).

1.	MOOC  
A good way to start with those tools is by watching the data science specialization from John Hopkins University on Coursera available [here](https://www.coursera.org/specializations/jhu-data-science). The particular course about the tools is [this one](https://www.coursera.org/learn/data-scientists-tools). You can follow each course freely if you register to each independently, and if you click on the “free listener” link.

## WORKFLOW

When a developer wants to contribute to the development of a package, he should follow this standard workflow:

1.	Learn  
Learn how to use all tools cited previously.

1.	Use GIT + GITHUB  
Use version control, and make a commit on every little step with informative commit messages. Avoid messaged such as `improved functions X` or `modified readme`, and prefer `Use data.table in function X to reduce reading time` or `Added information about authors in readme`.  
Close issues using commit messages when possible (e.g. `closes #10`). This will help others to understand how it was resolved. Please find some help [here](https://help.github.com/articles/closing-issues-using-keywords/).

1.	Branches VS Forking  
Make your own branch if you want to develop something rather short and that will not be a hassle to implement back to the main branch for the maintainer. Use forking if you implement something bigger that will need thorough reviewing by others.

1.	Unit tests  
Each function has to be tested, even for functions that use data. If the data is rather confidential, use dummy data. The only exception is functions that call external executables (in that case, external tools test them). The [`testthat`](https://testthat.r-lib.org/) package is the reference tool for testing. Dummy data are always located in the `tests/testthat` folder and each dataset is located in separate folders, e.g. `tests/testthat/example_data`.

1.	Documentation  
All functions must be documented using [`Roxygen2`](https://github.com/klutometis/roxygen), even functions that are not exported. R vignettes are used to complement the help pages. At least one vignette must be present in the package: the “Introduction to X package”. This vignette must document the workflow of the package to help new users understand how the main functions are used. Figures are strongly recommended. Vignettes can be easily created using [`usethis::use_vignette()`](http://usethis.r-lib.org/reference/use_vignette.html).
The [`pkgdown`](https://pkgdown.r-lib.org/) package is used to make the html version of the documentation to publish as a Github page. The website is always located in the “docs” folder.

1.	Preferred packages  
Prefer using the packages already used in other `SticsRpacks`  packages or on related projects, such as `dplyr`, `magritrr`, `data.table`...  

1.	Error handling  
We strongly recommend setting error and warning handling to your code whenever possible. A good start is by using the trycatch function. See [here](https://stackoverflow.com/a/12195574) for a little help.

1.	Reviewing  
At least one collaborator must review the code. This step is easy when forking, but can be difficult when branching. If you made your own branch, please ask a review before merging.

1.	Style guide (format)  
We adopted the [R style guide](http://adv-r.had.co.nz/Style.html) from H. Wickham, except `=` is accepted because `<-` has no real added value. Please adopt the coding style of the team, or at least have a consistent coding style. Only comment when necessary and up-date the comments when the code changes.

1.	Build  
You need `devTools` and `Rtools` to build the package.

## Sandbox

The [`sandbox`](https://github.com/SticsRPacks/sandbox) repository was created to help newcomers use the different tools for the first time. You can read further [documentation in this repository](https://github.com/SticsRPacks/sandbox/blob/master/README.md).

---------------  
Back to [Table of contents](table_of_contents.md)
