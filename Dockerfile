FROM python:3.11-slim

WORKDIR /app

EXPOSE 8080

VOLUME [ "/app" ]

ARG VERSION

RUN pip install webscrapbook==${VERSION} gunicorn==23.0.0 --no-cache-dir

RUN wsb config --book --all

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--chdir", ".wsb", "app:application"]
