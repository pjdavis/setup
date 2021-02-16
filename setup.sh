cd ~ 
#Firefox
if [ ! -f /Applications/Firefox.app/Contents/MacOS/firefox ]; then 
  echo "Installing Firefox"
  curl -L -o FirefoxSetup.dmg "https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
  hdiutil attach FirefoxSetup.dmg
  cp -R /Volumes/Firefox/Firefox.app /Applications
  umount /Volumes/Firefox
  rm FirefoxSetup.dmg
fi
# iTerm2
if [ ! -f /Applications/iTerm.app/Contents/MacOS/iTerm2 ]; then
  echo "Installing iTerm"
  curl -L -o iTerm.zip "https://iterm2.com/downloads/stable/iTerm2-3_4_4.zip"
  unzip iTerm.zip
  rm iTerm.zip
  mv iTerm.app /Applications
fi
