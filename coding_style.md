# SticsRpacks Coding Style


## Introduction

This document aims at providing rules for the development of the [SticsRpacks](https://github.com/SticsRPacks) packages.

It is based on the [style guide](http://adv-r.had.co.nz/Style.html) from Hadley Wickham, extended with specific topics related to our organisation.


## Naming conventions

### File names and extensions

*	File names should exactly corresponds to the function name it includes (if only one function per file, preferred)
*	Files names are always written in english
*	File names must be meaningful (using [nouns and then] verbs,...)
    + e.g. a set of action verbs to be used: set, get, select, filter, read, write, ...
*	... but they must not be too long (<20 characters if possible)
*	Special characters are prohibited
*	Words must be separated exclusively with "_" (snake case)
*	The file extension is always : .R

### Object/variable names
*	As for file names words must be separated exclusively with "_" (snake case)
* Variables/objects names contain nouns (not verbs)
*	Avoid using names of existing variables or built in functions
    +	T, F
    +	c
    +	...
    +	sum, mean, ...

## Syntax

### Spacing
*	Insert spaces around operators: +, -, \*, <, ... and assignement <-, =
*	... but neither around : nor ::  
    + `X <- 1:10`
    +	`package::func_name`
*	Put a space after a coma
*	Put spaces around braces (before opening brace and after closing brace), except for a function call  
    &emsp;&emsp;`if (x > 10) {`

### Braces
*	Allow single conditional instruction to be on one line if the line is inferior to the authorized size limit but let the curly braces :  
  &emsp;&emsp;`if (x > 10)  { X - 10 }`
*	Use curly braces even if a test bloc contains only one instruction
*	An opening curly brace must not be on its own line, but a closing one do
*	Always indent code inside curly braces
*	An else statement should always be surrounded on the same line by curly braces.  
    &emsp;&emsp;`If (condition)  {`  
    &emsp;&emsp;&emsp;&emsp;`...`  
    &emsp;&emsp;`} else {`  
    &emsp;&emsp;&emsp;&emsp;`...`  
    &emsp;&emsp;`}`

### Line length and bloc formatting
*	It is recommended to limit line length to 80 characters (more comfortable for editing and printing). It is possible to add a delimitation line in `RStudio` at a given
character length: Tools -> Global Options -> Code -> Display -> Show margin.

Indentation:  
*	Indent code with 2 spaces
*	Except for a multi line function call, lines must be aligned under the function definition start  
    &emsp;&emsp;`functionName(a= .....,`  
    &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;`b= ......)`

### Assignment
*	The common assignment sign is <-, but we allow to use =

## External packages

* Add external packages using `usethis` as follows: `usethis::use_package("package_name")`.     
* Use functions from external packages as follows: `package_name::some_function()`. This format increase readability and maintenance.  

## Organization

### Commenting
*	Comment lines begin with a # sign followed by a single space
*	Short comments can be placed after code preceded by two spaces
*	Comment aim is to tell which purpose the following lines are for
*	Don't put useless comments about what the code does!
*	Comments may be used for separating/identifying easily code blocks. Use - - -:  
    &emsp;&emsp;`# Title part I ------------------`  
    &emsp;&emsp;`# Title part II -----------------`

### Test
*	Argument type must be checked but only for main functions


---------------  
Back to [Table of contents](README.md)
