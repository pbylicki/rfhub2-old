*** Settings ***
Library            Collections
Library            SeleniumLibrary
Library            String
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
    Element Count Should Be    //*[@id="left"]/ul/li/label    12
    # why 12? Because we explicitly load 9 libraries
    # and 3 resource files in the setup

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
    Element Count Should Be    //*[@id="right"]/div[1]/table/tbody/tr/td/a    9
    # why 9? Because we explicitly load 9 libraries in the suite setup

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
    FOR    ${lib}    IN    @{libraries}
       ${expected}=    Get from dictionary    ${lib}    synopsis
       ${actual}=      Get text    //*[@id="right"]//a[text()='${lib["name"]}']/../following-sibling::td
       Should be equal    ${expected}    ${actual}
    END

Main panel shows robot files with .resource extension
    [Documentation]    Main panel shows robot files with .resource extension
    FOR    ${lib}    IN    @{libraries}
       ${lib_name}    Get From Dictionary    ${lib}    name
       Exit For Loop If    '${lib_name}'=='test_resource'
    END
    Dictionary Should Contain Item    ${lib}    synopsis    File with .resource extension with one test keyword
    Dictionary Should Contain Item    ${lib}    type        resource

Main panel shows libraries with init as one library
    [Documentation]    Main panel shows libraries with init as one library
    Element Count Should Be    //*[@id="left"]/ul/li/label[./text()='LibWithInit']    1
    Click Element    //*[@id="summary-libraries"]/table/tbody//*/a[text()='LibWithInit']
    Sleep    0.5s
    Element Text Should Be    //*[@id="right"]/h1    LibWithInit
    Page Should Contain Texts    Lib With Init 1 Method 1, Lib With Init 1 Method 2, Lib With Init 2 Method 1, Lib With Init 2 Method 2

Main panel shows libraries with empty init as separate libraries
    [Documentation]    Main panel shows libraries with empty init as separate libraries
    Element Count Should Be    //*[@id="left"]/ul/li/label[./text()='LibWithEmptyInit2']    1
    Click Element    //*[@id="summary-libraries"]/table/tbody//*/a[text()='LibWithEmptyInit2']
    Sleep    0.5s
    Element Text Should Be    //*[@id="right"]/h1    LibWithEmptyInit2
    Page Should Contain Texts    Lib With Empty Init 2 Method 1, Lib With Empty Init 2 Method 2

Main panel shows single file library that has class named like file
    [Documentation]    Main panel shows single file library that has class named like file
    Element Count Should Be    //*[@id="left"]/ul/li/label[./text()='SingleClassLib']    1
    Click Element    //*[@id="summary-libraries"]/table/tbody//*/a[text()='SingleClassLib']
    Sleep    0.5s
    Element Text Should Be    //*[@id="right"]/h1    SingleClassLib
    Page Should Contain Texts    Single Class Lib Method 1, Single Class Lib Method 2

*** Keywords ***
Get list of libraries via the API
    [Documentation] 
    ...    Uses the hub API to get a list of libraries.
    ...    The libraries are stored in a suite-level variable
    # N.B. 'Do a git on' stores the response in a test variable named ${JSON}
    Do a get on    /api/libraries
    ${libraries}=    Get From Dictionary    ${JSON}    libraries
    Set suite variable    ${libraries} 

Element Count Should Be
    [Documentation]    Checks if element count is equal to expected
    [Arguments]    ${element_locator}    ${expected_count}
    ${count}  Get Element Count    ${element_locator}
    Should Be Equal As Integers    ${expected_count}    ${count}    Expected ${expected_count}, found ${count}!

Page Should Contain Texts
    [Documentation]   Checks if page contains given texts, separated by ', ' in loop.
    [Arguments]   ${texts}
    ${texts}    Split String    ${texts}    separator=,${SPACE}
    FOR    ${text}    IN    @{texts}
        Page Should Contain    ${text}
    END