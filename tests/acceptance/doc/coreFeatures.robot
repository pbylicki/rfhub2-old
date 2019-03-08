*** Settings ***
Library            Collections
Library            SeleniumLibrary
Resource           ../../keywords/APIKeywords.robot
Suite Setup        Run keywords
...                Create session    rfhub    url=http://${host}:${port}    AND
...                Open Browser    ${ROOT}    ${BROWSER}
Test Setup         Run keywords
...                Get list of libraries via the API    AND
...                Go to    ${ROOT}/doc/
Suite Teardown     Run keywords
...                Delete All Sessions    AND
...                Close All Browsers

*** Variables ***
${ROOT}    http://${HOST}:${PORT}

*** Test Cases ***
Nav panel shows correct number of collections
    [Documentation]    Verify that the nav panel has the correct number of items
    [Tags]    navpanel
    ${actual}    Get Element Count    //*[@id="left"]/ul/li/label
    # why 8? Because we explicitly load 5 libraries 
    # and two resource files in the setup
    Should Be Equal As Integers    ${actual}    7
    ...    Expected 7 items in navlist, found ${actual}

Nav panel shows all libraries
    [Documentation]    Verify that the nav panel shows all of the libraries
    [Tags]    navpanel
    FOR    ${lib}    IN    @{libraries}
       Page Should Contain Element
       ...    //*[@id="left"]/ul/li/label[./text()='${lib["name"]}']
       ...    limit=1
    END

Main panel shows correct number of libraries
    [Documentation]    Verify that the main panel has the correct number of items
    [Tags]    navpanel
    ${actual}    Get Element Count    //*[@id="right"]/div[1]/table/tbody/tr/td/a
    # why 5? Because we explicitly load 5 libraries in the suite setup
    Should Be Equal As Integers    ${actual}    5
    ...    Expected 5 items in navlist, found ${actual}

Main panel shows all libraries
    [Documentation]    Verify that the main panel shows all of the libraries
    FOR    ${lib}    IN    @{libraries}
       ${name}    Get from dictionary    ${lib}    name
       Page Should Contain Element
       ...    //*[@id="right"]//a[./text()='${name}']
       ...    limit=1
    END

Main panel shows all library descriptions
    [Documentation]    Verify that the main panel shows all of the library descriptions
    ${section}=    Set variable    
    FOR    ${lib}    IN    @{libraries}
       ${expected}=    Get from dictionary    ${lib}    synopsis
       ${actual}=      Get text    //*[@id="right"]//a[text()='${lib["name"]}']/../following-sibling::td
       Should be equal    ${expected}    ${actual}
    END

*** Keywords ***
Get list of libraries via the API
    [Documentation] 
    ...    Uses the hub API to get a list of libraries.
    ...    The libraries are stored in a suite-level variable
    # N.B. 'Do a git on' stores the response in a test variable named ${JSON}
    Do a get on    /api/libraries
    ${libraries}=    Get From Dictionary    ${JSON}    libraries
    Set suite variable    ${libraries} 

