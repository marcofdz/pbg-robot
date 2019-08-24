*** Settings ***


*** Variable ***
${OrganizerPass}               name:organizerPassword
${CreateGroup}                 //button[@class="btn btn-primary pull-right"]
${cardNumber}                  id:card-field
${cvvInp}                      id:cvv
${expDate}                     name:card.expDate
${fullname}                    name:card.fullName
${newMethod}                   //button[@class="btn btn-secondary add-new-button"]
${UserMenu}                    //button[@class="btn btn-link nav-link dropdown-toggle"]
${logOut}                      //a[@href="/logout"]
${contributeBtn}               //button[@class="btn btn-primary btn-block"]
${CreateGroup}                 //button[@type="submit"]
${guest_email}                 name:auth.email
${new_pass}                    name:auth.password
${NameOrg}                     name:organizerName
*** Keywords ***
Log out User     
    Click Element               xpath:${UserMenu} 
    Click Element               xpath:${logOut} 
    Sleep                       3 second

Click on contribute button
    Click Element               xpath:${contributeBtn} 
    Sleep                       2 second

Set organizer name
    [Arguments]                 ${Name} 
    Input Text                  ${NameOrg}                   ${Name} 

Login as organizer toggle claim page
    [Arguments]                 ${PasswordOrg}
    Input Text                  ${OrganizerPass}                  ${PasswordOrg}      

Click Create Group
    Click Element               xpath:${CreateGroup}
    Sleep                       5 second

Add new payment method
    [Arguments]             ${Card}         ${cvv}      ${ExpDate}      ${Name}
    Click Element           xpath:${newMethod}
    Sleep                   3 second
    Input Text              ${cardNumber}                  ${Card}   
    Input Text              ${cvvInp}                      ${cvv}  
    Input Text              ${dateExp}                     ${ExpDate}  
    Input Text              ${fullname}                    ${Name}  
    Click Element           xpath:${CreateGroup}
    Sleep                   2 second

Add new payment method as New organizer 
    [Arguments]             ${passNew}       ${Card}         ${cvv}      ${ExpDate}      ${Name}
    Sleep                   3 second
    #Input Text              ${cardNumber}                  ${Card}   
    Input Text              ${cvvInp}                      ${cvv}  
    Input Text              ${dateExp}                     ${ExpDate}  
    Input Text              ${fullname}                    ${Name}          
    Input Text              ${new_pass}                    ${passNew}  
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
    Input Text              ${guest_email}                 ${mail_guest}  
    Input Text              ${guest_pass}                  ${pass_mail}  
    Click Element           xpath:${CreateGroup}
    Sleep                   2 second

Get user name
    Sleep                           3 second
    ${userName}=                    Get Text                    ${UserMenu}
    [Return]                        ${userName}

Click on join with
    Click Element           xpath:${CreateGroup}
    Sleep                   2 second