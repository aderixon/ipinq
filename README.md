# Summary

ipinq is basically a fancy frontend to grep. We use it internally to
search a text file consisting of internal IP addresses and hostnames.

Its main purpose was to enable me to learn some (fairly basic) Ruby and
Sinatra. Any secondary purpose is doubtful. ;-)

# Usage

Ensure you have the Sinatra gem and a working web server installed.

Deploy using a standard Ruby application server such as Passenger. Modify
ipinq.rb for your requirements, paying attention to the base URI, data file
location and hostname format in the regex used to convert names to
hotlinks. Update any absolute URLs present in the remaining files (which
by default assume that this app and any associated links live on a site
called 'intranet').

The data file is assumed to be a standard hosts file format; anything
after a hash is assumed to be a comment, which can optionally be stripped
from the results.

# Bugs

ipinq should strictly be called ipenq. Yes, this still bugs me.
