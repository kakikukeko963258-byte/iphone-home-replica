#!/bin/bash
set -euo pipefail
APP_PATH="build/Build/Products/Release-iphoneos/iPhoneHomeReplica.app"
mkdir -p dist/Payload
/usr/bin/codesign --force --sign - "$APP_PATH"
/usr/bin/codesign --verify --deep --strict "$APP_PATH"
/usr/bin/ditto "$APP_PATH" dist/Payload/iPhoneHomeReplica.app
(cd dist && /usr/bin/zip -qry iPhoneHomeReplica.ipa Payload)
python3 - <<'PY'
import plistlib, zipfile
with zipfile.ZipFile('dist/iPhoneHomeReplica.ipa') as ipa:
    info = plistlib.loads(ipa.read('Payload/iPhoneHomeReplica.app/Info.plist'))
    assert info['CFBundleIdentifier'] == 'com.studyquiz.dailyquiz', info['CFBundleIdentifier']
PY
