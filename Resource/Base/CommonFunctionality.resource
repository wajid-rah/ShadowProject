*** Settings ***
Documentation   This files handles mobile application configuration

Library    AppiumLibrary
Library    AutoItLibrary

*** Variables ***
${URL}    http://localhost:4723/wd/hub
${PLATFORM_NAME}     Android
${DEVICE_NAME}     emulator-5554
${APP_PACKAGE}     com.google.android.youtube
${APP_ACTIVITY}    com.google.android.youtube.HomeActivity
#${AUTOMATION_NAME}      UiAutomator1


*** Keywords ***
Launch App
    Open Application    ${URL}
...                     platformName=${PLATFORM_NAME}
...                     deviceName=${DEVICE_NAME}
...                     appPackage=${APP_PACKAGE}
...                     appActivity=${APP_ACTIVITY}

#...                     appWaitActivity=com.google.android.apps.youtube.app.watchwhile.WatchWhileActivity
#...                     automationName=${AUTOMATION_NAME}


















...                     adbExecTimeout=90000
