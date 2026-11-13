# dotfiles

Fedora (aarch64) + Hyprland + Noctalia shell, managed with [chezmoi](https://www.chezmoi.io/).

| Source | Installs to |
|--------|-------------|
| `dot_config/hypr/` | `~/.config/hypr/` (Lua config `hyprland.lua`, HyprMod `hyprland-gui.lua`, legacy `hyprland.conf`) |
| `dot_local/state/noctalia/settings.toml` | `~/.local/state/noctalia/settings.toml` |
| `dot_config/noctalia-plugins/` | `~/.config/noctalia-plugins/` (local `kbd-backlight` plugin) |
| `dot_config/kitty/` | `~/.config/kitty/kitty.conf` |
| `dot_config/ghostty/` | `~/.config/ghostty/config.ghostty` |
| `Pictures/BG5.png` | `~/Pictures/BG5.png` (Noctalia wallpaper) |

## New machine

```sh
sudo dnf install chezmoi
chezmoi init --apply LiamTheCreat0r
```

## Using this checkout as the source

```sh
mkdir -p ~/.config/chezmoi
echo 'sourceDir = "~/Documents/projects/dotfiles"' > ~/.config/chezmoi/chezmoi.toml
```

## Day to day

```sh
chezmoi edit --apply ~/.config/ghostty/config.ghostty   # edit the source and apply
chezmoi re-add                                          # pull in changes made to live files (e.g. Noctalia's UI)
chezmoi diff                                            # preview
chezmoi apply                                           # write source -> home
chezmoi cd                                              # shell in the repo for git
```
