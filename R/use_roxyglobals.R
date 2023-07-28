#' Use roxyglobals
#'
#' Configures roxygen to use [global_roclet()], adds roxyglobals to Suggests
#' @export
use_roxyglobals <- function() {
  # add dependency
  usethis::use_dev_package(utils::packageName(), type = "Suggests")

  # current roxygen options
  options <- roxy_options_get()

  # add roclet
  options$roclets <- unique(c(
    options$roclets,
    # could use a string, but this should be refactor proof
    paste0(utils::packageName(), "::", substitute(global_roclet))
  ))

  roxy_options_set(options)
}

roxy_options_get <- function() {
  desc_text <- desc::desc_get_field("Roxygen", default = "list()")
  desc_opts <- eval(parse(text = desc_text))
  all_opts <- roxygen2::load_options()

  # any options present in description + roclets
  keys <- unique(c(names(desc_opts), "roclets"))
  all_opts[keys]
}

roxy_options_set <- function(options) {
  text <- paste_line(
    strwrap(
      deparse(options, 500L),
      width = 70L,
      exdent = 4L
    )
  )
  desc::desc_set("Roxygen", text)
}
