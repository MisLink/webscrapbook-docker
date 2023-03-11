FROM python:3.11-slim

WORKDIR /app

EXPOSE 8080

VOLUME [ "/app/main" ]

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-`uname -s`-`uname -m` -o /usr/local/bin/envsubst \
    && chmod +x /usr/local/bin/envsubst

ARG VERSION

RUN pip install webscrapbook==${VERSION} --no-cache-dir

COPY config.ini .wsb/config.ini

CMD SECRET_AUTH_PW=`wsb encrypt -p ${AUTH_PW} -m sha512` envsubst -no-unset -no-empty -i .wsb/config.ini -o .wsb/config.ini && wsb serve
