import options
import author

type
    Commit* = object
      id*, timestamp*, message*, url*: Option[string]
      distict*: Option[bool]
      author*: Option[Author]
      added*, modified*, removed*: Option[seq[string]]
