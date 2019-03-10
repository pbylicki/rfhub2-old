*** Settings ***
Library            RequestsLibrary
Library            Collections
Resource           ../../keywords/APIKeywords.robot
Suite Setup        Create session    rfhub    url=http://${host}:${port}
Suite Teardown     Delete All Sessions
Force Tags         api


*** Variables ***
@{all data keys} 
...    api_keyword_url    api_library_url    args    doc
...    doc_keyword_url    library    collection_id
...    name    synopsis

*** Test Cases ***
Query with no ?fields parameter returns all expected fields
    [Setup]    Run keywords
    ...    Do a GET on    /api/keywords?pattern=none+shall+pass
    ...    AND    Get first returned keyword
    FOR    ${key}    IN    @{all data keys}
       dictionary should contain key    ${KEYWORD}    ${key}
    END

Query with explicit fields (?fields=name,synopsis)
    [Setup]    Run keywords
    ...    Do a GET on    /api/keywords?pattern=none+shall+pass&fields=name,synopsis
    ...    AND    Get first returned keyword
    ${expected keys}=    create list    name    synopsis
    ${keys}=       Get dictionary keys    ${KEYWORD}
    Sort list      ${keys}
    lists should be equal    ${keys}    ${expected keys}
    ...    Expected ${expected keys} but got ${keys}

Query Keywords From Single Library Should Return Right Keywords
    [Documentation]    When quering single library via API a list of all keywords
    ...    from this library should be returned.
    ...    Assumption for this tests is that it checks Easter Library.
    ${library_id}    Get Library Id From Api By Name    Easter
    Do a GET on    /api/keywords/${library_id}
    Get first returned keyword
    ${keywords list}=    Get from dictionary    ${JSON}    keywords
    Should Not Be Empty    ${keywords list}
    Length Should Be    ${keywords list}    1

*** Keywords ***
Get first returned keyword
    [Documentation]
    ...    Returns the first keyword from the result of the most recent GET
    ...    This pulls out the first keyword from the test variable ${JSON}
    ...    and stores it in the test variable ${KEYWORD}
    ${keywords list}=    Get from dictionary    ${JSON}    keywords
    ${KEYWORD}=    Get from list    ${keywords list}    0
    Set test variable    ${KEYWORD}

Get Library Id From Api By Name
    [Documentation]    Loops results form get /api/libraries until specified name is found.
    [Arguments]    ${name}
    Do a GET on    /api/libraries
    FOR    ${library}   IN    @{JSON['libraries']}
        Run Keyword If    '${library['name']}'=='${name}'    Return From Keyword    ${library['collection_id']}
    END