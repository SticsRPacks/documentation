# Documentation on CI/CD

All `SticsRPacks` repositories use GitHub Actions for checks, coverage, documentation, and integration testing.

## Main workflows

The package repositories (`CroPlotR`, `CroptimizR`, `SticsRFiles`, `SticsOnR`, `SticsRPacks`) now use the followin main CI workflows:

1. `check-standard.yaml`

   - Runs the standard `R-CMD-check`.
   - Triggered on `push` to `main` or `master`.
   - This is the workflow used for the README badge, so it stays independent from integration tests.

2. `pr-checks.yaml`

   - Triggered on `pull_request`.
   - Runs:
     - `R-CMD-check`
     - integration tests with the other packages at `main`
     - integration tests with the other packages at `release`
   - The integration jobs depend on the success of `R-CMD-check`.
   - Because this workflow is PR-triggered, the integration checks are visible directly from the PR page.

3. `integration-tests.yaml`

   - Triggered automatically after a successful `R-CMD-check` on `push` to `main` or `master`.
   - Also supports manual `workflow_dispatch`.
   - On post-merge runs, only the `release` integration mode is executed.
   - On manual runs, the workflow also lets us choose the `SticsRTests` ref to use.

4. `dependabot.yml`

   - Checks if any new version exists for the GitHub actions used in this repository, and make a PR if it finds one.

Other workflows remain repository-specific:

- `style.yaml`: style checks and optional auto-formatting.
- `test-coverage.yaml`: test coverage reporting.
- `pkgdown.yaml`: documentation website deployment.
- `update-citation-cff.yaml`: update of citation metadata.
- `vdiffr.yaml`: visual snapshot regression checks for `CroPlotR`. It sets up an R environment, installs necessary dependencies, and generates snapshots from the latest commit on the current branch and on the main branch to compare visual outputs and ensure they remain consistent over time.

## Reusable SticsRTests workflow

Integration tests are run using a reusable workflow:

- `SticsRTests/.github/workflows/integration-tests.yaml`

Each package repository calls it with:

- the repository under test
- the branch or SHA of the package under test
- a dependency mode for the other packages: `main` or `release`
- optionally, a `SticsRTests` branch/tag/SHA for manual runs

The reusable workflow:

1. checks out `SticsRTests`
2. resolves which refs to use for:
   - `SticsRPacks`
   - `SticsRFiles`
   - `SticsOnR`
   - `CroptimizR`
   - `CroPlotR`
3. installs the selected component packages and their dependencies
4. installs `SticsRPacks` afterwards with `dependencies = FALSE`
5. prints the selected refs and installed versions
6. runs `testthat::test_local()` from `SticsRTests`

This ordering is important:

- the component packages are installed first so the tested branch or SHA is respected
- `SticsRPacks` is installed afterwards with `dependencies = FALSE` so it does not reinstall packages from its own `Remotes`

## Dependency resolution

The CI now uses `r-lib/actions/setup-r-dependencies@v2` wherever possible.

Two patterns are used:

1. Standard package checks

   - `setup-r-dependencies` installs the package dependencies and caches them.
   - In `SticsRTests`, the workflow also reads `SticsRPacks/DESCRIPTION` so that CRAN dependencies required by `SticsRPacks` are installed too.
   - `SticsRPacks` itself is then installed separately with `dependencies = FALSE`.

2. Integration tests

   - `setup-r-dependencies` installs:
     - CRAN dependencies from `SticsRTests`
     - CRAN dependencies from the selected `SticsRPacks` ref
     - the selected GitHub refs for `SticsRFiles`, `SticsOnR`, `CroptimizR`, and `CroPlotR`
   - `SticsRPacks` is then installed separately with `dependencies = FALSE`

This keeps the dependency cache useful while avoiding ref conflicts between `main` and `release`.

## Manual triggering from GitHub

Each package repository has a manual integration workflow dispatch:

- open the `integration-tests` workflow in the GitHub Actions tab
- click `Run workflow`
- choose the branch of the package repository to run from
- optionally set `sticsrtests_ref` to a branch, tag, or SHA of `SticsRTests`

This is useful when validating a branch of `SticsRTests` without merging it first.

## Running workflows locally with act

[`act`](https://github.com/nektos/act) can be used to run some GitHub Actions workflows locally with Docker.

Important points:

- run `act` from the repository you want to test
- many of our workflows are not triggered by `push`, so you usually need to specify the event explicitly
- for Apple Silicon, use `--container-architecture=linux/amd64`

### List workflows seen by act

From a package repository:

```bash
act -l
```

### Run the manual integration workflow

Example local run:

```bash
act workflow_dispatch \
  -W .github/workflows/integration-tests.yaml \
  -j integration-tests \
  --input dependency_mode=main \
  --input sticsrtests_ref=main
```

This will run the `integration-tests` job from the `integration-tests.yaml` workflow, with the `main` branch of `SticsRTests` and the `main` branches of our packages as dependencies. It will of course use the local branch of the package repository as the tested ref.
