FROM m0elnx/ubuntu-32bit:latest

MAINTAINER P3trur0 <upe@flatmap.it>

VOLUME ["/var/lib/cassandra"]

ENV CASSANDRA_VERSION 3.9

RUN apt-get install wget && \
	echo "deb http://www.apache.org/dist/cassandra/debian 39x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list  && \
	apt-key adv --keyserver pool.sks-keyservers.net --recv-key A278B781FE4B2BDA && \
	wget https://www.apache.org/dist/cassandra/KEYS  && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y  software-properties-common && \
	add-apt-repository ppa:webupd8team/java -y && \
	apt-get update && \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
	apt-get install -y oracle-java8-installer && \
	apt-get install -y oracle-java8-set-default && \
	apt-get install -ymq cassandra=$CASSANDRA_VERSION python-pip  && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	pip install cqlsh

COPY cassandra.sh /usr/local/bin/

EXPOSE 7199 7000 7001 9160 9042

CMD ["/usr/local/bin/cassandra.sh"]

RUN echo "Everything ok!"
