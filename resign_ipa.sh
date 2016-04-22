#!/bin/bash
IPA_PATH="/path/to/app.ipa"
PROVISION_PATH="/path/to/new.mobileprovision"
CERTIFICATE="Developer ID Application: Your (Company's) Cert"

#unzip quietly
unzip -q "$IPA_PATH"

# remove the existing signature
rm -rf Payload/*.app/_CodeSignature/ Payload/*.app/_CodeResources

#replace the embedded.mobileprovision file with the new provision profile
cp "$PROVISION_PATH" Payload/*.app/embedded.mobileprovision 

# sign with the new certificate 
codesign -f -s "$CERTIFICATE" Payload/*.app

#zip the Payload folder with .ipa extension
zip -qr app-resigned.ipa Payload/
