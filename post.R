# Find .qmd files to move back into original paths
moved_files <-
  fs::dir_ls(type = "file") |>
  grep("^(?!index\\.qmd$).+\\.qmd$", x = _, perl = TRUE, value = TRUE)
# The regex finds all .qmd files that are not named "index.qmd"

# Move files into original paths
orig_paths <- read.csv("orig_files.csv")[,1]
lapply(
  moved_files,
  function(file) {
    fs::file_move(
      file,
      grep(
        paste0("*", file),
        orig_paths,
        value = TRUE
      ))
  })