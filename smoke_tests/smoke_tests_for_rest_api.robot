*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    HttpLibrary.HTTP

Resource    ../res/common.robot

Suite Teardown    Delete All Sessions

*** Test Cases ***
Response code using valid user
    Create Session    ${ALIAS}    ${HOST}    verify=${VERIFY_SSL}
    ${response}    Get Request    ${ALIAS}    ${VALID_USER}   
    Should Be Equal As Strings    ${response.status_code}    200 
    
Response code using invalid user
    Create Session    ${ALIAS}    ${HOST}    verify=${VERIFY_SSL}
    ${response}    Get Request    ${ALIAS}    ${INVALID_USER}    
    Should Be Equal As Strings    ${response.status_code}    404 
    
Verify MIME data type (JSON)
    [Tags]  get
    Create Session    ${ALIAS}    ${HOST}    verify=${VERIFY_SSL}
    ${response}    Head Request    ${ALIAS}    ${VALID_USER}  
    Should Be Equal As Strings  ${response.status_code}  200
    Should Contain    ${response.headers.get("content-type")}	${DATA_TYPE}   

Verify attribute from JSON payload
	Create Session    ${ALIAS}    ${HOST}    verify=${VERIFY_SSL}
    ${response}    Get Request    ${ALIAS}    ${VALID_USER}
    ${json_data}    Parse Json    ${response.content} 
    Should Be Equal    ${json_data["login"]}    ${VALID_USER}        
    # another way to do same as above..
    ${json_data}    Stringify Json    ${json_data}
    Json Value Should Equal    ${json_data}    /login    "${VALID_USER}"
    
