FROM debian:bullseye
#latest version

RUN	apt-get update && apt-get upgrade -y && \
	apt-get --purge remove apache2 && \
	apt-get install -y --no-install-recommends nginx ca-certificates openssl && \
	mkdir -p /etc/nginx/ssl &&  \ 
	#-p flag for creating parent directories if they dont exist
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/akrepkov.42.fr.key \
	-out /etc/nginx/ssl/akrepkov.42.fr.crt \
	-subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=akrepkov.42.fr" && \
	mkdir -p /usr/local/share/ca-certificates/ && \
	cp /etc/nginx/ssl/akrepkov.42.fr.crt /usr/local/share/ca-certificates/akrepkov.42.fr.crt && \
	update-ca-certificates

# Update package lists, upgrade installed packages, and install Nginx and OpenSSL
# Generate a self-signed SSL certificate and copy it to the certificate directory
# Update the CA certificates with the new certificate

COPY /tools/nginx.conf /etc/nginx/conf.d/example.conf
#copying from computer to container
EXPOSE 443

#CMD и ENTRYPOINT запускают что-либо, но НЕ ЗАПИСЫВАЮТ изменений в образ. Потому не стоит выполнять ими скрипты, 
#результат которых нужно "положить" в конечный образ или раздел. Для этого есть RUN.
CMD ["nginx", "-g", "daemon off;"]
# Start Nginx in the foreground to keep the container running

