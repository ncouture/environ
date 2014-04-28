Installation
============
From the folder containing the Cask file:

    $ curl -fsSkL https://raw.github.com/cask/cask/master/go | python
    $ export PATH="~/.cask/bin:$PATH"
    $ mkdir ~/.emacs.d
    $ cp Cask ~/.emacs.d/
    $ cp dot-emacs ~/.emacs
    $ cd ~/.emacs.d
    $ cask install
    $ emacs
