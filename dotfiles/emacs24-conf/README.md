Installation
============
From the folder containing the Cask file:
```shell

# environment
mkdir -p ~/.emacs.d/lisp ~/git/org
cp Cask ~/.emacs.d
cp .xface .signature ~/
cd ~/.emacs.d
ln -sf "$(pwd)/Cask" ~/.emacs.d/
ln -sf "$(pwd)/.emacs" ~/.emacs
ln -sf "$(pwd)/lisp" ~/.emacs.d/

# cask
curl -fsSkL https://raw.github.com/cask/cask/master/go | python
export PATH="~/.cask/bin:$PATH"
cd ~/.emacs.d
cask install

# org-mode
cd ~/git
git clone git://orgmode.org/org-mode.git
emacs
```
