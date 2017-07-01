*** Settings ***
Library    RequestsLibrary
Library    HttpLibrary.HTTP
Library    ../lib/Pinger.py
Resource    ../res/resources.robot
Variables    ../res/variables.py

*** Variables ***
${json_string}    Set during test
${given_city}    Set during test


*** Keywords ***
Create a new HTTP session
    Create Session    ${ALIAS}    ${BASE_URL_GITHUB}    verify=${VERIFY_SSL} 
    
## BDD ##    
User connects to weather service
	Create Session  openweather  ${BASE_URL_OPENWEATHER}

He requests weather info for
    [Arguments]    ${city} 
	&{params}   Create Dictionary   q=${city}     appid=${APPID}
    ${response}    Get Request    openweather    /    params=${params} 
    Should Be Equal As Strings    ${response.status_code}     200
	${json_data}    Parse Json    ${response.content} 
    ${json_string}    Stringify Json    ${json_data}
    Set Test Variable    ${json_string} 
    Set Test Variable    ${given_city}    ${city} 
       
He should be able to get data for correct city
    Json Value Should Equal    ${json_string}    /name   "${given_city}"
    
    
## Own python lib
Ping host and verfiy response
    [Arguments]    ${host_to_ping}
    ${response}    Ping host    ${host_to_ping}
    Verify response    ${response}    
    
    