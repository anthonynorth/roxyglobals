test_that("extract_globals() works", {
  # shim dplyr
  mutate <- function(...) NULL

  fn <- function(foo) {
    local_fn <- function(local_param) {
      local_local_fn <- function(local_local_param) {
        my_local_local_var <- local_local_var_does_not_exist
        mutate(foo, new_name = local_local_param, capture_this_local_local)
      }

      my_local_var <- local_var_does_not_exist

      mutate(foo, capture_this_local)
    }

    mutate(foo, my_alias = capture_this * 5)
  }

  expect_identical(
    extract_globals(fn),
    c("capture_this_local_local", "capture_this_local", "capture_this")
  )
})

test_that("extract_globals() works with tidy rename", {
  # shim dplyr
  mutate <- function(...) NULL

  fn <- function(foo, name) {
    mutate(foo, {{ name }} := capture_this)
  }

  expect_identical(
    extract_globals(fn),
    c(":=", "capture_this")
  )
})

test_that("extract_globals() ignores assignments", {
  # shim dplyr
  mutate <- function(...) NULL

  fn <- function(foo) {
    my_var <- var_not_exist

    local_fn <- function(local_param) {
      my_local_var <- another_var_does_not_exist
    }

    mutate(foo, capture_this)
  }

  expect_identical(
    extract_globals(fn),
    "capture_this"
  )
})

test_that("extract_globals() ignores calls", {
  # shim dplyr
  mutate <- function(...) NULL

  fn <- function(foo) {
    my_var <- fn_not_exist()
    fn_not_exist2()

    local_fn <- function(local_param) {
      my_local_var <- fn_not_exist3()
      fn_not_exist4()
    }

    mutate(foo, capture_this)
  }

  expect_identical(
    extract_globals(fn),
    "capture_this"
  )
})

test_that("extract_globals() ignores defined globals", {
  # shim dplyr
  mutate <- function(...) NULL

  fn <- function(foo) {
    # all defined in ancestor environments
    mutate(foo, names, fn2, some_var)
    # not defined
    mutate(foo, capture_this)
  }

  fn2 <- function() NULL
  some_var <- 1

  expect_identical(
    extract_globals(fn),
    "capture_this"
  )
})
