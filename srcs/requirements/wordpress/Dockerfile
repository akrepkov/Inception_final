FROM debian:bullseye

# Install required packages and clean up after
RUN apt-get update && apt-get upgrade -y  &&  apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    curl \
    php \
    php-fpm \
    php-mysql \
	mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
	#rm -rf /var/lib/apt/lists/* to minimize the image size. 

# Create necessary directories
RUN mkdir -p /run/php 

# Copy setup script and make it executable
COPY setup.sh /tmp/
RUN chmod +x /tmp/setup.sh

EXPOSE 9000
# Set up the entry point to the setup script
ENTRYPOINT [ "/tmp/setup.sh" ]



