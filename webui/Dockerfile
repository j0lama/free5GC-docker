# Comment: Image base with free5GC installed

# Download free5g-base from the Docker Hub
FROM j0lama/free5gc-base

# Install npm
RUN apt-get -y install curl gnupg

# Install webui
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get -y install nodejs

RUN cd webui/ && npm install && npm run build

ENV MONGODB_STARTUP_TIME 5