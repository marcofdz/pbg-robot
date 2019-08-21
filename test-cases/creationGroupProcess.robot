*** Settings ***
Suite Setup                         Preparation
Library                             SeleniumLibrary
Resource                            ../resources/helpers/login.robot
Resource                            ../resources/pages/bussinesPage.robot
Resource                            ../resources/pages/claimPage.robot
Resource                            ../resources/pages/gmail.robot
Library                             FakerLibrary  


*** Variables ***
${nameGroup}                        Test
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

*** Test Cases ***
Create a group with total cost at one payment
    [Documentation]                 User should be able to create a new group
    ${nameG}=                       FakerLibrary.Word
    Create Group with total cost one payment          ${organizer_email}          ${nameG} ${nameGroup}        ${costGroup}
    ${groupName}=                   Get group name 
    Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 
    ${groupCode}=                   Get group code              
    Go to claim group link          ${organizer_email}
    ${URL}=                         Get Location
    Should Contain                  ${URL}                      ${groupCode}

# Create a group total with multiple payments
#     [Documentation]                 User should be able to create a new group allowing multiple payments
#     ${nameG}=                       FakerLibrary.Word
#     Create group with multiple over time payments   ${organizer_email}          ${nameG} ${nameGroup}        ${costGroup}       ${paymentsNumber}
#     ${groupName}=                   Get group name 
#     Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 

# Create a group total set cost based on group size
#     [Documentation]                 User should be able to create a new group
#     ${nameG}=                       FakerLibrary.Word
#     Create group with set cost based on group size     ${organizer_email}          ${nameG} ${nameGroup}     ${min}     ${max}     ${cost}        ${numberCostRange}
#     ${groupName}=                   Get group name 
#     Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 

# Create a group per slot cost at one payment
#     [Documentation]                 User should be able to create a new group
#     ${nameG}=                       FakerLibrary.Word
#     Create Group per slot one payment          ${organizer_email}          ${nameG} ${nameGroup}        ${costGroup}
#     ${groupName}=                   Get group name 
#     Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 

# Create a group per slot with multiple payments
#     [Documentation]                 User should be able to create a new group
#     ${nameG}=                       FakerLibrary.Word
#     Create group per slot with multiple over time payments   ${organizer_email}          ${nameG} ${nameGroup}        ${costGroup}       ${paymentsNumber}
#     ${groupName}=                   Get group name 
#     Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 

# Create a group per slot with set cost based on group size
#     [Documentation]                 User should be able to create a new group
#     ${nameG}=                       FakerLibrary.Word
#     Create group per slot and set cost based on group size     ${organizer_email}          ${nameG} ${nameGroup}     ${min}     ${max}     ${cost}        ${numberCostRange}
#     ${groupName}=                   Get group name 
#     Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 

# Claim group
#     ${group}                        Get group code        
#     Go to                           ${claim_page}${group}
#     Login as organizer toggle claim page            ${password}
#     Click Create Group
#     Add new payment method          ${cardTxt}      ${cvvTxt}       ${expDateTxt}       ${nameTxt}


*** Keywords ***
Preparation
    Star Browser                    ${business_page}              
    Login Business Page       