*** Settings ***
Documentation   This files handles all operation in youtube home page

Resource   ../Base/CommonFunctionality.resource    # For importing AppiumLibrary and AutoItLibrary

*** Variables ***
${YOUTUBE_LOGO_LOCATOR}    id=com.google.android.youtube:id/youtube_logo
${SEARCH_ICON_LOCATOR}    xpath=//android.widget.ImageView[@content-desc="Search"]
${SEARCH_EDIT_TEXT_LOCATOR}    id=com.google.android.youtube:id/search_edit_text
${LIKE_VIDEO_TEXT_LOCATOR}    xpath=//android.view.ViewGroup[contains(@content-desc,"like this video along with")]
${SKIP_AD_LOCATOR}      id=skip_ad_button


*** Keywords ***
Validate Youtube Home With Status
    ${launchStatus}   Run Keyword And Return Status     Wait Until Page Contains Element    ${YOUTUBE_LOGO_LOCATOR}     timeout=50s
    [Return]    ${launchStatus}


Navigate To Video Using Search Query
    [Arguments]   ${query}
    Wait Until Page Contains Element      ${SEARCH_ICON_LOCATOR}    timeout=20s
    Click Element     ${SEARCH_ICON_LOCATOR}

    Wait Until Page Contains Element    ${SEARCH_EDIT_TEXT_LOCATOR}     20s
    Input Text      ${SEARCH_EDIT_TEXT_LOCATOR}       ${query}
    Send   {ENTER}


Click on Video Title
       [Arguments]    ${text}
       Wait Until Page Contains Element    	//android.view.ViewGroup[contains(@content-desc,'${text}')]   180s
       Click Element    //android.view.ViewGroup[contains(@content-desc,'${text}')]

#
#Check If Video Is Playing
#        ${playVideo}   Run Keyword And Return Status    Wait Until Page Contains Element     ${LIKE_VIDEO_TEXT_LOCATOR}    40s
#        [Return]     ${playVideo}
#
#
#
#
#
#
#Skip Ads
#        ${result}   Run Keyword And Return Status    Wait Until Element Is Visible   ${SKIP_AD_LOCATOR}    20s
#        #${result}   Wait Until Keyword Succeeds    1min    1s    Wait Until Element is Visible   ${SKIP_AD_LOCATOR}    20s
#        Log To Console   Adv-${result}
#        Run Keyword If   '${result}'=='True'    Click Element     ${SKIP_AD_LOCATOR}
