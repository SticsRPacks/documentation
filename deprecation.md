# Deprecation

Functions and arguments deprecation is done using [{lifecycle}](https://lifecycle.r-lib.org/index.html).

An in-depth vignette on usage is available from the [package website](https://lifecycle.r-lib.org/articles/communicate.html):

- [Rename an argument](https://lifecycle.r-lib.org/articles/communicate.html#renaming-an-argument). 
    Don't forget to add a badge in the documentation of the function:
    ```r
    #' @param old_param `r lifecycle::badge("deprecated")` `old_param` is no
    #'   longer supported, use new_param instead.

    ```r
    # in this example na_rm replaces na.rm
    add_two <- function(x, y, na_rm = TRUE, na.rm = lifecycle::deprecated()) {
      if (lifecycle::is_present(na.rm)) {
        lifecycle::deprecate_warn("1.0.0", "add_two(na.rm)", "add_two(na_rm)")
      } else {
        na.rm <- na_rm # to remove when we update inside the function
      }

      # ... the function code
    }
    ```

    - First change the function code (put the old argument at the end of the argument list)
    - Then change the function documentation (see here-before): add a doc for the new parameter (with its new definition) and replace the doc of the old parameter by what is given in the exampel here-before.
    - Then build (ctl-shift-B) and test the package (ctl-shift-T) and check that warnings on the deprecated arguments are given.
    - Then search for the calls to the concerned function everywhere in the tests (folder tests) and docs (folder vignettes) and examples (folder R): ctl-shift-F under R (and choose Common R source files) **+ in other packages (in particular SticsRTest)**
    - Then build and test the package (ctl-shift-T) and check that there are no more warnings.
    - Then regenrate the documentation (ctl-shift-D)
    - Then commit

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
