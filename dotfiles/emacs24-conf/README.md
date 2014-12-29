Installation
============
From the folder containing the Cask file:
```shell
curl -fsSkL https://raw.github.com/cask/cask/master/go | python
export PATH="~/.cask/bin:$PATH"
mkdir ~/.emacs.d
ln -sf "$(pwd)/Cask" ~/.emacs.d/
ln -sf "$(pwd)/.emacs" ~/.emacs
ln -sf "$(pwd)/lisp" ~/.emacs.d/
cd ~/.emacs.d
cask install
cd elisp
git clone git://orgmode.org/org-mode.git
emacs
```
