# Install a package from GitHub

It is common to have two kind of issues when installing the packages:

- "cannot remove prior installation of package ‘*****’"
- API rate limit exceeded for ****

You'll find below the solutions for these issues.

## A package cannot be installed because it is already loaded

These errors do not come from the `SticsRPacks` package, but from R. It is a rather known issue for other packages (such as `tidyverse`). The problem is stated in the error: "cannot remove prior installation of package ‘*****’" means that R couldn't delete the current version of the package so it couldn't install the new one at the same place. 

The work-around can be to:

-  Terminate all R sessions running, including the one you are using right now because:
    * if R is running elsewhere and uses the package, a lock is placed on its folder so it can't delete it; 
    * the state of the session you are using could be retrieved from the previous session (terminate from the Session tab -> Terminate R);
   Then retry `devtools::install_github("SticsRPacks/SticsRPacks")`

- If the previous answer didn't work, install the package ‘*****’ named at the end of the error message manually, *e.g.* `install.packages("tibble")`, and see what is the output of the installation. If it works, you can proceed with the installation of `SticsRPacks`, if not, try to delete the previous installation manually from your library (you can find the path using `.libPaths()`).

- If the error of installation concerns one of SticsRPacks packages, the error arise from the package itself, not from `SticsRPacks`. So open an issue on the package repo directly. Of course test by yourself to install it directly (*e.g.* `devtools::install_github("SticsRPacks/SticsOnR")`) before. Or you can also try to build it yourself from the code to check for the errors.

Alternatively, you can use `{pak}` instead of `{devtools}`, and it will probably work better for the installation:

```r
install.packages("pak")
```

Then use pak to install `{SticsRPacks}` like so:

```r
pak::pkg_install("SticsRPacks/SticsRPacks")
```

## A package cannot be installed because of a rate limit

This error is due to the fact that you have reached the limit of GitHub API calls. It is a limit imposed by GitHub to avoid spamming their servers.

The typical error looks like:

```r
> remotes::install_github("SticsRPacks/SticsRPacks", force = TRUE)
Downloading GitHub repo SticsRPacks/SticsRPacks@HEAD
Error: Failed to install 'SticsRPacks' from GitHub:
  Unknown remote type: github
  Cannot find repo SticsRPacks/CroPlotR.
HTTP error 403.
  API rate limit exceeded for XXX.XXX.XXX.XXX. (But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)

  Rate limit remaining: 0/60
  Rate limit reset at: 2023-02-09 15:33:57 UTC

  To increase your GitHub API rate limit
  - Use `usethis::create_github_token()` to create a Personal Access Token.
  - Use `usethis::edit_r_environ()` and add the token as `GITHUB_PAT`.
```

The solution is to create a GitHub personal access token (PAT) and use it to install the package. A PAT is a little bit like a password. You can follow the instructions on the [GitHub documentation](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token) to create a PAT. 

Or you can use the function `usethis::browse_github_pat()` to create it directly from R. It will open Github for you to create the token. If you don't have an account on GitHub, you'll have to create one first. Then, you'll have to choose a name for your token, for example Rtoken, and select the scopes you want to give to the token. The scopes are the permissions you give to the token. You can select all the scopes, but it is not recommended. The minimum scope you need is `repo`. Then you'll have to click on the `Generate token` button. Finally, copy the token.

Then, from R again, execute the following: `usethis::edit_r_environ()`. It will open file (`.Renviron`), where you can paste your token into `GITHUB_PAT` like so:

```r
GITHUB_PAT=xxx_yy3yygflvhjojvo24d2ffdfdfze56
```

Then you can install the package as usual.



