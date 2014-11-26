# http://docs.docker.com/reference/commandline/cli/#filtering_1
EXITED_CONTAINERS=`docker ps -a --filter 'status=exited'`

if [ -n "$EXITED_CONTAINERS" ]; then
    docker rm $EXITED_CONTAINERS
fi