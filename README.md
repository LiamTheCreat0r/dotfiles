# dotfiles

Fedora (aarch64) + Hyprland + Noctalia shell.

Each top-level directory is a [GNU Stow](https://www.gnu.org/software/stow/) package that mirrors `$HOME`:

| Package   | Contents |
|-----------|----------|
| `hypr`    | `~/.config/hypr/` (Lua config `hyprland.lua`, HyprMod `hyprland-gui.lua`, legacy `hyprland.conf`) |
| `noctalia`| `~/.local/state/noctalia/settings.toml` and the local `kbd-backlight` plugin in `~/.config/noctalia-plugins/` |
| `kitty`   | `~/.config/kitty/kitty.conf` |

## Install

```sh
sudo dnf install stow
cd ~/Documents/projects/dotfiles
stow -t ~ hypr noctalia kitty      # add --adopt to pull in existing files first
```
