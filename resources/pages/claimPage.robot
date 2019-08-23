*** Settings ***


*** Variable ***
${OrganizerPass}               //*[@name="organizerPassword"]
${CreateGroup}                 //button[@class="btn btn-primary pull-right"]
${cardNumber}                  //input[@id="card-field"]
${cvv}                         //input[@id="cvv"]
${expDate}                     //input[@name="card.expDate"]
${fullname}                    //input[@name="card.fullName"]
${newMethod}                   //button[@class="btn btn-secondary add-new-button"]
${UserMenu}                    //button[@class="btn btn-link nav-link dropdown-toggle"]
${logOut}                      //a[@href="/logout"]
${contributeBtn}               //button[@class="btn btn-primary btn-block"]
${CreateGroup}                 //button[@type="submit"]
${guest_email}                 //input[@name="auth.email""]
${guest_pass}                  //input[@name="auth.password"]

*** Keywords ***
Log out User     
    Click Element               xpath:${UserMenu} 
    Click Element               xpath:${logOut} 
    Sleep                       3 second

Click on contribute button
    Click Element               xpath:${contributeBtn} 
    Sleep                       2 second

Login as organizer toggle claim page
    [Arguments]                 ${PasswordOrg}
    Input Text                  xpath:${OrganizerPass}                  ${PasswordOrg}      

Click Create Group
    Click Element               xpath:${CreateGroup}
    Sleep                       2 second

Add new payment method
    [Arguments]             ${Card}         ${cvv}      ${ExpDate}      ${Name}
    Click Element           xpath:${newMethod}
    Input Text              xpath:${cardNumber}                  ${Card}   
    Input Text              xpath:${cvvInp}                      ${cvv}  
    Input Text              xpath:${dateExp}                     ${ExpDate}  
    Input Text              xpath:${fullname}                    ${Name}  
    Click Element           xpath:${CreateGroup}
    Sleep                   2 second

Click on Contribute
    Click Element           xpath:${contributeBtn}
    Sleep                   2 second

Contribute group as guest
    [Arguments]             ${Card}         ${cvv}      ${ExpDate}      ${Name}      ${mail_guest}              ${pass_mail}
    Click Element           xpath:${newMethod}
    Input Text              xpath:${cardNumber}                  ${Card}   
    Input Text              xpath:${cvvInp}                      ${cvv}  
    Input Text              xpath:${dateExp}                     ${ExpDate}  
    Input Text              xpath:${fullname}                    ${Name}  
    Input Text              xpath:${guest_email}                 ${mail_guest}  
    Input Text              xpath:${guest_pass}                  ${pass_mail}  
    Click Element           xpath:${CreateGroup}
    Sleep                   2 second

Get user name
    Sleep                           3 second
    ${userName}=                    Get Text                    ${UserMenu}
    [Return]                        ${userName}
