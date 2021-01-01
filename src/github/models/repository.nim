import options
import user

type
  Repository* = object
    id*: Option[uint64]
    node_id*, name*, full_name*, html_url*, language*: Option[string]
    private*: Option[bool]
    owner*: Option[User]