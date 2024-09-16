FROM python:3.11-slim

WORKDIR /app

EXPOSE 8080

ARG VERSION

RUN pip install webscrapbook==${VERSION} gunicorn==23.0.0 --no-cache-dir

RUN wsb config --book --all

ENTRYPOINT ["gunicorn", "--chdir", "/app/.wsb", "app:application"]
