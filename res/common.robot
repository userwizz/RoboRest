*** Settings ***


*** Variables ***
${RESOURCES}    ../res
${HOST}    https://api.github.com/users
${VERIFY_SSL}    true
${ALIAS}    ${HOST} 
${VALID_USER}    userwizz 
${INVALID_USER}  does_not_exists
${DATA_TYPE}    application/json