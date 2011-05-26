## Googles OAuth2 using bash ##

I'm kind of a paranoid guy and I don't like having my passwords written down in any local configuration file.
So I wrote this little bash script using Googles experimental implementation of OAuth 2.0.

Examples can be found in the <b>"scripts"</b> directory

### Requirements ###

* awk
* bc
* curl
* grep
* ps
* sed
* tr
* xdg-open

### TODO ###

* rewrite using only curl to get the response code for authorizing the program
* multiple accounts (?)

### License ###

[WTFPL 2.0](http://sam.zoy.org/wtfpl/)

> This program is free software. It comes without any warranty, to
> the extent permitted by applicable law. You can redistribute it
> and/or modify it under the terms of the Do What The Fuck You Want
> To Public License, Version 2, as published by Sam Hocevar. See
> [http://sam.zoy.org/wtfpl/COPYING](http://sam.zoy.org/wtfpl/COPYING) for more details.
