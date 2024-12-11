# Documentation on CI/CD

All packages have automatic CI/CD using Github actions. Here is a general overview of what each GitHub Actions YAML file does in our projects:

1. **Style Check** ([.github/workflows/style.yaml](https://github.com/SticsRPacks/SticsRFiles/tree/main/.github/workflows/style.yaml))
   - **Purpose**: This workflow checks and enforces code style using the `styler` package. It runs on pull requests and can be manually triggered. It ensures that the R code adheres to the specified style guidelines and automatically commits any changes.

2. **R CMD Check** ([.github/workflows/check-standard.yaml](https://github.com/SticsRPacks/SticsRFiles/tree/main/.github/workflows/check-standard.yaml))
   - **Purpose**: This workflow runs R CMD check on multiple operating systems (macOS, Windows, Ubuntu) and R versions to ensure package compatibility and correctness. It is triggered on push and pull request events. This check verifies that the package can be built and installed, and that all tests pass without errors or warnings. If the tests are passing (*i.e.* there is no error), the action will then trigger the actions from another repository: SticsRTest, which provides more integrative tests by making real simulations with the model. The workflow uses the following Github action: `peter-evans/repository-dispatch`, which helps trigger actions from another repository. To setup this action, we need to use a personal access token. 
We use a "Fine-grained personal access token" that we setup in the personal repository of Rémi Vezy, and gave its value to each repository as a repository secret variable called `TRIGGER_PAT`.

3. **Pkgdown Site Build** ([.github/workflows/pkgdown.yaml](https://github.com/SticsRPacks/SticsRFiles/tree/main/.github/workflows/pkgdown.yaml))
   - **Purpose**: This workflow builds and deploys the pkgdown site to GitHub Pages. It is triggered on release events and can be manually triggered. The workflow ensures that the documentation website is up-to-date with the latest changes in the package.
 
4. **Update CITATION.cff** ([.github/workflows/update-citation-cff.yaml](https://github.com/SticsRPacks/SticsRFiles/tree/main/.github/workflows/update-citation-cff.yaml))
   - **Purpose**: This workflow updates the CITATION.cff file when a new release is published or when `DESCRIPTION` or `inst/CITATION` files are modified. It ensures that the citation information is current and accurate.

5. **Denpendabot** ([.github/dependabot.yml](https://github.com/SticsRPacks/SticsRFiles/tree/main/.github/dependabot.yml))
   - **Purpose**: This workflow checks if any new version exists for the GitHub actions used in this repository, and make a PR if it finds one.

6. **Coverage** ([.github/workflow/test-coverage.yaml](https://github.com/SticsRPacks/SticsRFiles/tree/main/.github/workflow/test-coverage.yaml))
   - **Purpose**: The purpose of this workflow is to measure the test coverage of the R package. This workflow is triggered on pushes and pull requests to the main branche. It uses the `covr` package to generate test coverage reports and uploads them to a coverage service like `Codecov`.

7. **Vdiffr** ([.github/workflow/vdiffr.yaml](https://github.com/SticsRPacks/CroPlotR/tree/main/.github/workflow/vdiffr.yaml))
   - **Purpose**: The purpose of this GitHub Action workflow is to perform snapshot comparison for visual regression testing in CroPlotR. This workflow is triggered on push and pull_request events. It sets up an R environment, installs necessary dependencies, and generates snapshots from the latest commit to compare visual outputs and ensure they remain consistent over time. The comparison is made with the plots generated with the main branch.


These workflows help automate various aspects of the CI/CD pipeline, ensuring code quality, compatibility, and proper documentation deployment.
