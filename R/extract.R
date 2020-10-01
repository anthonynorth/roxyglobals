#' Extract globals
#'
#' @param func a function to extract from
#' @keywords internal
#' @noRd
extract_globals <- function(func) {
  env <- environment()
  globals <- c()

  enter <- function(type, name, expr, walker) {
    undefined <- !exists(
      name, envir = walker$globalenv, mode = ifelse(type == "function", type, "any")
    )

    if (undefined && (type == "variable" || type == "function" && name == c(":="))) {
      env$globals <- c(globals, name)
    }
  }

  codetools::collectUsage(func, enterGlobal = enter)
  unique(globals)
}
