import options

type
  User* = object
    login*, name*, email*, html_url*: Option[string]
    id*: Option[uint64]
