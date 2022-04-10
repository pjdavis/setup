cd ~

ssh-keygen

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
brew install gnupg

# Install Firefox
brew install --cask firefox
# Install iTerm
brew install --cask iterm2
# Install VSC
brew install --cask visual-studio-code

# install fonts
brew tap homebrew/cask-fonts
brew install --cask font-caskaydia-cove-nerd-font

cd ~/Library/Fonts && {
  curl -fsSL -o "MesloLGS NF Regular.ttf" 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
  curl -fsSL -o "MesloLGS NF Bold.ttf" 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf'
  curl -fsSL -o "MesloLGS NF Italic.ttf" 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf'
  curl -fsSL -o "MesloLGS NF Bold Italic.ttf" 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf'
  cd -; }

# iTerm2 Prefs
mkdir ~/.iterm2
curl -fLo ~/.iterm2/com.googlecode.iterm2.plist https://raw.githubusercontent.com/pjdavis/setup/main/dotfiles/com.googlecode.iterm2.plist
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Install ohmyzsh
compaudit | xargs chmod g-w,o-w
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel 10k
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

#autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Get my .zshrc file
curl -fLo ~/.zshrc https://raw.githubusercontent.com/pjdavis/setup/main/dotfiles/.zshrc

# update some stuff for asdf
brew install coreutils curl git
brew install asdf

asdf plugin add ruby
asdf plugin add nodejs
asdf install ruby 2.7.2
asdf install ruby 3.1.1
asdf global ruby 3.1.1

bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf install nodejs 14.15.5


brew install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vimrc https://raw.githubusercontent.com/pjdavis/setup/main/dotfiles/.vimrc
brew install fzf
brew install rubymine

brew install postgresql
brew install redis
