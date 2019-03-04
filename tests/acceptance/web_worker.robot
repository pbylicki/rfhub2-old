*** Settings ***
| Library         | OperatingSystem
| Library         | Process
| Library         | RequestsLibrary
| Resource        | ../keywords/APIKeywords.robot
| Resource        | ../keywords/miscKeywords.robot
| Suite Setup     | Create session | rfhub | url=http://${host}:${port}
| Suite Teardown  | Delete All Sessions

*** Variables ***
| ${DB_PATH}       | tmp_keywords.db
| ${SHARED_DB_URL} | sqlite:///${DB_PATH}
| @{options}
| ... | --no-installed-keywords | Easter

*** Test Cases ***
| Application in worker mode should terminate
| | [Documentation]
| | ... | Verify that application terminates without running web server with --worker flag
| | Run rfhub worker | @{options}

| Application in web mode should not load libraries
| | [Documentation]
| | ... | Verify that application starts web server without loading libraries with --web flag
| | [Teardown]
| | ... | Stop rfhub
| | Start rfhub | --web | --port | ${PORT} | @{options}
| | Do a GET on | /api/keywords
| | Length Should Be | ${JSON['keywords']} | 0

| Application in web mode should be populated by worker
| | [Documentation]
| | ... | Verify that application running web server can be populated by running worker on shared database
| | [Teardown]
| | ... | Run Keywords | Stop rfhub | AND | Remove File | ${DB_PATH}
| | Start rfhub | --web | --port | ${PORT} | --db | ${SHARED_DB_URL} | @{options}
| | Do a GET on | /api/keywords
| | Length Should Be | ${JSON['keywords']} | 0
| | Run rfhub worker | --db | ${SHARED_DB_URL} | @{options}
| | Do a GET on | /api/keywords
| | Length Should Be | ${JSON['keywords']} | 1

*** Keywords ***
| Run rfhub worker
| | [Arguments] | @{options}
| | [Documentation]
| | ... | Starts rfhub in worker mode
| | ${python}= | Evaluate | sys.executable | sys
| | ${worker_process}= | Start process | ${python} | -m | rfhub | --worker | @{options}
| | Wait For Process | ${worker_process} | 20 seconds | on_timeout=kill
| | ${result}= | Get process result
| | Run keyword if | len('''${result.stderr}''') > 0
| | ... | log | rfhub stderr: ${result.stderr} | DEBUG
| | Should Be Equal As Integers | ${result.rc} | 0
