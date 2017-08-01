*** Settings ***
Resource    ../res/resources.robot

Suite Setup    Open browser using webdriver
Suite Teardown    Close All Browsers

*** Test Cases ***
Verify google search result
    [Documentation]    Basic google search
    [Tags]    selenium
	Go To    http://google.com
	Input Text    name=q    robotFramework
	Submit Form
	Wait Until Page Contains    robotframework.org    5    
	
