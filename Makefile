ADB = ${ANDROID_HOME}/platform-tools/adb
EMULATOR = ${ANDROID_HOME}/tools/emulator

XWALK_APP_VERSION = 0.1.0
XWALK_BUILD = crosswalk/build

android-emulator:
	nohup ${EMULATOR} -avd test -wipe-data > emulator.log 2>&1 &
	${ADB} wait-for-device
android-logs:
	${ADB} shell logcat

webview: webview-deploy android-logs
webview-deploy:
	cd webview && ./gradlew --daemon installDebug

webapp-start:
	cd webapp && npm install && npm start

crosswalk: crosswalk-deploy android-logs
crosswalk-deploy:
	-rm -rf ${XWALK_BUILD}
	-mkdir ${XWALK_BUILD}
	cd ${XWALK_BUILD} && \
		python ${CROSSWALK_HOME}/make_apk.py \
			--package=toastmaster.crosswalk \
			--manifest=${CURDIR}/crosswalk/manifest.json \
			--app-version=${XWALK_APP_VERSION}
	${ADB} install -r ${XWALK_BUILD}/*_${XWALK_APP_VERSION}_arm.apk
