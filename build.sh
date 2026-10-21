#!/bin/bash
# Builds build/BonsaiImageLauncher.ipa (ad-hoc signed; a device cloud re-signs it).
set -euo pipefail
cd "$(dirname "$0")"
APP=build/Payload/BonsaiImageLauncher.app
rm -rf build && mkdir -p "$APP"
SDK=$(xcrun --sdk iphoneos --show-sdk-path)
xcrun --sdk iphoneos swiftc -swift-version 5 -O -parse-as-library -target arm64-apple-ios17.0 -sdk "$SDK" -framework UIKit -framework SwiftUI Launcher.swift -o "$APP/BonsaiImageLauncher"
python3 - <<'PY'
import plistlib
p = {'CFBundleExecutable': 'BonsaiImageLauncher', 'CFBundleIdentifier': 'com.seihun.BonsaiImageLauncher',
     'CFBundleName': 'Bonsai Image Lab', 'CFBundleDisplayName': 'Bonsai Image Lab', 'CFBundlePackageType': 'APPL',
     'CFBundleVersion': '1', 'CFBundleShortVersionString': '1.0', 'MinimumOSVersion': '17.0', 'LSRequiresIPhoneOS': True,
     'UIDeviceFamily': [1, 2], 'UIRequiredDeviceCapabilities': ['arm64'], 'UILaunchScreen': {},
     'UISupportedInterfaceOrientations': ['UIInterfaceOrientationPortrait'],
     'LaunchURL': 'https://seihun.com/bonsai-image-lab/launch'}
with open('build/Payload/BonsaiImageLauncher.app/Info.plist', 'wb') as f: plistlib.dump(p, f)
PY
codesign --force --sign - "$APP"
(cd build && ditto -c -k --keepParent Payload BonsaiImageLauncher.ipa)
shasum -a 256 build/BonsaiImageLauncher.ipa
