*** Settings ***
Library    RequestsLibrary
Library    HttpLibrary.HTTP
Resource    ../res/resources.robot
Variables    ../res/variables.py


*** Keywords ***
Create a new HTTP session
    Create Session    ${ALIAS}    ${HOST}    verify=${VERIFY_SSL}
