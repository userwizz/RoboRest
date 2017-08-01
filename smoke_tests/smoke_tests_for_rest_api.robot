*** Settings ***
Resource    ../res/resources.robot
Variables    ../res/variables.py

Suite Setup    Create a new HTTP session
Suite Teardown    Delete All Sessions


*** Test Cases ***
Response code using valid user
    ${response}    Get Request    ${ALIAS}    ${VALID_USER}   
    Should Be Equal As Strings    ${response.status_code}    200 
    
Response code using invalid user
    ${response}    Get Request    ${ALIAS}    ${INVALID_USER["value"]}
    Should Be Equal As Strings    ${response.status_code}    404 
    
Verify MIME data type (JSON)
    ${response}    Head Request    ${ALIAS}    ${VALID_USER}  
    Should Be Equal As Strings  ${response.status_code}  200
    Should Contain    ${response.headers.get("content-type")}	${DATA_TYPE} 
      
Verify attribute from JSON payload
    ${response}    Get Request    ${ALIAS}    ${VALID_USER}
    ${json_data}    Parse Json    ${response.content} 
    Should Be Equal    ${json_data["login"]}    ${VALID_USER}        
    # another way to do same as above..
    ${json_data}    Stringify Json    ${json_data}
    Json Value Should Equal    ${json_data}    /login    "${VALID_USER}"

Verify that user can get weather forecast for given city
    [Documentation]    BDD style test with params in GET request
    [Tags]  bdd
    Given User connects to weather service
    When He requests weather info for    Helsinki
    Then He should be able to get data for correct city
    
Verify that host is alive
	[Documentation]    Data-driven test, utilizing own python lib
    [Template]    Ping host and verfiy response
    google.com
    localhost
    does_not_exists
    

	
    