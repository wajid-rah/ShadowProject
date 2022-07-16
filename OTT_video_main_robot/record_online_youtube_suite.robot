*** Settings ***
Library    AppiumLibrary    run_on_failure=AppiumLibrary.Capture Page Screenshot
Library    ScreenCapLibrary     #run_on_failure=Stop Video Recording
Library   ../py/ImageProcessing.py

Resource  ../Resource/Base/CommonFunctionality.resource
Resource  ../Resource/Pages/youtube_home.resource


#Test Setup      Launch Application
#Test Teardown    Close Application

*** Variables ***
${timeout}     30
${apploadtime}   0
${videostarttime}    0
${navtime}      0

*** Test Cases ***
Launch Application And Get App Load Time
    Start Video Recording     name=Demo
    Launch Application
    Log To Console      Starting Recording - Launch App
    Start Screen Recording     180s

    Log To Console    Wait for ${timeout}
    Sleep    ${timeout}s

    Stop Screen Recording    ${EXECDIR}${/}RecordedVideo${/}appLaunch
    Log To Console    Recording Done

    Log To Console    Converting Video To Frame
    Convert Video To Frame    ${EXECDIR}${/}RecordedVideo${/}appLaunch.mp4       ${EXECDIR}${/}Frame${/}AppLaunchFrame
    Log To Console    Conversion of Video Done

    #${apploadtime}     Get Loading Time     ${EXECDIR}${/}Frame${/}AppLaunchFrame    ${EXECDIR}${/}Frame${/}Reference${/}launchRef.jpg    ${timeout}
    ${apploadtime}     Get Loading Time     ${EXECDIR}${/}Frame${/}AppLaunchFrame    120.jpg    ${timeout}
    Log To Console      App Load Time- ${apploadtime}s


Record Video Content And Get Video Start Time
    Navigate To Video Using Search Query    floatinurboat ncs

    Click on Video Title     floatinurboat

    Log To Console      Starting Recording - Video playback
    Start Screen Recording     180s      #bugReport=${True}

    Log To Console    Video is playing for ${timeout}s
    Sleep    ${timeout}s

    Stop Screen Recording    ${EXECDIR}${/}RecordedVideo${/}youtubeVideo
    Log To Console    Recording Done

    Log To Console    Converting Video To Frame
    Convert Video To Frame    ${EXECDIR}${/}RecordedVideo${/}youtubeVideo.mp4       ${EXECDIR}${/}Frame${/}VideoContentFrame
    Log To Console    Conversion of Video Done

    #${videostarttime}    Get Loading Time     ${EXECDIR}${/}Frame${/}VideoContentFrame    ${EXECDIR}${/}Frame${/}Reference${/}videoRef.jpg     ${timeout}
    ${videostarttime}    Get Loading Time     ${EXECDIR}${/}Frame${/}VideoContentFrame    160.jpg     ${timeout}
    Log To Console      Video Start Time- ${videostarttime}s


Record Navigation And Get Navigation Start Time
    Sleep   2s
    Go Back
    Sleep   2s
    Log To Console    Going Back
    Wait Until Page Contains Element    //android.widget.Button[@content-desc="Shorts"]    30s
    Click Element    	//android.widget.Button[@content-desc="Shorts"]

    Log To Console    Start Recording - Navigation
    Start Screen Recording    180s

    Log To Console    wait for ${timeout}s
    Sleep    ${timeout}s


    Stop Screen Recording     ${EXECDIR}${/}RecordedVideo${/}Navigation
    Log To Console    Stop


    Convert Video To Frame    ${EXECDIR}${/}RecordedVideo${/}Navigation.mp4       ${EXECDIR}${/}Frame${/}NavigationFrame
    Log To Console    Conversion of Video Done

    Log To Console      Calculating Navigation Starting Time
    ${navtime}       Get Loading Time    ${EXECDIR}${/}Frame${/}NavigationFrame     80.jpg     ${timeout}
    Log To Console      Navigation Time- ${navtime}s


    Sleep    10s
    Stop Video Recording
    Close Application




