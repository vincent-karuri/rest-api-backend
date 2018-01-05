# Using lightweight alpine image
FROM python:2.7-alpine

# Installing packages
RUN apk update
RUN pip install --no-cache-dir pipenv

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN echo http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
RUN apk add --no-cache dos2unix

# Defining working directory and adding source code
WORKDIR /usr/src/app
COPY . .

# modify bootstrap.sh to be properly executable
RUN chmod +x /usr/src/app/bootstrap.sh
RUN dos2unix /usr/src/app/bootstrap.sh

# Install API dependencies
RUN pipenv install

# Start app
EXPOSE 5000
ENTRYPOINT ["/usr/src/app/bootstrap.sh"]