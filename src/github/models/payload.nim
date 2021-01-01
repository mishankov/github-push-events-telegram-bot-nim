import options
import author, commit, repository, user

type
  Payload* = object
    `ref`*, before*, after*: Option[string]
    pusher*: Option[Author]
    commits*: Option[seq[Commit]]
    repository*: Option[Repository]
    sender*: Option[User]
