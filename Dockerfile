FROM     tomcat:7-jre8
MAINTAINER Alexander De Leon <me@alexdeleon.name>

# Install dependencies
RUN apt-get update && apt-get -y install build-essential postgresql php5 sudo

# Set up loacale
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Install transmartApp WAR
ADD https://ci.transmartfoundation.org/browse/DEPLOY-TRAPP-14/artifact/shared/transmart.war/transmart.war /usr/local/tomcat/webapps/transmart.war

# Install transmart-data
ADD https://github.com/transmart/transmart-data/archive/v1.2.4.tar.gz /opt/transmart-data.tar.gz
RUN cd /opt; tar xzf transmart-data.tar.gz
ADD vars /opt/transmart-data-1.2.4/vars
RUN chown -R postgres:postgres /opt/transmart-data-1.2.4

# Init DB
RUN /etc/init.d/postgresql start && su postgres -c "cd /opt/transmart-data-1.2.4 && . ./vars && skip_fix_tablespaces=1 make -j4"
# Create config files for transmartApp
RUN cd /opt/transmart-data-1.2.4 && . ./vars && make -C config install

ADD run.sh /run.sh
RUN chmod +x /run.sh

# Ports for postgresql and tomcat are exposed
EXPOSE 5432
EXPOSE 8080

CMD ["/run.sh"]
