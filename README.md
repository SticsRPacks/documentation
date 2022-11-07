# SticsRPacks documentation

Welcome to the documentation of the `SticsRPacks` project.

## General Documentation

+ [A general overview](overview.md) - a brief, general overview of the developing workflow and tools used in the project and where to find them.
+ The [`sandbox`](https://github.com/SticsRPacks/sandbox/blob/master/README.md) - an example project to introduce step by step all the tools described in the `SticsRPacks` documentation with use cases. The users can clone this project and use the tools. It is strongly recommanded to read the documents in this project before doing anything.
+ The [reviewing process](reviewing.md) - a tutorial on how to review other contributors changes.
+ The [coding style](coding_style.md) - the coding style guide for our project.
+ The [optimum data structures](data_structure.md) - evaluation of different data structures such as `data.frame`, `data.table`, `tibble`, `list`, multi-dimensional `arrays` for their performance (memory, execution time, ease of use) in read/write, selection, computation, etc...
+ The [procedure to deprecate](deprecation.md) functions or arguments
+ The [procedure for CRAN](cran-submission.md) (re-)submission
+ The [checklist](checkListBeforeRelease.md) to control before releasing new versions of the packages 

## Package documentation

Each package has its own documentation living in its repository or website. The website of each package can be found at: <https://sticsrpacks.github.io/{packagename}/>. For example the website for the sandbox project is located here: <https://sticsrpacks.github.io/sandbox/>

### Sandbox

The `sandbox` repository is an R package that was specifically created to help new people to learn the basis of all tools used in the project. It is strongly advised to read the documents from this project before starting anything.

+ [Project](https://github.com/SticsRPacks/sandbox) - the github repository
+ [Website](https://sticsrpacks.github.io/sandbox/) - the repository website

### SticsRFiles

The `SticsRFiles` package was designed read and write the input and output files for STICS either for the xml files or directly for the text files (*e.g.* `ficplt.txt` or `var.mod`).

+ [Project](https://github.com/SticsRPacks/SticsRFiles) - the github repository
+ [Website](https://sticsrpacks.github.io/SticsRFiles/) - the repository website

### SticsOnR

The `SticsOnR` package was designed to control STICS from R *e.g.* create USMs and simulations instances, run the `STICS` model, extract the raw results, etc...

+ [Project](https://github.com/SticsRPacks/SticsOnR) - the github repository
+ [Website](https://sticsrpacks.github.io/SticsOnR/) - the repository website

### CroptimizR

A package for parameter estimation, uncertainty / sensitivity analysis for the STICS model using R.

+ [Project](https://github.com/SticsRPacks/CroptimizR) - the github repository
+ [Website](https://sticsrpacks.github.io/CroptimizR/) - the repository website
