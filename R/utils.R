`%??%` <- function(a, b) if (length(a) == 0) b else a

quote_str <- function(x, q = "\"") paste0(q, x, q)
paste_line <- function(...) paste0(c(...), collapse = "\n")
indent <- function(..., size = 2) paste0(strrep(" ", size), ...)
