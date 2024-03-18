#!/bin/bash

#1 - Deleting existing GQPaymentIOSSDKNative.xcframework and archives
rm -r archives
rm -r GQPaymentIOSSDKNative.xcframework


#2 - Creating build for iPhoneOS
xcodebuild archive \
-workspace Example/GQPaymentIOSSDKNative.xcworkspace \
-scheme GQPaymentIOSSDKNative \
-configuration Release \
-sdk iphoneos \
-archivePath archives/ios_devices.xcarchive \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
SKIP_INSTALL=NO \


#3 - Creating build for iPhone Simulator
xcodebuild archive \
-workspace Example/GQPaymentIOSSDKNative.xcworkspace \
-scheme GQPaymentIOSSDKNative \
-configuration Release \
-sdk iphonesimulator \
-archivePath archives/ios_simulators.xcarchive \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
SKIP_INSTALL=NO \


#4 - Combining both the archives as xcframework to add in the project.
xcodebuild \
-create-xcframework \
-framework archives/ios_devices.xcarchive/Products/Library/Frameworks/GQPaymentIOSSDKNative.framework \
-framework archives/ios_simulators.xcarchive/Products/Library/Frameworks/GQPaymentIOSSDKNative.framework \
-output GQPaymentIOSSDKNative.xcframework


#5 - Deintegrating old pods and installing new one in the Example Project.
#sed -i '' "s/^$1/#$1/" GQPaymentIOSSDKNative.podspec
#sed -i '' "s/^#$1/$1/" GQPaymentIOSSDKNative.podspec

#cd Example/
#pod deintegrate
#pod install

# Need to make it dynamic in script
#  s.source_files = 'GQPaymentIOSSDKNative/Classes/**/*'
#  s.resources = ["GQPaymentIOSSDKNative/Assets/*.xcassets", "GQPaymentIOSSDKNative/Assets/Fonts/**/*.ttf"]
# ----
#  s.vendored_frameworks = 'GQPaymentIOSSDKNative.xcframework'
#  s.exclude_files = 'BuildFramework.sh'
