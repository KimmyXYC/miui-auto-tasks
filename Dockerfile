FROM python:alpine

RUN apk add --no-cache gcc musl-dev python3-dev libffi-dev

WORKDIR /srv

COPY ./utils ./utils

COPY ./requirements.txt ./pdm.lock ./miuitask.py ./docker_start.sh ./

RUN pip install -r ./requirements.txt && \
    echo "0 4 * * * cd /srv && pdm run /srv/miuitask.py" > /var/spool/cron/crontabs/root && \
    chmod +x docker_start.sh

VOLUME ["/srv/data", "/srv/logs"]

CMD ["/srv/docker_start.sh"]
