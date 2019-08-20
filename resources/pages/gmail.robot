
*** Settings ***
Library                             XvfbRobot
Library                             SeleniumLibrary
Library                             String
Resource                            ../${set}

*** Variables ***
${gmailURL}                         https://www.gmail.com
${user_gmail}                       //*[@id="identifierId"]
${pass_gmail}                       //*[@name="password"]
${nextBnt}                          //span[@class="CwaK9"]
${createEmail}                      //div[@class="T-I J-J5-Ji T-I-KE L3"]
${sendTo}                           //*[@id=":oj"]
${subjectInput}                     //*[@id=":o1"]
${textArea}                         //*[@id=":p5"]
${sendBnt}                          //*[@id=":nr"]

*** Keywords ***
Go to Gmail
    Go to                       ${gmailURL}
    Sleep                       3 seconds

Log in on gmail
    Input Text              ${user_gmail}                      ${email_g}
    Click Element           xpath:${nextBnt}                   
    Sleep                   1 seconds 
    Input Text              xpath:${pass_gmail}                 ${pass_g}
    Click Element           xpath:${nextBnt}
    Sleep                   1 seconds  


Claim group with welcome email
    Go to Gmail
    Log in on gmail