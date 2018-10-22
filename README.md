#lighttp base image

This is a simple lighttpd + alpine image that:
  - Outputs data to stderr / console
  - Does not use root
  - Reads config files from /etc/lighttpd/conf.d/*conf
  - Assumes that web docs are under /var/www, changeable via the base config file
  - Has a default "it works" page
  - Uses port 8000 by default, but that is changeable in the base config file

## The base configuration

The default settings should work for many cases, but can be overwritten
by mounting a different base config file.
That should be mounted on `/etc/lighttpd/conf.d/000-base.conf`.

This image ships with this `000-base.conf` file:

```
# {{{ mod_status
server.modules += ( "mod_status" )
status.status-url = "/server-status"
status.config-url = "/server-config"
# }}}

# {{{ basic config
server.document-root = "/var/www/html"
server.port = 8000
# }}}

```

