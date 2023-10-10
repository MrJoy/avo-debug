# Sixty AI Core

## Setup

First setup Homebrew, and make sure everything is up to date.

Next, make sure your maximum open file limit is [fairly large](https://wilsonmar.github.io/maximum-limits/),
and do so in a way that is permanent.

Clone this repo and `cd` into it.  Run the following to set up tools:

```bash
brew install postgresql@14 rbenv-binstubs rbenv-gemset rbenv yarn nvm
rbenv install
gem update --system
```

Add the following to `~/.profile` / `~/.zshrc` / whatever startup script your shell uses:

```bash
# Adjust as-needed, but make sure /usr/local/{bin,sbin} appear _before_ system bin paths!
export PATH="~/.rbenv/shims:/usr/local/bin:/usr/local/sbin:$PATH"
```

You will need NodeJS.  It's recommended that you use `nvm` (`brew install nvm`, then update RC
files as appropriate), but any sufficiently recent version of Node should be adequate.

To install / upgrade to what we're using:

```bash
nvm install
npm install --no-progress --global npm@"$(<.npmrc)"
npm install --no-progress --global yarn@"$(<.yarnrc)"
```

Then run the following commands to finish setup:

```bash
gem install bundler:$(grep -A 1 'BUNDLED WITH' Gemfile.lock | tail -1 | awk '{ print $1 }')
bundle
rbenv rehash # Needed when adding gems that have binaries...
yarn install --link-duplicates --ignore-optional --check-files # Link-dupes and ignore-optional are optional but recommended.

rake db:create:all db:migrate db:seed
```
