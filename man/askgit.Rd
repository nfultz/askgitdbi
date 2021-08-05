\name{AskGit}
\alias{askgit}
\title{The AskGit DBI Driver}
\usage{
AskGit()
}
\description{
A DBI Driver for querying git repositories.
}
\examples{
# If working directory is a git repo
con <- DBI::dbConnect(askgit::AskGit(), ":memory:")
DBI::dbGetQuery(con, "select hash, author_name from commits order by committer_when desc limit 3")

}
