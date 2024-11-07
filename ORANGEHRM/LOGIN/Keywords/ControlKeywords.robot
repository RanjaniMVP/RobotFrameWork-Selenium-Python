*** Settings ***
Library     SeleniumLibrary
Library     Collections
Variables    ../Resources/ApplicationData.py
Library    ../Resources/ReadExcel.py
Variables    ../PageObjects/LoginPage.py
Library    ../PageObjects/CommonElement.py

*** Variables ***
${ExpectedTitle}    Dashboard
${ExpectedInvalidMsg}   Invalid credentials
${ExpectedBlankMsg}  Required
*** Keywords ***
Open OrangeHRM Application
    [Arguments]     ${Url}  ${Browser}
    Open Browser    ${Url}    ${Browser}
    maximize browser window
    set selenium implicit wait  30s
    set selenium speed  0.1s
    sleep   5s
    capture page screenshot     HOMEPAGE.png

Enter Username
    [Arguments]     ${UserNameVal}
    wait until page contains element    ${InpUserName}
    click element   ${InpUserName}
    input text  ${InpUserName}  ${UserNameVal}
    set selenium speed  0.1s


Enter Password
    [Arguments]     ${PwdVal}
    wait until page contains element    ${InpPwd}
    click element   ${InpPwd}
    input password  ${InpPwd}  ${PwdVal}
    set selenium speed  0.1s

Click LogIn Button
    sleep   2s
    click element   ${BtnLogin}

Validate response after successful login
    Wait Until Page Contains Element    ${MainMenu}
    capture page screenshot  SUCCESS_LOGIN.png
    sleep   1s
    ${Msg}=    get text     ${MainPageHeader}
    log to console  ${Msg}
    Should Be Equal    ${Msg}    ${ExpectedTitle}

Validate response after Invalid login
    Wait Until Page Contains Element    ${MsgInvalidLogin}
    capture page screenshot  INVALID_LOGIN.png
    sleep   1s
    ${Msg}=    get text     ${MsgInvalidLogin}
    Should Be Equal    ${Msg}    ${ExpectedInvalidMsg}

Validate response after Invalid login- Blank Values
    Wait Until Page Contains Element    ${MsgBlankUsername}
    Wait Until Page Contains Element    ${MsgBlankPwd}
    capture page screenshot  BLANK.png
    sleep   1s
    ${BlankUsernameMsg}=    get text     ${MsgBlankUsername}
    Should Be Equal    ${BlankUsernameMsg}    ${ExpectedBlankMsg}
    ${BlankPwdMsg}=    get text     ${MsgBlankPwd}
    Should Be Equal    ${BlankPwdMsg}    ${ExpectedBlankMsg}


Verify that the user can log out successfully
    click element    ${DrpUser}
    click element    ${DrpLogOut}
    set selenium speed    2s
    ${LoginTitle}=    get text     ${LoginHeader}
    Should Be Equal    ${LoginTitle}    Login