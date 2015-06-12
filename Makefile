ADB = ${ANDROID_HOME}/platform-tools/adb
EMULATOR = ${ANDROID_HOME}/tools/emulator

XWALK_APP_VERSION = 0.1.0

android-emulator:
	nohup ${EMULATOR} -avd test -wipe-data > emulator.log 2>&1 &
	${ADB} wait-for-device
android-logs:
	${ADB} shell logcat
android-deploy:
	cd android && ./gradlew --daemon installDebug

webapp-start:
	cd webapp && npm install && npm start

crosswalk-deploy:
	-mkdir crosswalk/build
	cd crosswalk/build && \
		python ${CROSSWALK_HOME}/make_apk.py \
			--package=toastmaster.crosswalk \
			--manifest=${CURDIR}/crosswalk/manifest.json \
			--app-version=${XWALK_APP_VERSION}
	${ADB} install -r crosswalk/build/*_${XWALK_APP_VERSION}_arm.apk

#	cd ${CROSSWALK_HOME} && \
#		python make_apk.py \
#			--package=toastmaster.crosswalk \
#			--manifest=${CURDIR}/crosswalk/manifest.json \
#			--app-version=0.1.0
