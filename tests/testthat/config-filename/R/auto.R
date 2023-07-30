#' @autoglobal
automode <- function(data) {
  data |>
    dplyr::group_by(my_key) |>
    dplyr::summarise(agg = sum(something))
}
