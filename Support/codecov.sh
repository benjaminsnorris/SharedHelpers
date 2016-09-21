#!/bin/bash

bash <(curl -s https://codecov.io/bash) -J 'SharedHelpers' -f ./fastlane/test_output/cobertura.xml -X xcode -X gcov
