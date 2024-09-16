FROM python:3.11-slim

WORKDIR /app

EXPOSE 8080

VOLUME [ "/app" ]

ARG VERSION

RUN pip install webscrapbook==${VERSION} --no-cache-dir

RUN wsb config --book

CMD ["wsb", "serve"]
