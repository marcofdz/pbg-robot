*** Settings ***
Suite Setup                         Preparation
Library                             SeleniumLibrary
Resource                            ../resources/helpers/login.robot
Resource                            ../resources/pages/bussinesPage.robot
Resource                            ../resources/pages/claimPage.robot
Library                             FakerLibrary                            
Resource                            ../resources/pages/gmail.robot


*** Variables ***
${nameGroup}                        Test
${costGroup}                        450000
${cardTxt}                          4111111111111111
${cvvTxt}                           123
${expDateTxt}                       12/24
${nameTxt}                          Marco Fernandez
${paymentsNumber}                   4
${min}                              2
${max}                              4
${cost}                             500
${numberCostRange}                  3

*** Test Cases ***
Create a single payer purchase
    [Documentation]                 User should be able to create a new group
    ${nameG}=                       FakerLibrary.Word
    Click on create single payer
    Create single payer             ${organizer_email}          ${nameG} ${nameGroup}        ${costGroup}
    ${groupName}=                   Get group name 
    Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 
    ${groupCode}=                   Get group code              
    Go to claim group link          ${organizer_email} 
    ${URL}=                         Get Location
    Should Contain                  ${URL}                      ${groupCode}
   
*** Keywords ***
Preparation
    Star Browser                    ${business_page}              
    Login Business Page  