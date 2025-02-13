#!/bin/bash

# Remove all generated content
flutter clean

# Download packages in pubspec.yaml requirements file
flutter pub get

# Run to generate splash screen and android launcher icons
dart run flutter_native_splash:create
dart run flutter_launcher_icons