# ---------------------------------------------------------
# Build Release
# ---------------------------------------------------------
FROM zfschuindt/elixir_builder:1.9.0 as build

WORKDIR /app

ENV MIX_ENV=prod

COPY . .

RUN mix deps.get && \
    mix deps.compile

RUN mix compile && \
    mix release

RUN tar -czf http_echo.tar.gz /app/_build && \
    mkdir /export && \
    mv http_echo.tar.gz /export/.

# ---------------------------------------------------------
# Run Release
# ---------------------------------------------------------
FROM erlang:22-alpine

ARG PUID=1000
ARG PGID=1000
ARG HOME="/app"

RUN apk add --no-cache --repository \
    http://dl-cdn.alpinelinux.org/alpine/edge/main openssl

RUN apk add -U --no-cache --update bash ncurses-libs

RUN addgroup -g ${PGID} http_echo && \
    adduser -S -h ${HOME} -G http_echo -u ${PUID} http_echo

COPY --from=build --chown=http_echo:http_echo /export/http_echo.tar.gz /app/.

COPY entrypoint.sh /app/.

RUN tar -xzf /app/http_echo.tar.gz && \
    rm /app/http_echo.tar.gz && \
    chown -R http_echo:http_echo /app && \
    chmod +x /app/entrypoint.sh

EXPOSE 4080

USER http_echo

ENV MIX_ENV=prod

CMD ["./app/entrypoint.sh"]
