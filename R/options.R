#' Roxyglobals options
#'
#' @description
#' Get & set roxyglobals options in DESCRIPTION file.
#'
#' @name options
#' @keywords internal
NULL


#' @export
#' @describeIn options get unique
options_get_unique <- function() {
  text <- desc::desc_get_field(options_key("unique"), FALSE)
  eval(parse(text = text))
}

#' @export
#' @describeIn options set unique
options_set_unique <- function(unique) {
  desc::desc_set(options_key("unique"), isTRUE(unique))
}


options_get_roxgen <- function() {
  desc_text <- desc::desc_get_field("Roxygen", default = "list()")
  desc_opts <- eval(parse(text = desc_text))
  all_opts <- roxygen2::load_options()

  # any options present in description + roclets
  keys <- unique(c(names(desc_opts), "roclets"))
  all_opts[keys]
}

options_set_roxygen <- function(options) {
  text <- paste_line(
    strwrap(
      deparse(options, 500L),
      width = 70L,
      exdent = 4L
    )
  )
  desc::desc_set("Roxygen", text)
}


options_key <- function(name) {
  paste0(
    c("Config", utils::packageName(), name),
    collapse = "/"
  )
}
