#!/bin/bash

cd ~

HOMEBREW_NO_ENV_HINTS=1

ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check for apple silicon and link the /opt/homebrew folder if so.
if [ `uname -m` = "arm64" ]
then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Make sure we’re using the latest Homebrew.
echo "Brew Update"
brew update

# Upgrade any already-installed formulae.
echo "Brew Upgrade"
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
echo "Coreutils"
brew install coreutils

# Install some other useful utilities like `sponge`.
echo "Moreutils"
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
echo "FindUtils"
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
echo "gnu-sed"
brew install gnu-sed
echo "gnupg"
brew install gnupg

# Install Firefox
echo "Installing Firefox App"
brew install --cask firefox
# Install iTerm
echo "Installing iTerm App"
brew install --cask iterm2
# Install VSC
echo "Installing Visual Studio Code App"
brew install --cask visual-studio-code

# install fonts
echo "Installing Fonts"
brew tap homebrew/cask-fonts
brew install --cask font-caskaydia-cove-nerd-font

cd ~/Library/Fonts && {
    curl -fsSL -o "MesloLGS NF Regular.ttf" 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
    curl -fsSL -o "MesloLGS NF Bold.ttf" 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf'
    curl -fsSL -o "MesloLGS NF Italic.ttf" 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf'
    curl -fsSL -o "MesloLGS NF Bold Italic.ttf" 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf'
cd -; }

# iTerm2 Prefs
echo "Setting iTerm2 Prefs"
mkdir ~/.iterm2
curl -fLo ~/.iterm2/com.googlecode.iterm2.plist https://raw.githubusercontent.com/pjdavis/setup/main/dotfiles/com.googlecode.iterm2.plist
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Install ohmyzsh
echo "Installing OhMyZSH"
compaudit | xargs chmod g-w,o-w
RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel 10k
git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

#autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Get my .zshrc file
curl -fLo ~/.zshrc https://raw.githubusercontent.com/pjdavis/setup/main/dotfiles/.zshrc
curl -fLo ~/.p10k.zsh https://raw.githubusercontent.com/pjdavis/setup/main/dotfiles/.p10k.zsh
# update some stuff for asdf
echo "Installing asdf, ruby and node"
brew install curl git
brew install asdf

asdf plugin add ruby
asdf plugin add nodejs
asdf install ruby 3.1.1
asdf global ruby 3.1.1

bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf install nodejs 14.15.5


echo "Installing VIM and friends"
brew install fzf

# Get VIM setup
brew install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vimrc https://raw.githubusercontent.com/pjdavis/setup/main/dotfiles/.vimrc
vim +PlugInstall +qall

echo "Install Rubymine app"

brew install rubymine
echo "installing psotgresql"
brew install postgresql
echo "installing redis"
brew install redis
