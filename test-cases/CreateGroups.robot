*** Settings ***
Suite Setup                         Preparation
Library                             SeleniumLibrary
Resource                            ../resources/helpers/login.robot
Resource                            ../resources/pages/bussinesPage.robot
Resource                            ../resources/pages/claimPage.robot
Library                             FakerLibrary                            

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
Create a group total with three payment
    [Documentation]                 User should be able to create a new group
    ${nameG}=                       FakerLibrary.Word
    Create group with multiple over time payments   ${organizer_email}          ${nameG} ${nameGroup}        ${costGroup}       ${paymentsNumber}
    ${groupName}=                   Get group name 
    Should Be Equal                 ${groupName}                ${nameG} ${nameGroup} 

*** Keywords ***
Preparation
    Star Browser                    ${business_page}              
    Login Business Page  