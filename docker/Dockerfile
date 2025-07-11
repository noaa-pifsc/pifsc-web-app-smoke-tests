FROM oraclelinux:8

RUN  dnf -y install dos2unix && \
     rm -rf /var/cache/dnf

COPY ./scripts /usr/src/app

RUN dos2unix /usr/src/app/* &&\
dos2unix /usr/src/app/functions/*


# leave the container running so the deployment scripts can be executed from the docker host machine

ENTRYPOINT ["tail", "-f", "/dev/null"]