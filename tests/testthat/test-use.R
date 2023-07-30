test_that("use_roxyglobals() works", {
  pkg_path <- local_package_copy(test_path("./empty"))
  withr::local_dir(pkg_path)

  roxyglobals::use_roxyglobals()
  expect_identical(
    desc::desc_get_field("Roxygen"),
    "list(roclets = c(\"collate\", \"namespace\", \"rd\", \"roxyglobals::global_roclet\"))"
  )

  expect_true(
    desc::desc_has_dep("roxyglobals", "Suggests")
  )

  expect_identical(
    desc::desc_get_field("Config/roxyglobals/unique"),
    "FALSE"
  )

  expect_identical(
    desc::desc_get_field("Config/roxyglobals/filename"),
    "globals.R"
  )
})

test_that("use_roxyglobals() preserves existing roclets", {
  pkg_path <- local_package_copy(test_path("./has-roclets"))
  withr::local_dir(pkg_path)

  roxyglobals::use_roxyglobals()
  expect_identical(
    desc::desc_get_field("Roxygen"),
    "list(markdown = TRUE, roclets = c(\"collate\", \"namespace\", \"rd\", \"otherpkg::other_roclet\", \"roxyglobals::global_roclet\"))"
  )
})

test_that("use_roxyglobals() preserves options_filename", {
  pkg_path <- local_package_copy(test_path("./config-filename"))
  withr::local_dir(pkg_path)

  roxyglobals::use_roxyglobals()

  expect_identical(
    desc::desc_get_field("Config/roxyglobals/filename"),
    "generated-globals.R"
  )
})

test_that("use_roxyglobals() preserves options_unique", {
  pkg_path <- local_package_copy(test_path("./config-unique"))
  withr::local_dir(pkg_path)

  roxyglobals::use_roxyglobals()

  expect_identical(
    desc::desc_get_field("Config/roxyglobals/unique"),
    "TRUE"
  )
})
