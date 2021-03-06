# lighttpd base image

This is a simple lighttpd + alpine image that:
  - Outputs data to stderr / console
  - Does not use root
  - Reads config files from /etc/lighttpd/conf.d/*conf
  - Has a default "it works" page
  - Assumes that web docs are under /var/www, changeable via the base config file
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

## Running the image

At a minimum, `docker run --rm -ti -p 8000:8000 hidgweb/lighttpd` will get your
container started, then if you visit `http://localhost:8000` you should see 
something like this:

![screenshot](screenshot-itworks.png)

