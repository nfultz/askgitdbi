setClass("AskGitDriver", contains = "SQLiteDriver")

setClass("AskGitConnection", contains = "SQLiteConnection")


AskGit <- function() {
  new("AskGitDriver")
}

setMethod("dbConnect", "AskGitDriver", function(drv, ...) {
  # ...
  con <- callNextMethod()

  file <- system.file("libs", "askgit.so", package = 'askgit') |>   enc2utf8() # path to so

  entry_point <- "sqlite3_extension_init"

  .Call("_RSQLite_extension_load", con@ptr, file, entry_point, PACKAGE = "RSQLite")

  as(con, "AskGitConnection")
})


setMethod("dbConnect", "AskGitConnection", function(drv, ...) {
  if (drv@dbname %in% c("", ":memory:", "file::memory:")) {
    stop("Can't clone a temporary database", call. = FALSE)
  }

  dbConnect(AskGitDriver(), drv@dbname,
            vfs = drv@vfs, flags = drv@flags,
            loadable.extensions = drv@loadable.extensions
  )

})
