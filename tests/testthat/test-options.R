test_that("options_get/set_unique() works", {
  pkg_path <- local_package_copy(test_path("./empty"))

  expect_identical(
    options_get_unique(pkg_path),
    FALSE
  )

  options_set_unique(FALSE, pkg_path)
  expect_identical(
    options_get_unique(pkg_path),
    FALSE
  )

  options_set_unique(TRUE, pkg_path)
  expect_identical(
    options_get_unique(pkg_path),
    TRUE
  )

  # can disable after enabling
  options_set_unique(FALSE, pkg_path)
  expect_identical(
    options_get_unique(pkg_path),
    FALSE
  )
})

test_that("options_get/set_filename() works", {
  pkg_path <- local_package_copy(test_path("./empty"))

  expect_identical(
    options_get_filename(pkg_path),
    "globals.R"
  )

  options_set_filename("globals.R", pkg_path)
  expect_identical(
    options_get_filename(pkg_path),
    "globals.R"
  )

  options_set_filename("foobar.R", pkg_path)
  expect_identical(
    options_get_filename(pkg_path),
    "foobar.R"
  )
})
