FROM debian

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

RUN apt-get update && apt-get install -y mongodb-org-tools cron python python-pip
RUN pip install awscli
RUN apt-get install -y wget

RUN mkdir ~/.aws
ADD config ~/.aws

RUN mkdir /scripts
ADD import.sh /scripts
RUN chmod +x /scripts/import.sh

ENTRYPOINT ["/bin/bash", "/scripts/import.sh"]
