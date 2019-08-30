*** Settings ***
Library                             XvfbRobot
Library                             SeleniumLibrary
Library                             String
Resource                            ../${set}

*** Variables ***
${createGroupLink}       //*[@id="app-container"]/div/div/nav/div[2]/ul/a[1]/li/div/span
${name}                  //input[@name="name"]
${EmailOrganizer}        //input[@name="organizerEmail"]
${costInput}             //input[@name="costs[0].amount"]
${SendBnt}               //button[@name="button"]
${MerchanName}           //div[@class="dropdown merchant-selector"]/button/span
${FirstGroup}            //table[@class="data-table table"]/tbody/tr/td[4]
${FirstGroupCode}        //table[@class="data-table table"]/tbody/tr/td[1]/a
${allowMultiPayments}    //input[@name="allowMultiPayments"]
${addPaymentBtn}         //button[@class="btn btn-secondary"]
${costType}              //select[@name="costType"]
${allowOver}             //input[@name="allowMultiPayments"]
${setPrice}             //input[@name="allowPricingArray"]
${sendBnt}               //button[@name="button"]
${createsingle}         //a[@title="Create single payer purchase"]

*** Keywords ***
Create Group with total cost one payment
    [Arguments]                     ${organizer}                ${groupName}     ${cost}
    Click Element                   xpath:${createGroupLink}
    Input Text                      xpath:${EmailOrganizer}     ${organizer}  
    Input Text                      xpath:${name}               ${groupName}
    Input Text                      xpath:${costInput}          ${cost}
    Select From List By Value       xpath=${costType}           total
    Sleep                           3 second
    Click on send pay by group to customer 

Create group with multiple over time payments
    [Arguments]                     ${organizer}                ${groupName}     ${cost}        ${numbrePayments}
    Click Element                   xpath:${createGroupLink}
    Input Text                      xpath:${EmailOrganizer}     ${organizer}  
    Input Text                      xpath:${name}               ${groupName}
    Input Text                      xpath:${costInput}          ${cost}
    Select From List By Value       xpath=${costType}           total
    Add multiple payments in percentage       ${numbrePayments}
    Sleep                           3 second
    Click on send pay by group to customer 

Create group with set cost based on group size
    [Arguments]                     ${organizer}                ${groupName}     ${min}     ${max}     ${cost}        ${numberCostRange}
    Click Element                   xpath:${createGroupLink}
    Input Text                      xpath:${EmailOrganizer}     ${organizer}  
    Input Text                      xpath:${name}               ${groupName}
    Input Text                      xpath:${costInput}          ${cost}
    Select From List By Value       xpath=${costType}           total
    Set cost based on group size    ${min}     ${max}     ${cost}        ${numberCostRange}
    Sleep                           3 second
    Click on send pay by group to customer 

Get merchan name
    Sleep                           3 second
    [Return]                        Get Text                    ${MerchanName}

Get group name
    Sleep                           3 second
    ${name}=                        Get Text                    ${FirstGroup}
    [Return]                        ${name}

Get group code
    Sleep                           3 second
    ${code}=                        Get Text                    ${FirstGroupCode}
    [Return]                        ${code}

Click on allow payments over time
    Click Element                   xpath:${allowOver}
    Sleep                           3 second

Click on add payment  
    Click Element                   xpath:${addPaymentBtn}
    Sleep                           3 second

Add multiple payments in percentage
    [Arguments]                 ${numberPayments}
    Click on allow payments over time
    ${number}                   Convert To Number     ${numberPayments}.0
    ${percen}                   Evaluate        ${100.0}/${number}
    ${percen}                   Convert To Number          ${percen}        1
    ${percen}                   Convert To String          ${percen}
    :FOR        ${index}        IN RANGE        ${numberPayments}            
    \   Run Keyword If          ${index}>0      Click add new payment method  
    \   Run Keyword If          ${index}<(${numberPayments}-1)     Input Text              xpath://input[@name="payments[${index}].percentage"]         ${percen}        ELSE       Set last payment percentage        ${index}
    \   Click Element           xpath://input[@name="payments[${index}].dueDeadline"]
    \   Sleep                   2 second 

