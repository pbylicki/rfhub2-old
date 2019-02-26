*** Settings ***
| Resource | ../../keywords/miscKeywords.robot

| Suite Setup    | Start rfhub | --port | ${PORT}
| Suite Teardown | Stop rfhub
