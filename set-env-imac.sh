#!/bin/bash
# Designed to be run on my imac
# source ./set-env-imac.sh
SDK_PATH="/Users/stever/sdk" # this is where I installed the flutter SDK
export PATH="$PATH:${SDK_PATH}/flutter/bin"
flutter config --no-analytics
flutter doctor -v



