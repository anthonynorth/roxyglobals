#' Use roxyglobals
#'
#' Configures roxygen to use [global_roclet()], adds roxyglobals to Suggests
#' @export
use_roxyglobals <- function() {
  # add dependency
  usethis::use_dev_package(utils::packageName(), type = "Suggests")

  # current roxygen options
  options <- options_get_roxgen()

  # add roclet
  options$roclets <- unique(c(
    options$roclets,
    # could use a string, but this should be refactor proof
    paste0(utils::packageName(), "::", substitute(global_roclet))
  ))

  # use global_roclet
  options_set_roxygen(options)

  # ensure roxyglobals options
  options_set_filename(options_get_filename())
  options_set_unique(options_get_unique())
}
