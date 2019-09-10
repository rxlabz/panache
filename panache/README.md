# Panache aka Flutterial 

A [Flutter](https://flutter.io) [Material Theme](https://docs.flutter.io/flutter/material/ThemeData-class.html) editor. 

Panache helps you to create beautiful [Material](http://material.io) themes for your Flutter applications.
Customize components colors and shape, and export the generated theme.dart to your Google drive.

## Google drive

to configure Google signin and Google drive :

- https://pub.dartlang.org/packages/google_sign_in
- https://pub.dartlang.org/packages/googleapis
  
### [x] iOS

1. Create a [Firebase project](https://firebase.google.com)
2. Add an iOS application
3. Download the GoogleService-info.plist and add it to your xcode project /Runner
4. In the info.plist, add the REVERSED_CLIENT_ID ( from GoogleService-info.plist )  
5. Run 

### [x] Android

1. Create a [Firebase project](https://firebase.google.com)
2. Add an Android application
3. Enable OAuth for Drive API => https://console.developers.google.com/
4. Run 


## screenshots

![home](../docs/assets/home.png)

![screenshot](../docs/assets/screenshot.png)

![screenshot2](../docs/assets/screenshot2.png)

![screenshot3](../docs/assets/screenshot3.png)

![screenshot4](../docs/assets/screenshot4.png)

## Todo

- [x] Theme editor / live app preview
- [x] Dart 2.1
- [x] Flutter 1.0
- [ ] new Material Theme properties
  - [x] ButtonTheme
  - [x] ChipTheme
  - [x] TabBarTheme
  - [x] SliderTheme
  - [x] IconTheme
  - [x] DialogTheme
  - [x] InputDecorationTheme
  - [ ] [ColorScheme](https://github.com/rxlabz/color_scheme)
- [x] Code preview
- [x] Export to file
- [x] Save
- [x] Export to Google drive
- [ ] material colors shades
- [ ] colors opacity
- more style options controls
  - [ ] BorderSide
  - [ ] BorderRadius
  - [x] typography options text styles : letter spacing, decoration...
- [ ] Examples
- [x] mobile version
- [ ] desktop version
- [ ] user preferences :
  - theme editor + preview last state
- [ ] custom colorSwatch
- [ ] platform selection
- [ ] multiple fonts
- ...

## Getting Started

For help getting started with Flutter, view our online
[documentation](http://flutter.io/).
