What is tranSMART Platform?
===========================

The transSMART platform is an open-source, community-driven knowledge management platform for translational medicine. ([read more](https://docs.google.com/file/d/0B8lizkKDeaKhMEJOdE5tVHR0YkE/edit?pli=1))

![tranSMART Platform](http://transmartfoundation.org/wp-content/uploads/2014/08/tranSMART-Platform-logo.jpg)


How to use this image
=====================

This image provides different types of deployments:

* *Embedded PostgreSQL Database*: This is intended only for testing or proof of concept the platform. The image contains everything you need to use the tranSMART platform from  a single Docker container.
* *Distributed*: This image is just the tranSMART application which connects to PostgreSQL and Solr via TPC so that the entire arcitecture can be distributed on multiple machines. See documentation below on how to use this image.

Embedded PostgreSQL Database
-----------------------------

The tags for this deployment are: 1.2.4-embedded

To run the container just execute the following Docker command:

```
docker run -d -p 8080:8080 --name transmart ioinformatics/transmart:1.2.4-embedded
```

### Load sample data

When you have created the tranSMART container you can load publicly available data into the database. For this, you need to know the name of your container, if you used the command above you see that we have named our container `transmart` using the `--name` option, but if you have not used this option you can find the name of your container using the `docker ps` command. When you have the name you can execute the `load` program on it to load data. You can do this using the following command:

```
docker exec transmart load clinical_GSE8581
```

In the above `trasmart` is the name of the container and `clinical_GSE8581` is the dataset that will be loaded. The name of the dataset follow this template `<data type>_<study name>`. You can find more about the publicly available datasets in the [transmart-data project](https://github.com/thehyve/transmart-data#running-etl-targets)  


Distributed
-----------

The tags for this deployment are: 1.2.4-distributed

If you don't have already a Postgres Database which you want to connect to you can first run this image for the DB. Otherwise skip this step.

```
docker run -d -p 5432:5432 --name postgres ioinformatics/transmart-postgres
```

Next run the transmart application.

If you connecting to a postgres database on the same machine and started as docker container with the command above use the following command to link the containers

```
docker run -d -p 8080:8080 --link postgres:postgres ioinformatics/transmart:1.2.4-distributed
```

Otherwise, if you connecting to an existing database on another machine, use the following environment variables

POSTGRESQL_HOST
POSTGRESQL_PORT
POSTGRESQL_DB
POSTGRESQL_USER
POSTGRESQL_PASSWORD

For example if your database is on the host my-postgres at the default port. Use the following command:x:

```
docker run -d -p 8080:8080 -e "POSTGRESQL_HOST=my-postgres" ioinformatics/transmart:1.2.4-distributed
```

Then open the following URL in your browser: http://localhost:8080. NOTE if you are using boot2docker on Windows or MacOSX you need to use the IP of your boot2docker vm instead of localhost. For instance: http://192.168.59.103:8080 (You can find this ip using the command `boot2docker ip` .. [more info here](https://github.com/boot2docker/boot2docker#container-port-redirection)


Notice
=====
tranSMART is a community project of the [Transmart Foundation](http://transmartfoundation.org) and it is used in this image under the terms of the [GPLv3](http://opensource.org/licenses/GPL-3.0) License.
