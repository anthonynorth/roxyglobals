#' Roxyglobals options
#'
#' @description
#' Get & set roxyglobals options in DESCRIPTION file.
#'
#' @name options
#' @inheritParams desc::desc_get_field
#' @keywords internal
NULL


#' @export
#' @return The option value
#' @describeIn options get unique
options_get_unique <- function(file = ".") {
  text <- desc::desc_get_field(
    options_key("unique"),
    FALSE,
    file = file
  )
  eval(parse(text = text))
}

#' @export
#' @param value The new option value
#' @describeIn options set unique
options_set_unique <- function(value, file = ".") {
  desc::desc_set(
    options_key("unique"),
    isTRUE(value),
    file = file
  )
}

#' @export
#' @describeIn options get filename
options_get_filename <- function(file = ".") {
  desc::desc_get_field(
    options_key("filename"),
    "globals.R",
    file = file
  )
}

#' @export
#' @describeIn options set filename
options_set_filename <- function(value, file = ".") {
  stopifnot(is_r_file(value))

  desc::desc_set(
    options_key("filename"),
    basename(value[1]),
    file = file
  )
}

options_get_roxygen <- function(file = ".") {
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
