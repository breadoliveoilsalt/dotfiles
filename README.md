# README.md

## In General
1) Make sure `dotfiles` are in `~/Documents`
2) Run install script
3) Run through list of other things to manually install
4) Verify you have all your documents

## Manual Installation Checklist 

- [ ] Google Chrome
- [ ] GitHub
  * Because 2FA is on GitHub, you need to [generate a token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) and use that as your password when logging in from the command line
- [ ] asp.net sdks
  * https://dotnet.microsoft.com/download/dotnet/2.1
  * https://dotnet.microsoft.com/download/dotnet/3.1
- [ ] Make sure to install ef:
  * `dotnet tool install --global dotnet-ef`
- [ ] Microsoft Teams
- [ ] Install Postgress.app to avoid Brew's auto updates
  * https://postgresapp.com/downloads.html
- [ ] Any Password managers
- [ ] Any VPNs, like global protect
- [ ] Import settings from:
  * iterm
    * Install script `defaults` command should handle this
  * Atom
    * Run this command on your old computer to update list of packages installed
      * `apm list --installed --bare > ~/Desktop/projects/dotfiles/atom/packageList.list`
    * On new computer, install these packages
      * `apm install --packages-file ~/Documents/dotfiles/atom/packageList.list`
    * Install script has a command to link the atom config file here
  * Rider
    * As of 200701, there were problems with using the Rider tool to import
      settings. Here are notes on the basic settings
      * Appearance -> Theme -> IntelliJ Light
      * Font size -> 18
      * PlugIns
        * Vim
        * Disable all other plugins you don't need
      * Using the settings import brought over the Macros but not the keymaps for
        the macros.  I map these various macros to `ctrl + shift + something`

## Manual MacOs settings

- [ ] Firevault on
- [ ] Firewall on
- [ ] Indexing and Searching off (because it eats up a ton of CPU)
  * Move entire Macintosh HD to System Preferences -> Spotlight -> Privacy
    * There is a command effectively do this, but it the command only turns off indexing.
      The annoying `mdworker` keeps running (and getting killed) when you look at
      the Console even after running this.  The manual step above seems to be
      the only way to fully stop it. 
      * `sudo mdutil -i off /`
      * Other useful commands: 
        * `mdutil -s /` # To check status of indexing process
        * `sudo mdutil -E -i off /` # # To erase any indexes and disable
          indexing
      * The internet says there are other documented ways to disable indexing,
        such as the command below. But those seem to run into additonal
        limitations and seem to have additional complications: 
        * `sudo launchctl unload -w  \
        /System/Library/LaunchDaemons/com.apple.metadata.mds.plist`
- [ ] Give screen sharing access to Zoom and Microsoft Teams        
- [ ] Reduce transparency for efficiency  
  * Accessibility -> Display -> Reduce Transparency 
- [ ] Constant nightshade
- [ ] Launch iTerm at start
  * Sys Pref => Users & Groups => Login Items
  * Make sure nothing else is running at startup
- [ ] Update your modifier keys in system preferences

_Insert Image Here_

- [ ] Update touchbar settings, if applicable

_Insert Image Here_



