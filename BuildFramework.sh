#!/bin/bash

#1 - Creating build for iPhoneOS

xcodebuild archive \
-workspace $(pwd)/Example/GQPaymentIOSSDKNative.xcworkspace \
-scheme GQPaymentIOSSDKNative \
-configuration Release \
-sdk iphoneos \
-archivePath archives/ios_devices.xcarchive \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
SKIP_INSTALL=NO \


#2 - Creating build for iPhone Simulator

xcodebuild archive \
-workspace $(pwd)/Example/GQPaymentIOSSDKNative.xcworkspace \
-scheme GQPaymentIOSSDKNative \
-configuration Debug \
-sdk iphonesimulator \
-archivePath archives/ios_simulators.xcarchive \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
SKIP_INSTALL=NO \


#3 - Combining both the archives as xcframework to add in the project.

xcodebuild \
-create-xcframework \
-framework archives/ios_devices.xcarchive/Products/Library/Frameworks/GQPaymentIOSSDKNative.framework \
-framework archives/ios_simulators.xcarchive/Products/Library/Frameworks/GQPaymentIOSSDKNative.framework \
-output $(pwd)/GQPaymentIOSSDKNative.xcframework
