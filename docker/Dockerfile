FROM python:3.6-alpine

COPY requirements*.txt /tmp/

RUN pip install --no-cache-dir -r /tmp/requirements.txt && \
    rm /tmp/requirements*.txt

COPY rfhub2 /app/rfhub2

WORKDIR /app

USER 1001

ENTRYPOINT ["python", "-m", "rfhub2"]