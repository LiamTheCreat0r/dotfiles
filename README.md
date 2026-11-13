# dotfiles

Fedora (aarch64) + Hyprland + Noctalia shell, managed with [chezmoi](https://www.chezmoi.io/).

| Source | Installs to |
|--------|-------------|
| `dot_config/hypr/` | `~/.config/hypr/` (Lua config `hyprland.lua`, HyprMod `hyprland-gui.lua`, legacy `hyprland.conf`) |
| `dot_local/state/noctalia/settings.toml` | `~/.local/state/noctalia/settings.toml` |
| `dot_config/noctalia-plugins/` | `~/.config/noctalia-plugins/` (local `kbd-backlight` plugin) |
| `dot_config/hypr/noctalia.lua`, `dot_config/ghostty/themes/noctalia`, `dot_config/btop/themes/noctalia.theme` | Noctalia color templates generated from the wallpaper (run `chezmoi re-add` after changing it) |
| `dot_config/kitty/` | `~/.config/kitty/kitty.conf` |
| `dot_config/ghostty/` | `~/.config/ghostty/config.ghostty` |
| `dot_config/fontconfig/` | `~/.config/fontconfig/fonts.conf` (Inter / JetBrains Mono, grayscale antialiasing with light autohinting for macOS-like text) |
| `run_onchange_after_gtk-fonts.sh` | GTK font settings via `gsettings` (re-runs when the script changes) |
| `Pictures/BG5.png` | `~/Pictures/BG5.png` (Noctalia wallpaper) |
| `dot_zshrc` | `~/.zshrc` (Oh My Zsh, `robbyrussell` theme, `git` plugin) |
| `.chezmoiexternal.toml` | `~/.oh-my-zsh/` (cloned from GitHub, pulled weekly by `chezmoi apply`) |

## New machine

```sh
sudo dnf install chezmoi git zsh
chezmoi init --apply LiamTheCreat0r
chsh -s /usr/bin/zsh
```

## System setup (needs sudo, not managed by chezmoi)

`system/` mirrors files outside `$HOME` and is ignored by chezmoi. On a new machine, and after changing anything in it:

```sh
sudo dnf install jetbrains-mono-fonts-all rsms-inter-vf-fonts                   # terminal + UI fonts
sudo install -Dm644 system/etc/libinput/local-overrides.quirks /etc/libinput/   # trackpad palm rejection
sudo grubby --update-kernel=ALL --args=appledrm.show_notch=1                     # use the notch area (reboot)
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
