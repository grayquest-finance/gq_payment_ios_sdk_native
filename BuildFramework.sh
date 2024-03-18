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


#5 - CuNcommenting specific lines for prod/ Commenting specific lines needed for development.
#Note: source_files(40),  resources(41) - For Development AND vendored_frameworks(43), exclude_files(44) - For Production.
file="GQPaymentIOSSDKNative.podspec"
dev_line_number="40,41"
prod_line_number="43,44"
sed -i -e "${dev_line_number}s/^/# /" "$file"
sed -i -e "${prod_line_number}s/^#/ /" "$file"


# ONLY FOR TESTING
##6 - Deintegrating old pods and installing new one in the Example Project.
#cd Example/
#pod deintegrate
#pod install
