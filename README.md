# Robot Framework Hub

[![Build Status](https://travis-ci.org/pbylicki/robotframework-hub.svg?branch=master)](https://travis-ci.org/pbylicki/robotframework-hub)

This is a very early version of a server for the robot framework
testing framework. The hub uses flask to provide both a RESTful
interface and a browser-based UI for accessing test assets. 

It's crazy easy to get started. To install and run from a PyPi
package, do the following:

```
    $ pip install robotframework-hub
    # or if you want to use Postgres as underlying database
    $ pip install robotframework-hub[postgresql]
    $ python -m rfhub
```

To run from source it's the same, except intead of installing,
you cd to the folder that has this file. 

That's it! You can now browse documentation by visiting the url
http://localhost:7070/doc/

Want to browse your local robotframework assets? Just include
the path to your test suites or resource files on the command
line:

```
    $ python -m rfhub /path/to/test/suite
```
By default it will create in-memory SQLite database. 
If you want to run it with persistent database (for example PostgreSQL):

```
    $ python -m rfhub --db postgresql://postgres:@localhost:5432/db /path/to/test/suite
```

NOTE: Application uses SQLAlchemy for database interaction. 
In order to use it with specific database you need to install related Python package
(like `psycopg2` for PostgreSQL)

## Web and Worker modes
By default application is responsible for both loading data to database and running web server.
If you want to run them separately, for example to deploy server without access to actual library files
and load data periodically to shared database, you can run application in web and worker modes:

```
    $ python -m rfhub --db postgresql://postgres:@localhost:5432/db --web
    $ python -m rfhub --db postgresql://postgres:@localhost:5432/db --worker
```
Web process skips loading library data (but it tries to create required tables if they are not yet created) 
and starts web server.

Worker process creates tables if required, loads library data and exits.

## Websites

Source code, screenshots, and additional documentation can be found here:

 * Source code: https://github.com/boakley/robotframework-hub
 * Project wiki: https://github.com/boakley/robotframework-hub/wiki

## Acknowledgements

A huge thank-you to Echo Global Logistics (echo.com) for supporting
the development of this package.
