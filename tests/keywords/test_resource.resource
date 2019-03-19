*** Settings ***
Documentation    File with .resource extension with one test keyword

*** Keywords ***
Keyword Imported From Resource File
    [Documentation]   This keyword was imported from file
    ...    with .resource extension, available since RFWK 3.1
    Log    This keyword was imported from file with .resource extension, available since RFWK 3.1