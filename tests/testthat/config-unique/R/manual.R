#' @global this that
#' @global thistoo
manualmode <- function(data) {
  data |>
    dplyr::mutate(this = 1, that = 2) |>
    dplyr::arrange(thistoo)
}

#' @global this that
#' @global thistoo
manualmode_duplicate <- function(data) {
  data |>
    dplyr::mutate(this = 1, that = 2) |>
    dplyr::arrange(thistoo)
}
