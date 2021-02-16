cd ~ 
if [ ! -f /Applications/Firefox.app/Contents/MacOS/firefox ]; then 
  echo "Installing Firefox"
  wget -O FirefoxSetup.dmg "https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
  hdiutil attach FirefoxSetup.dmg
  cp -R /Volumes/Firefox/Firefox.app /Applications
  rm FirefoxSetup.dmg
fi
