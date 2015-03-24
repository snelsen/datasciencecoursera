# Setting up Ruby on Windows 7

## Basic Ruby Setup
* Download from [here](http://rubyinstaller.org/downloads/ Ruby Installer)
  * Basic Ruby package
  * Ruby Devkit
  * I went with the 32-bit version for both even though I have a 64-bit machine.
* Install Ruby package to c:/Ruby22
  * Using GitBash, run: gem install rails
* Install Ruby DevKit to c:/Ruby22-Dev
  * Follow instructions [here](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit)
  * Follow on-screen instructions to ensure proper configuration.
* Go create a basic rails app somewhere: rails new my_app
