*** Settings ***
Resource            ../resources/pages/resourcesPage.robot
Resource            ../resources/${set}
Library             json
Library             FakerLibrary
Library             Collections
Library             requests

***Variables***       
${amount_cents}     200000
${currency_code}    USD
${min_slots}        1
${max_slots}        3
${name}             Test API AUtomation
${cost_type}        total
${legal_document_ids}     03DEFD52-E46C-42CF-BD88-A61EB5A61BB5  
${percentage}       100
${Authorization}    Basic MTUxNzNmNTc0NDI3NzFjMWJmZmY1OTNlNjcyOGFhOmMweW1rU0pyNU1Qc1ZMQUFWZkt0UnNvUWNqMG1oUU5aTzZPcFJ3OVdYV1VwamRTcndvN1BPQT09
${split}            even_split

***Test Cases***
Create a group by API REST
    ${session_id}=              Authenticate user session for REST API  
    Set Global Variable         ${session_id}
    CreateSession               paybygroup              https://hodor.paybygroup.com       verify=true
    ${headers}=                 Create Dictionary       Content-Type=application/json      Authorization=${Authorization}    Session-Id=${session_id}    Accept=*/*    Content-Length=52
    ${amount}                   Create Dictionary       amount_cents=${amount_cents}       currency_code=${currency_code}       
    ${costs}                    Create Dictionary       min_slots=${min_slots}             amount=${amount} 
    ${costs}                    Create List             ${costs}       
    ${product}                  Create Dictionary       name=${name}    costs=${costs}    cost_type=${cost_type} 
    ${group}                    Create Dictionary       organizer_full_name=${user_name}     organizer_email=${organizer_email}
    ${payment}                  Create Dictionary       percentage=${percentage}
    ${payment}                  Create List             ${payment}
    ${data}                     Create Dictionary       product=${product}     group=${group}     payments=${payment}        language_code=en 
    ${data_json}                json.dumps              ${data}   
    ${resp}=                    Post Request            paybygroup    /purchases    headers=${headers}       data=${data_json} 
    Should Be Equal As Strings  ${resp.status_code}     201 
    ${id}                       Get From Dictionary     ${resp.json()}          slug
    Log To Console              ${resp.json()}
    Set Global Variable         ${id}

Use code in next API 
    CreateSession               paybygroup              https://hodor.paybygroup.com                verify=true
    ${headers}=                 Create Dictionary       Content-Type=application/json       Authorization=${Authorization}      Session-Id=${session_id}    Accept=*/*      Content-Length=52
    ${group}                    Create Dictionary       split_type=${split}       min_slots=${min_slots} 
    ${data}                     Create Dictionary       organizer_email=${organizer_email}      group=${group}
    ${data_json}                json.dumps              ${data}
    Log To Console              ${data_json}
    ${resp}=                    Post Request            paybygroup             /purchases/${id}/claim       headers=${headers} 
    Should Be Equal As Strings  ${resp.status_code}     200 
    Log To Console              ${resp.json()}
    ${resp_id}                  Get From Dictionary     ${resp.json()}          id
    ${resp_status}              Get From Dictionary     ${resp.json()}          status
    Should Be Equal As Strings  ${resp_id}              ${id}
    Should Be Equal As Strings  ${resp_status}          active

# Invite payer
#     CreateSession               paybygroup              https://hodor.paybygroup.com                verify=true
#     ${headers}=                 Create Dictionary       Content-Type=application/json      Authorization=${Authorization}    Session-Id=${session_id}    Accept=*/*      Content-Length=52
#     ${invitees}                 Create Dictionary       email=mfernandez+test@paybygroup.com    full_name=M Fernandez
#     ${llowed}                   Create Dictionary       amount_cents=50000   currency_code=USD   
#     ${invitees2}                Create Dictionary       email=mfernandez+test1@aybygroup.com    full_name=M Fedez       allowed_share_amount=${llowed} 
#     ${invite}                   Create List             ${invitees}     ${invitees2}
#     Log To Console              ${invite}
#     ${resp}=                    Post Request            paybygroup             /purchases/${id}/claim       headers=${headers} 
#     Should Be Equal As Strings  ${resp.status_code}     200 
#     Log To Console              ${resp.json()}