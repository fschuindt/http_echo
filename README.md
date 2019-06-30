# Simple HTTP Echo Back-end Service

A Elixir HTTP "ping/pong" echo server, used for building and testing infrastructure.

## Usage

Perform a `GET` request to `/ping` at the `4080` TCP port and it will reply with `200 OK`, like so:
```
$ curl http://localhost:4080/ping
pong%
```

## Running it locally

**Requirements**
- Docker
- Docker Compose
- Erlang 22
- Elixir 1.9.0

Install Hex and Rebar:
```
$ mix local.hex --force
```

```
$ mix local.rebar --force
```

Download dependencies:
```
$ mix deps.get
```

Compile everything:
```
$ mix compile
```

Copy our `.local.env.sample` file:
```
$ cp .local.env.sample .local.env
```

Load our development environment variables file:
```
$ eval $(cat .local.env)
```

## Running it via Docker

Copy the `docker.env.sample` file:
```
$ cp docker.env.sample docker.env
```

Build our Docker image:
```
$ docker-compose build app
```

Run the application in foreground mode:
```
$ docker-compose up app
```

Or run the application in background mode:
```
$ docker-compose up -d app
```
