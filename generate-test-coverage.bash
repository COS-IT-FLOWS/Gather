#!/bin/bash

# Generate lcov.info
flutter test --coverage


# Convert to cobertura.xml
dart run cobertura convert -i coverage/lcov.info -o coverage/cobertura.xml

vim coverage/cobertura.xml


