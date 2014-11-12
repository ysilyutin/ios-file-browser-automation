#!/bin/bash

> debug.txt

{
	IOS_UUIDS=()

IOS_UUIDS[0]='8F656B81-71BF-4253-8D4C-FDEA45FDCD77 iPhone 4s with iOS 7.1'
IOS_UUIDS[1]='01449A43-32A1-4723-832A-3ADFABAE498A iPhone 5 with iOS 7.1'
IOS_UUIDS[2]='44EC8254-B7CE-40F3-92FB-01C7C01FFF56 iPhone 5 with iOS 8.1'
IOS_UUIDS[3]='8CEA2534-D954-4BB3-9042-085AB6FB8084 iPhone 5s with iOS 7.1'
IOS_UUIDS[4]='C421FE3F-C868-46C1-BADD-12B9D8D9AD1B iPhone 5s with iOS 8.1'
IOS_UUIDS[5]='7C8E9189-5EEF-4BC7-AEA7-095924440EFC iPhone 6 with iOS 8.1'
IOS_UUIDS[6]='CCD0EAAF-A7A0-4C98-AA40-63D4CC455E9E iPhone 6 Plus with iOS 8.1'



	SLEEP=8

	IFS=','
	for element in ${IOS_UUIDS[@]}; do
		iphone="${element#* }"
		uuid="${element%% *}"
		
		echo "<<< Start testing $iphone (UUID=$uuid) >>>"
		for i in {1..3}; do
			echo "<<< Running Test $i >>>"
		
			#Test - Registration
			instruments -w "$uuid" -t "/Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.xrplugin/Contents/Resources/Automation.tracetemplate" /Users/silyutin/Documents/workspace/moka5_ios/imoka/DerivedData/FileBrowser/Build/Products/Debug-iphonesimulator/File-Browser-Prerelease.app -e UIASCRIPT /Users/silyutin/Documents/tuneup/test_$i.js -e UIARESULTSPATH /Users/silyutin/Documents/workspace/moka5_ios/logs/

			echo "<<< Finished Test $i, sleeping for $SLEEP seconds >>>"
			#Wait 8 seconds
			sleep "$SLEEP"
		done
		
		echo "<<< Finished testing $iphone (UUID=$uuid) >>>"
	done

		echo "<<< Reseting Simulators >>>)"

	killall "iOS Simulator"

	instruments -s devices \
	 | grep Simulator \
	 | grep -o "[0-9A-F]\{8\}-[0-9A-F]\{4\}-[0-9A-F]\{4\}-[0-9A-F]\{4\}-[0-9A-F]\{12\}" \
	 | while read -r line ; do
	    echo "<<< Reseting Simulator with UDID: $line >>>"
	    xcrun simctl erase $line
	done
	echo "<<< Finished testing >>>"
} 2>&1 | tee debug.txt
