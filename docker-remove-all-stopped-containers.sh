# http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html
STOPPED_CONTAINERS=`docker images | grep "^<none>" | awk "{print $3}"`

if [ -n "$STOPPED_CONTAINERS" ]; then
    docker rmi $STOPPED_CONTAINERS
fi