# Deprecation

Functions and arguments deprecation is done using [{lifecycle}](https://lifecycle.r-lib.org/index.html).

An in-depth vignette on usage is available from the [package website](https://lifecycle.r-lib.org/articles/communicate.html):

- [Rename an argument](https://lifecycle.r-lib.org/articles/communicate.html#renaming-an-argument). Don't forget to add a badge in the documentation of the function:
    ```r
    #' @param old_param `r lifecycle::badge("deprecated")` `old_param` is no
    #'   longer supported, use new_param instead.
    ```

- [Deprecate a function](https://lifecycle.r-lib.org/articles/communicate.html#deprecate-a-function)

    Example (get_sim replaces get_daily_results):
    ```r
    #' Load and format Stics daily output file(s)
    #'
    #' @description
    #' `r lifecycle::badge("deprecated")`
    #'
    #' @examples
    #'  \dontrun{
    #' get_daily_results(path,"banana")
    #' # ->
    #' get_sim(path,"banana")
    #' }
    #'
    #' @keywords internal
    #'
    #' @export

    get_daily_results <- function(...) {

      lifecycle::deprecate_warn(
        "0.3.0",
        "get_daily_results()",
        "get_sim()")
      get_sim(...)
    }
    ```

- [Rename a function](https://lifecycle.r-lib.org/articles/communicate.html#rename-a-function)

---------------
Back to [Table of contents](README.md)
