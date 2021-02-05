#!/bin/env zsh


# Install homebrew and some packages


# Install homebrew
# More info here: https://brew.sh/
echo "\n***Installing Homebrew***\n"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "\n***Installing Packages with Homebrew***\n"

# Install packages
brew install flyway # used to automate database migrations
brew install node 
brew install pass # used to store passwords. The `pass` package helps other scripts (like the proxy) work
brew install yarn # alternative to npm. Used by all javascipt project in United Income
brew install docker # for database something something. TODO: better note
brew install awscli # more info in `api/README.md`

# Maintain a connection to `api-shared` RDS instance

brew install expect
brew install autossh


# from `api/README.md`
# brew install cntlm

echo "\n***Installing GUI Applications with Homebrew***\n"

# Install GUI applications
# These are all optional
brew install --cask visual-studio-code # IDE
brew install --cask brave-browser # browser
brew install --cask firefox # browser
brew install --cask flux # screen brightness utility
brew install --cask rectangle # window manager

