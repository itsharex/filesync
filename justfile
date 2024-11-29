#!/bin/bash

alias w:= watch
alias b:= build
alias l:= lint
alias install := install-dependencies

set dotenv-required
set dotenv-load := true
set dotenv-path := "./.envrc"
set export :=  true

APP_NAME := "filesync"
EXPORT_PATH := "bin"

default: 
    @just --list --list-heading $'Available commands\n'

[doc('Install the application dependencies')]
install-dependencies: 
    echo "Installing dependencies"
    npm install --save 
    cd tauri && cargo build


[doc('Lint')]
lint:
    npm run lint
    cd tauri && cargo fmt && cargo clippy

[doc('Run the application in watch mode')]
[group('watch')]
watch target:
    #!/usr/bin/env sh
    export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
    if [ $target = "android" ]; then
        npm run tauri android dev 
    elif [ $target = "ios" ]; then 
        npm run tauri ios dev 
    else
        npm run tauri dev
    fi

[doc('build the application ')]
[group('watch')]
build target:
    #!/usr/bin/env sh
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
    if [ $target = "android" ]; then
        npm run tauri android build --apk
    elif [ $target = "ios" ]; then 
        npm run tauri ios build --aab
    else
        npm run tauri build 
    fi


export: 
    #!/usr/bin/env sh
    # mkdir bin 
    cp tauri/gen/android/app/build/outputs/apk/universal/release/app-universal-release.apk $EXPORT_PATH/$APP_NAME.apk
    cp ./tauri/gen/android/app/build/outputs/bundle/universalRelease/app-universal-release.aab $EXPORT_PATH/$APP_NAME.aab
    cp ./tauri/target/release/bundle/dmg/filesync_0.7.13_aarch64.dmg $EXPORT_PATH/$APP_NAME.dmg