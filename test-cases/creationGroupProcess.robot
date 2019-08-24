*** Settings ***
Suite Setup                         Preparation
Library                             SeleniumLibrary
Resource                            ../resources/helpers/login.robot
Resource                            ../resources/pages/bussinesPage.robot
Resource                            ../resources/pages/claimPage.robot
Resource                            ../resources/pages/gmail.robot
Library                             FakerLibrary  


*** Variables ***
${nameGroup}                        Test Group
${costGroup}                        450000
${cardTxt}                          4111111111111111
${cvvTxt}                           123
${expDateTxt}                       12/24
${nameTxt}                          Marco Fernandez
${paymentsNumber}                   3
${min}                              2
${max}                              4
${cost}                             500
${numberCostRange}                  3
${org_email}                        mfernandez+test@paybygroup.com

*** Test Cases ***
Create a group with total cost at one payment
    Go to business page
    ${nameG}=                       FakerLibrary.Word
    Create Group with total cost one payment          ${organizer_email}        ${nameG} ${nameGroup}        ${costGroup}
    ${groupName}=                   Get group name 
    Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 
    ${groupCode}=                   Get group code              
    Go to claim group link          ${organizer_email} 
    ${URL}=                         Get Location
    Should Contain                  ${URL}                      ${groupCode}
    Login as organizer toggle claim page        ${password}         
    Click Create Group
    Click on join with
    Page Should Contain Element     xpath://h1[@title="${nameG} ${nameGroup}"]


Create a group total with multiple payments
    Go to business page
    ${nameG}=                       FakerLibrary.Word
    Create group with multiple over time payments   ${organizer_email}          ${nameG} ${nameGroup}        ${costGroup}       ${paymentsNumber}
    ${groupName}=                   Get group name 
    Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 
    ${groupCode}=                   Get group code              
    Go to claim group link          ${organizer_email} 
    ${URL}=                         Get Location
    Should Contain                  ${URL}                      ${groupCode}       
    Click Create Group
    Click on join with
    Page Should Contain Element     xpath://h1[@title="${nameG} ${nameGroup}"]
    
Create a group total set cost based on group size
    Go to business page
    ${nameG}=                       FakerLibrary.Word
    Create group with set cost based on group size     ${organizer_email}          ${nameG} ${nameGroup}     ${min}     ${max}     ${cost}        ${numberCostRange}
    ${groupName}=                   Get group name 
    Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 
    ${groupCode}=                   Get group code              
    Go to claim group link          ${organizer_email} 
    ${URL}=                         Get Location
    Should Contain                  ${URL}                      ${groupCode}        
    Click Create Group
    Click on join with
    Page Should Contain Element     xpath://h1[@title="${nameG} ${nameGroup}"]

Create a group per slot cost at one payment
    Go to business page
    ${nameG}=                       FakerLibrary.Word
    ${org_email}=                   Catenate         ${user}${nameG}${domain}   #The email is type mfernandez+(word)@paybygroup.com
    Log To Console                  ${org_email}
    Create Group per slot one payment          ${organizer_email}          ${nameG} ${nameGroup}        ${costGroup}
    ${groupName}=                   Get group name 
    Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 
    ${groupCode}=                   Get group code              
    Go to claim group link          ${organizer_email} 
    ${URL}=                         Get Location
    Should Contain                  ${URL}                      ${groupCode}        
    Click Create Group
    Click on join with
    Page Should Contain Element     xpath://h1[@title="${nameG} ${nameGroup}"]

Create a group per slot with multiple payments
    Go to business page
    ${nameG}=                       FakerLibrary.Word
    Create group per slot with multiple over time payments   ${organizer_email}          ${nameG} ${nameGroup}        ${costGroup}       ${paymentsNumber}
    ${groupName}=                   Get group name 
    Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 
    ${groupCode}=                   Get group code              
    Go to claim group link          ${organizer_email} 
    ${URL}=                         Get Location
    Should Contain                  ${URL}                      ${groupCode}        
    Click Create Group
    Click on join with
    Page Should Contain Element     xpath://h1[@title="${nameG} ${nameGroup}"]

Create a group per slot with set cost based on group size
    Go to business page
    ${nameG}=                       FakerLibrary.Word
    Create group per slot and set cost based on group size     ${organizer_email}          ${nameG} ${nameGroup}     ${min}     ${max}     ${cost}        ${numberCostRange}
    ${groupName}=                   Get group name 
    Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 
    ${groupCode}=                   Get group code              
    Go to claim group link          ${organizer_email} 
    ${URL}=                         Get Location
    Should Contain                  ${URL}                      ${groupCode}       
    Click Create Group
    Click on join with
    Page Should Contain Element     xpath://h1[@title="${nameG} ${nameGroup}"]

*** Keywords ***
Preparation
    Star Browser                    ${business_page}              
    Login Business Page       