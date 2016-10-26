FROM postgres
MAINTAINER Muneeb Ahmad <beenum>
WORKDIR /root
RUN apt-get update -y && \
	apt-get install -y git && \
	apt-get install --no-install-recommends -y liblog4cplus-dev libboost-dev libbotan1.10-dev postgresql-client dh-autoreconf libssl-dev openssl postgresql-server-dev-all libboost-system-dev && \
	git clone https://github.com/isc-projects/kea && \
	cd kea && \
	autoreconf --install && \
	./configure --with-log4cplus=/usr/include/ --with-dhcp-pgsql=/usr/bin/pg_config --with-boost-include=/usr/include/ --prefix=/opt/kea && \
	make && make install && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	cd && rm -rf kea/