# Using lightweight alpine image
FROM python:2.7-alpine

# Installing packages
RUN apk update
RUN pip install marshmallow
RUN pip install flask
RUN pip install enum34

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN echo http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
RUN apk add --no-cache dos2unix

# Defining working directory and adding source code
WORKDIR /usr/src/app
COPY . .

# modify bootstrap.sh to be properly executable
RUN chmod +x /usr/src/app/bootstrap.sh
RUN dos2unix /usr/src/app/bootstrap.sh

# Start app
EXPOSE 5000
CMD ["/bin/sh", "/usr/src/app/bootstrap.sh"]