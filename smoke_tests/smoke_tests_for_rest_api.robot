*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    HttpLibrary.HTTP

Resource    ../res/common.robot

Suite Teardown    Delete All Sessions

*** Test Cases ***
Response code using valid user
    Create Session    ${ALIAS}    ${HOST}    verify=${VERIFY_SSL}
    ${response}    Get Request    ${ALIAS}    /users/userwizz   
    Should Be Equal As Strings    ${response.status_code}    200 
    
Response code using invalid user
    Create Session    ${ALIAS}    ${HOST}    verify=${VERIFY_SSL}
    ${response}    Get Request    ${ALIAS}    /users/does_not_exists   
    Should Be Equal As Strings    ${response.status_code}    404 
    
Verify MIME type
    Create Http Context    api.github.com    scheme=https
    HttpLibrary.HTTP.GET    /users/userwizz
    Follow Response
    Response Should Have Header    Content-Type
 