*** Settings ***
Library                        RequestsLibrary

*** Variable ***
${UserMenu}                    //button[@class="btn btn-link nav-link dropdown-toggle"]
${logOut}                      //a[@href="/logout"]
${contributeBtn}               //button[@class="btn btn-primary btn-block"]
${cardNumber}                  //input[@id="card_number"]
${cvv}                         //input[@id="cvv"]
${expDate}                     //input[@name="card.expDate"]
${fullname}                    //input[@name="card.fullName"]
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

Authenticate user session for REST API
    CreateSession               paybygroup              https://hodor.paybygroup.com                verify=true
    ${headers}=                 Create Dictionary       Content-Type=application/json
    ${data}=                    Create Dictionary       email=${email_user}         password=${password_user} 
    ${data_json}                json.dumps              ${data}   
    ${resp}=                    Post Request            paybygroup             /consumer/users/authenticate       headers=${headers}       data=${data_json} 
    ${session_id}=              Set Variable            ${resp.headers['Session-Id']}
    [Return]                    ${session_id}

Contribute to the group as guest_email
    [Arguments]                 
    contributeGroupAsGuest(Card:string, cvv:string, ExpDate:string, fullName:string, email:string, pass:string){
        wd.setValue(this.elements.cardNumber, Card);
        wd.setValue(this.elements.cvv, cvv);
        wd.setValue(this.elements.fullname, ExpDate);
        wd.setValue(this.elements.expDate, fullName);
        wd.setValue(this.elements.guest_email, email);
        wd.setValue(this.elements.guest_pass, pass);
        wd.click(this.elements.CreateGroup);
    }

    getUserName(){
        wd.getText(this.elements.UserMenu);