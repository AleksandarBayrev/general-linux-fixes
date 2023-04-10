# If you have problems with gpg keys do this
* `killall gpg-agent`
* `rm -rfv /etc/pacman.d/gnupg`
* `pacman-key --init`
* `pacman-key --populate`