*** Settings ***
Library     SeleniumLibrary
Library     Collections
Variables    ../Resources/LoginApplicationData.py
Resource    ../Resources/ReadExcel.py
Resource    ../Keywords/ControlKeywords.robot
Library    ../PageObjects/CommonElement.py
Variables    ../PageObjects/LoginPage.py

Test Setup      Open OrangeHRM Application       ${OrangeHRM_Url}     ${Browser}
Test Teardown       Close Browser

*** Variables ***
${EXCEL}        ${CURDIR}${/}..${/}Resources${/}inputReg.xlsx
${OrangeHRM_Url}      https://opensource-demo.orangehrmlive.com
${Browser}      Chrome


*** Test Cases ***
TC_ID_01
    [Documentation]  Verification of Valid Login
    [Tags]     Regression    TC_ID_01    Done
    ${TestCaseSheetMap} =    Collections.get from dictionary     ${TestCaseLoginVal}     TC_ID_01
    ${dictionary} =     Read Excel MainSheet    ${EXCEL}     ${LoginSheet}     ${TestCaseSheetMap}
    Enter Username  ${dictionary['UserName']}
    Enter Password  ${dictionary['Password']}
    Click LogIn Button
    Validate response after successful login

TC_ID_02
    [Documentation]  Verification of Invalid  Login - Invalid UserName
    [Tags]     Regression    TC_ID_02    Done
    ${TestCaseSheetMap} =    Collections.get from dictionary     ${TestCaseLoginVal}     TC_ID_02
    ${dictionary} =     Read Excel MainSheet    ${EXCEL}     ${LoginSheet}     ${TestCaseSheetMap}
    Enter Username  ${dictionary['UserName']}
    Enter Password  ${dictionary['Password']}
    Click LogIn Button
    Validate response after Invalid login

TC_ID_03
    [Documentation]  Verification of Invalid  Login - Blank Values
    [Tags]     Regression    TC_ID_03    Done
    ${TestCaseSheetMap} =    Collections.get from dictionary     ${TestCaseLoginVal}     TC_ID_03
    ${dictionary} =     Read Excel MainSheet    ${EXCEL}     ${LoginSheet}     ${TestCaseSheetMap}
    sleep   1s
    Click LogIn Button
    Validate response after Invalid login- Blank Values

TC_ID_04
    [Documentation]  Verify that the user can log out successfully
    [Tags]     Regression    TC_ID_04    Done
    ${TestCaseSheetMap} =    Collections.get from dictionary     ${TestCaseLoginVal}     TC_ID_04
    ${dictionary} =     Read Excel MainSheet    ${EXCEL}     ${LoginSheet}     ${TestCaseSheetMap}
    Enter Username  ${dictionary['UserName']}
    Enter Password  ${dictionary['Password']}
    Click LogIn Button
    Validate response after successful login
    Verify that the user can log out successfully
