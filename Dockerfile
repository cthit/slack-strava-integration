FROM node

RUN apt-get update && apt-get upgrade -y && apt-get install cron -y

WORKDIR /app
COPY package-lock.json package.json ./
RUN npm install

COPY . .
RUN chmod 0644 crontab
RUN crontab crontab
RUN touch /var/log/cron.log

RUN echo "{}" > src/database.json
RUN echo "{}" > src/old.database.json

ENV client_id=
ENV client_secret=
ENV refresh_token=

ENV club_id=
ENV hook_token=
ENV title="Sammanfattning sedan dag 1 LV1"

CMD /usr/bin/printenv > /app/.env && cron -f
