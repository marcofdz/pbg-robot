
*** Settings ***
Library                             XvfbRobot
Library                             SeleniumLibrary
Library                             String
Library                             ImapLibrary
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
Go to claim group link   
    [Arguments]     ${email}   
    Open Mailbox	host=imap.gmail.com	    user=${email}               	    password=qafytmxigxjpsxeh
    ${LATEST}=	    Wait For Email	        sender=info@paybygroup.com	        timeout=300
    ${HTML}         Get Links From Email    ${LATEST}
    Go To           ${HTML}[0]
    Sleep           3 second


