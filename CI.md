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

These workflows help automate various aspects of the CI/CD pipeline, ensuring code quality, compatibility, and proper documentation deployment.
