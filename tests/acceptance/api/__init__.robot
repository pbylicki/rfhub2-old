*** Settings ***
| Resource | ../../keywords/miscKeywords.robot

| Suite Setup    | Start rfhub | --port | ${PORT} | --db | ${DB_URL}
| Suite Teardown | Stop rfhub
