# Issues
If you have any issues with any of these steps, please file an issue with the label `question` so we can improve the process for everyone.

# RVM and Bundler

## RVM
RVM is the ruby version manager.
We can use this tool to ensure all of us are using the same version of ruby.

To install, run the following in your terminal:

```sh
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash

rvm install ruby-2.4.1
```

At this point, close your current terminal and open a new one for RVM to be sourced.

## Bundler
Bundler is used for managing dependencies (called "gems" in ruby).

To install Bundler run the following in your terminal:

```sh
gem install bundler
```

You can now install all the dependencies listed in the `Gemfile` by running:

```sh
bundle install
```