Add multiple payments per slot
    [Arguments]                 ${numberPayments}           ${cost} 
    Click on allow payments over time
    ${number}                   Convert To Number     ${numberPayments}.0
    ${cost}                     Convert To Number     ${cost}.0
    ${slot}                     Evaluate        ${cost}/${number}
    ${slot}                     Convert To Number          ${slot}        1
    ${slot}                     Convert To String          ${slot}
    :FOR        ${index}        IN RANGE        ${numberPayments}            
    \   Run Keyword If          ${index}>0      Click add new payment method  
    \   Input Text              xpath://input[@name="payments[${index}].perSlotAmount"]         ${slot}     
    \   Click Element           xpath://input[@name="payments[${index}].dueDeadline"]
    \   Sleep                   2 second 


Click on create a group
    Click Element                   xpath:${createGroupLink}
    Sleep                           3 second

Click on send pay by group to customer 
    Click Element                   xpath:${sendBnt}
    Sleep                           3 second

Click add new payment method
    Click Element               xpath:${addPaymentBtn}
    Sleep                       3 second

Set cost based on group size
    [Arguments]                 ${min}      ${max}      ${cost}     ${numberCostRange}         
    Click on set cost based on group size
    Input Text              xpath://input[@name="costs[0].minSlots"]         ${min} 
    :FOR        ${index}        IN RANGE        ${numberCostRange} 
    \   Run Keyword If          ${index}>0      Click add new payment method    
    \   Sleep                   2 second 
    \   ${minText}              Evaluate    ${min}+(4*${index}) 
    \   ${maxText}              Evaluate    ${max}+(3*${index})
    \   ${numberText}           Evaluate    ${cost}-(50*${index})   
    \   Input Text              xpath://input[@name="costs[${index}].maxSlots"]         ${maxText}   
    \   Input Text              xpath://div[@class="row mb-2"]/div[3]/div/div/input[@name='costs[${index}].amount' and @required='']           ${numberText}00
    \   Sleep                   2 second


Click on set cost based on group size
    Click Element                   xpath:${setPrice}
    Sleep                           3 second

Create Group per slot one payment
    [Arguments]                     ${organizer}                ${groupName}     ${cost}
    Click Element                   xpath:${createGroupLink}
    Input Text                      xpath:${EmailOrganizer}     ${organizer}  
    Input Text                      xpath:${name}               ${groupName}
    Input Text                      xpath:${costInput}          ${cost}
    Select From List By Value       xpath=${costType}           per_slot
    Sleep                           3 second
    Click on send pay by group to customer 

Create group per slot with multiple over time payments
    [Arguments]                     ${organizer}                ${groupName}     ${cost}        ${numbrePayments}
    Click Element                   xpath:${createGroupLink}
    Input Text                      xpath:${EmailOrganizer}     ${organizer}  
    Input Text                      xpath:${name}               ${groupName}
    Input Text                      xpath:${costInput}          ${cost}
    Select From List By Value       xpath=${costType}           per_slot
    Add multiple payments per slot  ${numbrePayments}           ${cost}
    Sleep                           3 second
    Click on send pay by group to customer 

Create group per slot and set cost based on group size
    [Arguments]                     ${organizer}                ${groupName}     ${min}     ${max}     ${cost}        ${numberCostRange}
    Click Element                   xpath:${createGroupLink}
    Input Text                      xpath:${EmailOrganizer}     ${organizer}  
    Input Text                      xpath:${name}               ${groupName}
    Select From List By Value       xpath=${costType}           per_slot
    Set cost based on group size    ${min}     ${max}     ${cost}        ${numberCostRange}
    Sleep                           3 second
    Click on send pay by group to customer 

Set last payment percentage
    [Arguments]     ${index}
    ${percen}=      Get Value        xpath://input[@name="payments[${index}].percentage"]
    Input Text      xpath://input[@name="payments[${index}].percentage"]         ${percen}

Go to business page
    Go to           ${business_page} 
    Sleep           2 second

Click on create single payer
    Click Element   xpath:${createsingle} 
    Sleep           2 second

Create single payer
    [Arguments]                     ${organizer}                ${groupName}        ${cost}
    Input Text                      xpath:${EmailOrganizer}     ${organizer}  
    Input Text                      xpath:${name}               ${groupName}
    Input Text                      xpath:${costInput}          ${cost}
    Sleep                           3 second
    Click on send pay by group to customer 
