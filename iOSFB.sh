#!/bin/bash

IOS_UDIDS=('01449A43-32A1-4723-832A-3ADFABAE498A iPhone 5 with 7.1','44EC8254-B7CE-40F3-92FB-01C7C01FFF56 iPhone 5 with 8.1')

SLEEP=8

IFS=','
for element in ${IOS_UDIDS[@]}; do
	iphone="${element#* }"
	udid="${element%% *}"
	
	echo "Testing '$iphone' (UDID='$udid')"
	for i in {2..4}; do
		echo "Running Test $i"
	
		#Test - Registration
		instruments -w "$uuid" -t "/Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.xrplugin/Contents/Resources/Automation.tracetemplate" /Users/silyutin/Documents/workspace/moka5_ios/imoka/DerivedData/FileBrowser/Build/Products/Debug-iphonesimulator/File-Browser-Prerelease.app -e UIASCRIPT /Users/silyutin/Documents/tuneup/test_$i.js -e UIARESULTSPATH /Users/silyutin/Documents/workspace/moka5_ios/logs/

		echo "Finished Test $i, sleeping for $SLEEP seconds"
		#Wait 8 seconds
		sleep "$SLEEP"
	done
	
	echo "Finished testing '$iphone' (UDID='$udid')"
done

#Reset all devices after testing

#!/bin/sh

instruments -s devices \
 | grep Simulator \
 | grep -o "[0-9A-F]\{8\}-[0-9A-F]\{4\}-[0-9A-F]\{4\}-[0-9A-F]\{4\}-[0-9A-F]\{12\}" \
 | while read -r line ; do
    echo "Reseting Simulator with UDID: $line"
    xcrun simctl erase $line
done
