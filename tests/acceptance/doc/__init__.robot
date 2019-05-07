*** Settings ***
Resource    ../../keywords/miscKeywords.robot

Suite Setup    Start rfhub    --port    ${PORT}    --db    ${DB_URL}
# we want to control pricisely which libraries are loaded,
# so we aren't so dependent on what is actually installed
...    --no-installed-keywords
...    tests/keywords
...    tests/fixtures
...    BuiltIn
...    Collections
...    Easter
...    Screenshot
...    SeleniumLibrary
Suite Teardown  Stop rfhub

*** Variables ***
${HOST}    localhost
${PORT}    7071
${ROOT}    http://${HOST}:${PORT}