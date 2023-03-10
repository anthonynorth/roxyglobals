# extract globals
extract_globals <- function(fn) {
  env <- environment()

  codetools::collectUsage(
    fn,
    enterGlobal = function(type, name, expr, walker) {
      if (type == "function") env$last_call <- expr

      if (!is_defined(name, walker$globalenv) && !is_assign(env$last_call) &&
        (type == "variable" || type == "function" && name == ":=")) {
        env$globals <- c(env$globals, name)
      }
    },
    enterLocal = function(type, name, expr, walker) {
      if (type == "function") env$last_call <- expr
    }
  )

  unique(env$globals)
}

# is expr an assignment call?
is_assign <- function(expr) {
  is.call(expr) && as.character(expr[[1]]) %in% c("<-", "<<-", "=", "assign")
}

# is name defined in package env?
is_defined <- function(name, env, inherit = FALSE) {
  exists(name, envir = env, inherits = inherit) ||
    exists(name, envir = parent.env(env), inherits = inherit) ||
    exists(name, envir = baseenv(), inherits = inherit)
}
