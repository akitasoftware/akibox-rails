# Akibox Tutorial – Rails

This is a tutorial project to help you get to know Akita. It contains a Rails
implementation of a REST API for a toy Dropbox-like service. You can use Akita
to generate a model for this API, make some changes, and see the resulting
effects on the API in Akita's semantic diffs.

## Prerequisites

Make sure you have Ruby and Rails. This was tested with Ruby 2.7.2 and Rails
6.1.3.1. You can update Rails with the following.

```sh
$ gem update rails
```

## Installation

The following command will install the gems for this project.
```sh
$ bundle install
```

## Run integration tests

This project comes with a few integration tests for the REST API. You can run
them with the following command. The requests and responses made during the
test are logged to a HAR file.
```sh
$ bundle exec rspec
```

## Fire up the service!

To start a web server that exposes the REST API:
```sh
$ rails s
```

You can then make requests to the server at localhost:3000. While the server is
running, its requests and responses are logged to a HAR file. Press CTRL+C to
stop the server and flush the HAR file.

## Examining HAR files and building models

Whether you run the integration tests or run the server, the requests and
responses made will be logged to a file named `akita_trace_{timestamp}.har`.
You can upload this HAR file to Akita for analysis. For details, see
[here](https://docs.akita.software/docs/from-traffic-to-specs).

## Adding new tests

Tests for the REST API live in [spec/requests](spec/requests/). Try adding some
new tests and look for the corresponding traffic in the HAR files.
