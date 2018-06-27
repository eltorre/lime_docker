FROM openjdk:8-jre-slim-stretch

# Dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
		curl \
		ruby \
		libfreetype6 \
		fontconfig \
		python2.7 \
		abiword \ 
		gnupg gnupg2 gnupg1 \
		git \
		build-essential \
		apache2 \
		php php-curl php-json php-xml \
 	&& rm -rf /var/lib/apt/lists/*

# More dependencies. The version of nodejs and npm in debian is old, so we add the ppa to get a more recent one
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
	apt-get update && \
	apt-get install -y nodejs

# Installing SenchaCmd
RUN curl --silent https://cdn.sencha.com/cmd/5.1.3.61/SenchaCmd-5.1.3.61-linux-x64.run.zip -o /tmp/sencha.zip && \
	unzip /tmp/sencha.zip -d /tmp  && \
	unlink /tmp/sencha.zip  && \
	chmod o+x /tmp/SenchaCmd-5.1.3.61-linux-x64.run  && \
	mkdir /sencha && \
	echo -ne '\n\n\n\n\n\ny\n\n' | /tmp/SenchaCmd-5.1.3.61-linux-x64.run  --prefix /sencha && \
	unlink /tmp/SenchaCmd-5.1.3.61-linux-x64.run

# Download lime server and its dependencies (via npm)
RUN mkdir /limeserver && cd /limeserver && \
	git clone --recursive https://github.com/cirsfid-unibo/lime-server.git && \
	cd lime-server && \
	npm install 

# Download lime, lime's sencha workspace, download dependencies via npm and build the app
RUN mkdir /limebuild && cd /limebuild && \
	curl -s http://sinatra.cirsfid.unibo.it/demo-akn/lime_ext_workspace.zip -o lime_ext_workspace.zip && \
	unzip lime_ext_workspace.zip && \
	rm lime_ext_workspace.zip && \
	git clone --recursive https://github.com/cirsfid-unibo/lime.git && \
	mv lime/* .

RUN	cd /limebuild && \
	cd scripts && \
	 npm install && \
	cd .. && \
	/sencha/Sencha/Cmd/5.1.3.61/sencha app build && \
	echo "" > /limebuild/config.json


# Replace /var/www/html with lime
RUN rm -rf /var/www/html && \
	ln -s /limebuild /var/www/html

# Copy the docker-entrypoint.sh file that launches apache2 (for lime) and lime server
COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

# Copy the configuration file for lime server and lime
COPY config.limeserver.json 	/limeserver/lime-server/documentsdb/config.json

WORKDIR /

#Entrypoint with no parameters
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["", ""]

#Expose both the 80 (that will be accesible as 8008) and the 9006 ports. 80 is used by apache to serve lime, 9006 is used to serve lime server. 
EXPOSE 80
EXPOSE 9006


