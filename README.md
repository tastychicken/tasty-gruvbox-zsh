# tasty-gruvbox-zsh

A gruvbox theme for zsh. 

Based heavily on [sbugzu/gruvbox-zsh](https://github.com/sbugzu/gruvbox-zsh) which is based on [zsh Agnoster theme](https://gist.github.com/agnoster/3712874) and [morhetz/gruvbox](https://github.com/morhetz/gruvbox).

Just wanted a cleaner theme that matched the following tmux and vim themes:
- [egel/tmux-gruvbox](https://github.com/egel/tmux-gruvbox)
- [ellisonleao/gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)

![Theme](https://github.com/tastychicken/tasty-gruvbox-zsh/blob/main/screenshot.png)

# Installation

1. Download and install a [Nerdfont](https://www.nerdfonts.com/).
2. Download `tasty-gruvbox.zsh-theme` and put it in `~/.oh-my-zsh/custom/themes`:
```
curl -L https://raw.githubusercontent.com/tastychicken/tasty-gruvbox-zsh/main/gruvbox.zsh-theme > ~/.oh-my-zsh/custom/themes/tasty-gruvbox.zsh-theme
```
4. Enable the theme by adding the following to your `~/.zshrc`:
```
ZSH_THEME="tasty-gruvbox"
SOLARIZED_THEME="dark"
```

# Development

1. Clone repo to your source directory.
2. Symlink `tasty-gruvbox.zsh-theme` to `~/.oh-my-zsh/custom/themes/tasty-gruvbox.zsh-theme`:
`ln -s ~/src/zsh/tasty-gruvbox-zsh/tasty-gruvbox.zsh-theme tasty-gruvbox.zsh-theme`
3. Uncomment the source line to `~/.zsh/lib/git.zsh`.
4. Enable the theme by adding the following to your `~/.zshrc`:
```
ZSH_THEME="tasty-gruvbox"
SOLARIZED_THEME="dark"
```
