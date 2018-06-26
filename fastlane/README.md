fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## Android
### android deploy
```
fastlane android deploy
```
Deploy (build and upload) a new version to the Google Play
### android build
```
fastlane android build
```
Build a new version of the app
### android upload
```
fastlane android upload
```
Upload a new build to the Google Play
### android finish
```
fastlane android finish
```
Notify the new built version

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
