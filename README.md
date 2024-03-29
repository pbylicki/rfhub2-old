# rfhub2

[![Build Status](https://travis-ci.org/pbylicki/rfhub2.svg?branch=master)](https://travis-ci.org/pbylicki/rfhub2)
[![image](https://img.shields.io/pypi/v/rfhub2.svg)](https://pypi.org/project/rfhub2/)
[![image](https://img.shields.io/pypi/pyversions/rfhub2.svg)](https://pypi.org/project/rfhub2/)
[![image](https://img.shields.io/pypi/wheel/rfhub2.svg)](https://pypi.org/project/rfhub2/)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/pbylicki/rfhub2.svg)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/pbylicki/rfhub2.svg)

rfhub2 is a new take on [rfhub](https://github.com/boakley/robotframework-hub) 
created by [Bryan Oakley](https://github.com/boakley).

It's purpose is to enable working with rfhub web server also as a shared application
for storing and updating Robot Framework documentation on server with persistent database.

This is a very early version of a server for the Robot Framework
libraries documentation. The hub uses flask to provide both REST API
and a browser-based UI for accessing documentation. 

It's crazy easy to get started. To install and run from a PyPi
package, do the following:

```
    $ pip install rfhub2
    # or if you want to use Postgres as underlying database
    $ pip install rfhub2[postgresql]
    # run web server from installed package
    $ rfhub2
    # run web server from source root directory
    $ python -m rfhub2
``` 

That's it! You can now browse documentation by visiting the url
http://localhost:7070/doc/

Want to browse your local Robot Framework assets? Just include
the path to your test suites or resource files on the command
line:

```
    $ python -m rfhub2 /path/to/test/suite
```
By default it will create in-memory SQLite database. 
If you want to run it with persistent database (for example PostgreSQL):

```
    $ python -m rfhub2 --db postgresql://postgres:@localhost:5432/db /path/to/test/suite
```

NOTE: Application uses SQLAlchemy for database interaction. 
In order to use it with specific database you need to install related Python package
(like `psycopg2` for PostgreSQL)

## Web and Worker modes
By default application is responsible for both loading data to database and running web server.
If you want to run them separately, for example to deploy server without access to actual library files
and load data periodically to shared database, you can run application in web and worker modes:

```
    $ python -m rfhub2 --db postgresql://postgres:@localhost:5432/db --web
    $ python -m rfhub2 --db postgresql://postgres:@localhost:5432/db --worker
```
Web process skips loading library data (but it tries to create required tables if they are not yet created) 
and starts web server.

Worker process creates tables if required, loads library data and exits.

## Docker

Dockerized build of rfhub2 is available on Docker Hub:

https://hub.docker.com/r/pbylicki/rfhub2

To pull the image:

```
    # default SQLite-based build
    $ docker pull pbylicki/rfhub2
    # PostgreSQL-based build
    $ docker pull pbylicki/rfhub2:postgres
```

To run web server in Docker container:

```
    $ docker run -it --rm -p 7070:7070 pbylicki/rfhub2
    # To pass command line arguments
    $ docker run -it --rm -p 7070:7070 pbylicki/rfhub2:postgres --web --db postgresql://postgres:@172.17.0.2:5432/hub_test
```

To build Docker image from source:

```
    # For default SQLite backend
    $ docker build -t rfhub2 -f docker/Dockerfile .
    # For PostgreSQL backend
    $ docker build -t rfhub2:postgres -f docker/Dockerfile-postgres .
```

## Websites

 * Source code: https://github.com/pbylicki/rfhub2

Source code, screenshots, and additional documentation of original **rfhub** can be found here:

 * Source code: https://github.com/boakley/robotframework-hub
 * Project wiki: https://github.com/boakley/robotframework-hub/wiki
