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
### analyze
```
fastlane analyze
```
Analyze the Flutter app

----

## Android
### android build
```
fastlane android build
```
Build a new APK of the app
### android upload
```
fastlane android upload
```
Upload a new build to the Google Play
### android release
```
fastlane android release
```
Push a new release build to the Play Store

----

## iOS
### ios build
```
fastlane ios build
```
Build a new IPA of the app
### ios release
```
fastlane ios release
```
Push a new release build to the App Store

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
