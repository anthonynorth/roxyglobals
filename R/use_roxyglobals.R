#' Use roxyglobals
#'
#' Configures roxygen to use [global_roclet()], adds roxyglobals to Suggests
#' @export
use_roxyglobals <- function() {
  # add dependency
  usethis::use_dev_package(utils::packageName(), type = "Suggests")

  # current roxygen options
  options <- get_options()

  # add roclet
  options$roclets <- unique(c(
    # defaults
    "collate", "namespace", "rd",
    roxygen2::roxy_meta_get("roclets"),
    # could use a string, but this should be refactor proof
    paste0(utils::packageName(), "::", substitute(global_roclet))
  ))

  set_options(options)
}

get_options <- function() {
  text <- desc::desc_get_field("Roxygen", default = "list(markdown = TRUE)")
  eval(parse(text = text))
}

set_options <- function(options) {
  text <- paste0(
    "list(\n",
      paste0("    ", names(options), " = ", options, collapse = ",\n"),
    ")"
  )

  desc::desc_set("Roxygen", text)
}
