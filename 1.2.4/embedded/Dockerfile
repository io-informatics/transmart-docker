FROM     tomcat:7-jre8
MAINTAINER Alexander De Leon <me@alexdeleon.name>

# Install dependencies
RUN apt-get update && apt-get -y install build-essential postgresql php5 sudo rsync supervisor

# Set up locale
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Install transmartApp WAR
RUN rm -rf /usr/local/tomcat/webapps/ROOT
ADD https://ci.transmartfoundation.org/browse/DEPLOY-TRAPP-14/artifact/shared/transmart.war/transmart.war /usr/local/tomcat/webapps/ROOT.war

# Install transmart-data
ADD https://github.com/transmart/transmart-data/archive/v1.2.4.tar.gz /opt/transmart-data.tar.gz
RUN cd /opt; tar xzf transmart-data.tar.gz
ADD vars /opt/transmart-data-1.2.4/vars
RUN chown -R postgres:postgres /opt/transmart-data-1.2.4

# Init DB
RUN  mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private && /etc/init.d/postgresql start && su postgres -c "cd /opt/transmart-data-1.2.4 && . ./vars && skip_fix_tablespaces=1 make -j4"
# Create config files for transmartApp
RUN cd /opt/transmart-data-1.2.4 && . ./vars && make -C config install && make -C solr/ solr_home

# Create supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# work around for AUFS bug
# as per https://github.com/docker/docker/issues/783#issuecomment-56013588
RUN mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private

# Ports for postgresql and tomcat are exposed
#postgresql
EXPOSE 5432
#transmart
EXPOSE 8080
#solr
EXPOSE 8983

CMD ["/usr/bin/supervisord"]
