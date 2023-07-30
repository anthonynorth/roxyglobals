local_package_copy <- function(pkg_dir, env = parent.frame()) {
  temp_dir <- withr::local_tempdir(.local_envir = env)
  file.copy(pkg_dir, temp_dir, recursive = TRUE)
  file.path(temp_dir, basename(pkg_dir))
}
