FROM mariadb:10.4
ENV LANG C.UTF-8

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y tzdata busybox-static rsync && \
    rm -rf /var/lib/apt/lists/*
ENV TZ=Asia/Tokyo

COPY src /usr/local/bin
RUN chmod -R 744 /usr/local/bin

COPY crontabs/jobs /var/spool/cron/crontabs/root


CMD ["busybox", "crond", "-f"]
