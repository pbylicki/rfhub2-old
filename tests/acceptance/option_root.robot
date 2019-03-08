*** Settings ***
Library             SeleniumLibrary
Resource            ../keywords/miscKeywords.robot
Test Teardown     Stop Rfhub And Close Browser

*** Variables ***
${ROOT}    http://${HOST}:${PORT}

*** Test Cases ***
Specify --root /doc
    [Documentation]     Verify that --root /doc works properly
    [Setup]     run keywords
    ...     start rfhub    --port    ${PORT}    --root    /doc
    ...     AND   open browser    ${ROOT}    ${BROWSER}
    Go To    ${ROOT}/
    Location Should Be    ${ROOT}/doc/

Use default root (no --root option)
    [Documentation]     Verify that when --root is not supplied, we go to dashboard
    [Setup]     run keywords
    ...    start rfhub    --port    ${PORT}
    ...    AND    open browser    ${ROOT}    ${BROWSER}
    Go To    ${ROOT}/
    Location Should Be    ${ROOT}/dashboard/

*** Keywords ***
Stop Rfhub And Close Browser
     Stop Rfhub
     Close All Browsers