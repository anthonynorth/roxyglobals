#' Extract globals
#'
#' @param func a function to extract from
#' @keywords internal
#' @noRd
extract_globals <- function(func) {
  env <- environment()
  globals <- c()

  enter <- function(type, name, expr, walker) {
    undefined <- !is_defined(name, walker$globalenv)
    if (undefined && (type == "variable" || type == "function" && name == ":=")) {
      env$globals <- c(globals, name)
    }
  }

  codetools::collectUsage(func, enterGlobal = enter)
  unique(globals)
}

#' Is defined
#'
#' @param name a binding name
#' @param env an environment
#' @param inherit look for names in parent environments
#'
#' @keywords internal
#' @noRd
is_defined <- function(name, env, inherit = FALSE) {
  exists(name, envir = env, inherits = inherit) ||
    exists(name, envir = baseenv(), inherits = inherit)
}
