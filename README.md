dockerfiles-centos-wordpress
========================

Tested on Docker 1.3.2

This repo contains a recipe for making a [Docker](http://docker.io) container for [WordPress](https://github.com/WordPress/WordPress), using Linux, Apache and MySQL on CentOS6.

To build, make sure you have Docker [installed](http://www.docker.io/gettingstarted/), clone this repo somewhere, and then run:

```
# docker build --rm -t <yourname>/wordpress:centos6 .
```

Run it:

```
# CID=$(docker run -d -p 80 -p 22 <yourname>/wordpress:centos6)
```

Check docker logs after running to see MySQL root password and Wordpress MySQL password, as so:

```
# echo "$(docker logs $CID | grep password)"
```

(note: you won't need the mysql root or the wordpress db password normally)

Then find the external port assigned to your container:

```
# docker port $CID 80 
```

Visit in a webrowser, then fill out the form. No need to mess with wp-config.php, it's been auto-generated with proper values. 


Note that this image now has a user account (appropriately named "user") and passwordless sudo for that user account. The password is generated upon startup; check logs for "ssh user password", docker ps for the port assigned to 22, and something like this to get in: 

```
# ssh -p <port> user@localhost
```


## Acknowledgements

Forked via:

- https://github.com/jbfink/docker-wordpress
- https://github.com/CentOS/CentOS-Dockerfiles/tree/master/wordpress/centos6