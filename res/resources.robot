*** Settings ***
Library    RequestsLibrary
Library    HttpLibrary.HTTP
Library    Collections
Library    Selenium2Library
Library    ../lib/Pinger.py

Resource    ../res/resources.robot
Variables    ../res/variables.py

*** Variables ***
${json_string}    Set during test
${given_city}    Set during test
${browser}    Firefox
${my_proxy}    your.proxy:1234


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
    
    
## To open browser using custom webdriver (behind proxy in this case)
Open browser using webdriver
	${proxy} 	Evaluate 	sys.modules['selenium.webdriver'].Proxy() 	sys, selenium.webdriver
	${proxy.http_proxy} 	Set Variable 	${my_proxy}	
	Create Webdriver 	${browser}    proxy=${proxy}

    
    