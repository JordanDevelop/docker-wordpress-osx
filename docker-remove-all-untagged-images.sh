# http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html
IMAGES=`docker images | grep "^<none>" | awk "{print $3}"`

if [ -n "$IMAGES" ]; then
    docker rmi $IMAGES
fi