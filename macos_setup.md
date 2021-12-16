# Recreating KDE setup under macOS Monterey

- [ ] airline/powerline
- [ ] decide on `R` install method
- [ ] finsh vim config
- [ ] alt+f doesn't work in insert mode (alt+b works though ...)


<kbd>Ctrl</kbd>

 

## Switch to `iTerm2`

Initially used `Terminal`, which seemed fine. Apple keyboards have no <kbd>Alt</kbd> (Meta) key, so was unable to move between words with <kbd>Alt</kbd>+<kbd>B</kbd> etc. I added the `Option as Meta key` in the `Terminal` app, which worked fine. 

However, there is no <kbd>|</kbd> on the german macbook air keyboard - <kbd>Option</kbd>+<kbd>7</kbd> is used for <kbd>|</kbd> instead. Therefore I was unable to get a <kbd>|</kbd> in terminal because <kbd>Option</kbd> was instead set to (Meta) <kbd>Alt</kbd>. Subsequently discovered that <kbd>Option</kbd>+<kbd>&#8592;</kbd> and <kbd>Option</kbd>+<kbd>&#8594</kbd>; gives the desired behaviour and so disabled `Option as Meta key`.

I then realised that I wouldn't be able to use <kbd>Alt</kbd>+<kbd>.</kbd> to `yank-last-arg`/`insert-last-argument` but that <kbd>Esc</kbd>+<kbd>.</kbd> can be used instead, albeit having to release <kbd>Esc</kbd> each time. However, after installing Neovim I realised that <kbd>Esc</kbd>+<kbd>.</kbd> cannot be used inside a terminal split, instead <kbd>Esc</kbd> triggers the exit to normal mode. This stumped me for a while until I read that iTerm2 allows the left and right <kbd>Option</kbd> to be remapped independently. I mapped left <kbd>Option</kbd> to `Esc+`. This allows me to use (left) <kbd>Option</kbd>+<kbd>.</kbd> to `yank-last-arg`/`insert-last-argument` and use (right) <kbd>Option</kbd> for characters such as pipe.

## Set `Caps Lock` as an additional `Control` key

System Preferences > Keyboard >
  Modifier Keys... > Caps Lock Key ^Control

## Install `ohmyzsh`

Recent versions of macOS seem to have switched to `zsh`by default, which is already something.

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

This should fail and in doing so prompt the download and installation of the developer tools. Then repeat the command.

Installing `ohmyzsh` introduced the `Up Arrow` and `Down Arrow` history search behaviour that is specified in my KDE `.inputrc`. This is OK for now but may cause problems later on because (if I remember correctly) `.inputrc` also correctly the history search in `R`. 

Install syntax highlighting plugin (not sure if I still use this)

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Current minimal `.zshrc`

```sh

```


## Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the prompts.

````sh
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/pauljohnston/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Install Neovim

My other Neovim installs have used `~/.vimrc` because I made the switch to Neovim before the change to `~/.config/nvim/init.vim`.

````sh
brew install neovim
mkdir -p ~/.config/nvim/
touch ~/.config/nvim/init.vim
```

### clipboard/register behaviour

There are many posts about workarounds to use the clipboard as the default register on macOS. Some involve installing `pbcopy`and `pbpaste`. However, adding the following to `~/.config/nvim/init.vim` seems to work so far.

```
set clipboard=unnamed
```

### Install dein plugin manager

````sh
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.local/share/dein
```

The installation prompts to add the following to `~/.config/nvim/init.vim`.

```
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/pauljohnston/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/pauljohnston/.local/share/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/pauljohnston/.local/share/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
```


## misc

### enable three finger drag

It's diffifcult to highlight long lines without running out of trackpad

```
System Preferences > Accessibility > Pointer Control >
  Mouse & Trackpad > Trackpad Options > Enable dragging >
  three finger drag
```

### increased font size from 11 to 13

```
terminal > preferences > profiles >
  text > Font > Change...
```

### Remove recent applications from the dock

```
System Preferences > Dock > Show recent applications in Dock
```

### Additional commands

```sh
brew install htop
brew install wget
```

### Disable dead keys

```sh
gcl https://github.com/sebroeder/osx-keyboard-layout-german-no-deadkeys.git
sudo cp -r Downloads/osx-keyboard-layout-german-no-deadkeys/German\ No\ Deadkeys.bundle /Library/Keyboard\ Layouts
```

System Preferences > Keyboard > Input Sources > + > German No Dead Keys

### Prevent `zsh` from restoring sessions

When opening a terminal inside Neovim, there is a message of the form:

```
Restored session: Thu Dec 16 23:11:22 CET 2021
```

```sh
touch ~/.zsh_sessions_disable
```

Update, this doesn't work



