What is tranSMART Platform?
===========================

The transSMART platform is an open-source, community-driven knowledge management platform for translational medicine. ([read more](https://docs.google.com/file/d/0B8lizkKDeaKhMEJOdE5tVHR0YkE/edit?pli=1))

![tranSMART Platform](http://transmartfoundation.org/wp-content/uploads/2014/08/tranSMART-Platform-logo.jpg)


How to use this image
=====================

This image provides different types of deployments:

* *Embedded PostgreSQL Database*: This is intended only for testing or proof of concept the platform. The image contains everything you need to use the tranSMART platform from  a single Docker container.

Embedded PostgreSQL Database
-----------------------------

The tags for this deployments are: 1.2.4-embedded

To run the container just execute the following Docker command:

```
docker run -d -p 8080:8080 ioinformatics/transmart:1.2.4-embedded
```

Then open the following URL in your browser: http://localhost:8080. NOTE if you are using boot2docker on Windows or MacOSX you need to use the IP of your boot2docker vm instead of localhost. For instance: http://192.168.59.103:8080 (You can find this ip using the command `boot2docker ip` .. [more info here](https://github.com/boot2docker/boot2docker#container-port-redirection)

Notice
=====
tranSMART is a community project of the [Transmart Foundation](http://transmartfoundation.org) and it is used in this image under the terms of the [GPLv3](http://opensource.org/licenses/GPL-3.0) License. 
