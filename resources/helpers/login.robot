*** Settings ***
Library                             XvfbRobot
Library                             String
Resource                            ../${set}

*** Variables ***
${userEmail}             //input[@name="email"]
${userPass}              //input[@name="password"]
${submit}                //button[@type="submit"]

*** Keywords ***
Star Browser 
    [Arguments]                     ${portal}
    Run Keyword If                  "${browser}"=="xvfb"    Run Ff Adv    ${portal}   ELSE IF     "${browser}"=="chrome"      Run Chrome Adv      ${portal}   ELSE    Run Ff Adv      ${portal}
    Set Selenium Implicit Wait      30 second
    Set Selenium Timeout            30 second
    Maximize Browser Window

Login Business Page
    Sleep                           2 second
    Input Text                      xpath:${userEmail}                ${organizer_email}
    Input Text                      xpath:${userPass}                 ${password}
    Click Element                   xpath:${submit}
    Sleep                           5 second

Run Chrome Adv
    [Arguments]                     ${portal}
    Open Browser                    ${portal}               chrome

Run Ff Adv
    [Arguments]                     ${portal}
    Open Browser                    ${portal}               ff

