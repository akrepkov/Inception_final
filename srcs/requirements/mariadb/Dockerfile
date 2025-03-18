FROM debian:bullseye 
RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-client mariadb-server

COPY ./setup_mariadb.sh /

COPY ./50-server.cnf /

RUN chmod +x /setup_mariadb.sh

EXPOSE 3306

CMD ["/setup_mariadb.sh"]
