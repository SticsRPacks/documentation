# Git Workflow Guidelines (Issues · Branches · Commits · Pull Requests)

This document describes the conventions used in **SticsRPacks** for
writing issues, naming branches, writing commit messages, and managing
pull requests.\
The goal is to maintain clean project history, consistent changelogs,
and a smooth collaboration workflow.

------------------------------------------------------------------------

# 1. Issue Writing Conventions

## 1.1 Issue Title Format

Use the following structure:

    <verb> <type of problem> <context>

### Common verbs
  
  * **Fix**        bug or unexpected behavior
  * **Add**       new feature or capability
  * **Update**     improving an existing component
  * **Remove**     deletion of obsolete code
  * **Refactor**   internal restructuring
  * **Document**   documentation request
  * **Test**       request for test improvements
  

### Examples

    Fix bug in scatter plot labels with ggplot2 4.0.0
    Add support for global optimization algorithms
    Refactor data import functions for clarity
    Test calibration workflow on maize dataset

------------------------------------------------------------------------

## 1.2 Issue Body Structure

If your IDE provides a template, please use it. If no template is available, follow the structure described below.

    ### Description
    Describe the problem or objective clearly.

    ### Expected behavior
    What should happen ideally?

    ### Current behavior
    What happens instead? Include errors if relevant.

    ### Steps to reproduce
    1. ...
    2. ...
    3. ...

    ### Proposed solution (optional)
    Ideas for how to fix or improve the issue.

    ### Additional context (optional)
    Versions, platform, links, screenshots, etc.

------------------------------------------------------------------------

## 1.3 Cross-References

### Reference an issue

    #82

### Reference from another repo

    SticsRPacks/CroPlotR#82

### Reference a commit

    SticsRPacks/SticsRFiles@8540c13

GitHub automatically creates backlinks.

------------------------------------------------------------------------

## 1.4 Issue Labels

Add labels, it helps a quick identification of the type of tasks.

------------------------------------------------------------------------

## 1.5 When to Split an Issue

Split an issue when:

-   It contains unrelated tasks\
-   It would lead to an oversized PR\
-   It cannot be completed by one person\
-   It mixes refactor + fix + feature

Clear issues → clearer branches → cleaner PRs.

------------------------------------------------------------------------

# 2. Branch Naming

### Format

    <type>/<short-description>

### Branch Types

  * **feat/**:   new functionality
  * **fix/**:                bug fix or compatibility fix
  * **refactor/**:           internal restructuring with no behavior change
  * **chore/**:              maintenance, dependencies, CI/CD, cleanup
  * **docs/**:               documentation changes
  * **test/**:               addition or modification of tests
  * **release/**:            preparing a new release

### Rules

-   Short description in **English**, **kebab-case**, concise and
    explicit.\
-   Recommended: include the **issue number** when relevant.

### Examples

    feature/global-optimization-interface
    fix/82-ggplot2-4.0-scatter-compat
    refactor/code-cleaning
    chore/limit-ggplot2-version
    test/add-calibration-tests

------------------------------------------------------------------------

# 3. Commit Messages (Conventional Commits)

### Format

    <type>(<scope>): <short description> (#issue)

### Types

  * **feat**:       new feature
  * **fix**:        bug fix
  * **docs**:       documentation only
  * **style**:      formatting only, no logic change
  * **refactor**:   internal restructuring
  * **perf**:       performance improvement
  * **test**:       unit tests
  * **chore**:      maintenance, CI, dependencies
  * **ci**:         CI/CD or workflow changes

### Rules

-   Message in **English**, **imperative form**, concise.\
-   Include related **issue number** whenever possible: (#82)\
-   PR number should *not* appear in commits.

### Examples

    fix: handle ggplot2 4.0.0 label changes (#82)
    chore(deps): limit ggplot2 version to < 3.5.2 (#84)
    refactor: clean scatter plot internals
    test: add ggplot2 v4 compatibility tests (#86)
    docs: update README with installation instructions
    ci: temporarily disable Linux tests (#90)

------------------------------------------------------------------------

# 4. Pull Request Conventions

### PR Title Format

    <type>: <short description>

### Examples

    fix: ggplot2 4.0.0 compatibility for scatter plots
    chore: limit ggplot2 dependency version
    refactor: restructure plotting functions
    feat: add global optimization interface

### PR Description Template

If your IDE provides a template, please use it. If no template is available, follow the structure described below.

    ### Problem
    Explain what was wrong.

    ### Solution
    Describe what has been changed and why.

    ### Additional changes
    (Optional) List refactors or cleanup tasks.

    ### Tests
    Describe how the change was tested.

    ### Linked issues
    Closes #<issue-number>

### Draft Pull Requests

-   Use "Convert to draft" for work-in-progress.\
-   Use "Ready for review" when the PR is complete.

------------------------------------------------------------------------

# 5. Summary Diagram

    issue #82 ─────► branch: fix/82-ggplot2-4.0-scatter-compat
                         │
                         ▼
            fix: handle ggplot2 4.0.0 (#82)
                         │
                         ▼
    Pull Request: fix: ggplot2 4.0.0 compatibility for scatter plots
                         │
                      Closes #82

------------------------------------------------------------------------
