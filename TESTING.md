# Testing

## Unit tests

To run unit tests, cd to the folder with this file and run the following command:

    python -m unittest utests


## Acceptance tests
NOTE: Acceptance tests require Google Chrome browser and Chromedriver installed (http://chromedriver.chromium.org/downloads).

To run the acceptance tests, cd to the folder with this file and run the following commands:

### With SQLite Database

    robot -A tests/conf/default.args tests

### With PostgreSQL Database
NOTE: Make sure that you have local instance of Postgres database accessible with url
`postgresql://postgres:@localhost:5432/hub_test`
If you are using Docker you can set it up with command 
`docker run --rm -itd -p 5432:5432 -e POSTGRES_DB=hub_test postgres:alpine`
and then execute tests:

    robot -A tests/conf/postgres.args tests

If you want to run a single suite, you can use the --suite option. For example, 
either of the following commands will run just the search suite:

    robot -A tests/conf/default.args --suite tests.acceptance.doc.search tests
    robot -A tests/conf/default.args --suite search tests

The output files will be placed in tests/results.

Note: The tests start up a hub running on port 7071, so you don't have
to stop any currently running hub (though it also means you can't run
two tests concurrently). 
