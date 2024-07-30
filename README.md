## Installation
why would you even want this?
```
Warning: this files are not design to work properly for everyone
```
1. have archlinux with bash (preferably)
2. if you want to move all your configs in **~/config** instead of **~/.config**, create **whatever.sh** in **/etc/profile.d** with `export XDG_CONFIG_HOME="$HOME/config"` inside
3. install chezmoi `pacman -S chezmoi`, and run `chezmoi init --apply --verbose https://github.com/rodentous/dotfiles`
4. ...or download and copy configs in ~ manually
5. add `. ~/bash.sh` in your **~/.bashrc**
