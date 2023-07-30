#' @global this that
#' @global thistoo
manualmode <- function(data) {
  data |>
    dplyr::mutate(this = 1, that = 2) |>
    dplyr::arrange(thistoo)
}
