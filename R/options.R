#' Roxyglobals options
#'
#' @description
#' Get and set roxyglobals options in DESCRIPTION file.
#'
#' @name options
#' @inheritParams desc::desc_get_field
#' @param value The new option value
#' @return The option value or nothing
#' @keywords internal
NULL


#' @export
#' @examples
#' options_get_unique()
#' @describeIn options get unique
options_get_unique <- function(file = ".") {
  default <- FALSE
  if (!in_pkg(file)) {
    return(default)
  }

  text <- desc::desc_get_field(
    options_key("unique"),
    default,
    file = file
  )

  eval(parse(text = text))
}

#' @export
#' @describeIn options set unique
#' @examples
#' \dontrun{
#' options_set_unique(TRUE)
#' }
options_set_unique <- function(value, file = ".") {
  assert_in_pkg(file)

  desc::desc_set(
    options_key("unique"),
    isTRUE(value),
    file = file
  )

  invisible()
}

#' @export
#' @describeIn options get filename
#' @examples
#' options_get_filename()
options_get_filename <- function(file = ".") {
  default <- "globals.R"
  if (!in_pkg(file)) {
    return(default)
  }

  desc::desc_get_field(
    options_key("filename"),
    default,
    file = file
  )
}

#' @export
#' @describeIn options set filename
#' @examples
#' \dontrun{
#' options_set_filename("roxyglobals-generated.R")
#' }
options_set_filename <- function(value, file = ".") {
  stopifnot(is_r_file(value))
  assert_in_pkg(file)

  desc::desc_set(
    options_key("filename"),
    basename(value[1]),
    file = file
  )

  invisible()
}

options_get_roxygen <- function(file = ".") {
  assert_in_pkg(file)

  desc_text <- desc::desc_get_field(
    "Roxygen",
    default = list(),
    file = file
  )
  desc_opts <- eval(parse(text = desc_text))
  all_opts <- roxygen2::load_options(file)

  # any options present in description + roclets
  keys <- unique(c(names(desc_opts), "roclets"))
  all_opts[keys]
}

options_set_roxygen <- function(options, file = ".") {
  assert_in_pkg(file)

  text <- paste_line(
    strwrap(
      deparse(options, 500L),
      width = 70L,
      exdent = 4L
    )
  )

  desc::desc_set(
    "Roxygen",
    text,
    file = file
  )
}


options_key <- function(name) {
  paste0(
    c("Config", utils::packageName(), name),
    collapse = "/"
  )
}

in_pkg <- function(file = ".") {
  tryCatch(
    !is.null(desc::desc(file = file)),
    error = function(e) FALSE
  )
}

assert_in_pkg <- function(file) {
  if (!in_pkg(file)) {
    stop(paste0(tools::file_path_as_absolute("."), " is not inside a package."))
  }

  invisible()
}
