__current_git_branch() {
# WARNING: Does NOT work in a detached HEAD state, it will just return "HEAD"
# http://stackoverflow.com/questions/6245570/how-to-get-current-branch-name-in-git#comment20384518_12142066
git rev-parse --abbrev-ref HEAD
}

REPO=`git remote -v | grep '(fetch)' | sed 's=.*/==;s/\.[^.]*$//'`
BRANCH=$(__current_git_branch)
TAG="$REPO:$BRANCH"
CWD=`pwd`
HTDOCS_HOST="$CWD/wordpress"
HTDOCS_VM="/var/www/html"
NAME=`git config user.name`

# Create the VM

echo "Hi $NAME!"

echo "Creating your virtual machine '$TAG'..."

$(boot2docker shellinit)

docker build --rm -t "$TAG" .

echo "Virtual machine '$TAG' has been created."
# docker images

echo "Starting virtual machine for the '$BRANCH' branch..."
echo "Hosting '$HTDOCS_HOST' at port 80"

# Start the VM using `docker run`
#
# --name specified a shortcut you can use in later commands.
# E.g: docker start "$TAG"
# E.g: docker stop  "$TAG"
# 
# -d runs the VM in a 'detached mode', like a deamon
# 
# -v mounts a directory of the host inside the VM
# 
# -P instructs to map all exposed ports to a port on the host
# 
# The . at the end instructs to look for a Dockerfile in the current dir
# 
# https://docs.docker.com/reference/commandline/cli/#run
docker run -d -P --name "$BRANCH" -v "$HTDOCS_HOST:$HTDOCS_VM" "$TAG" /etc/apache2/foreground.sh


IP=$(boot2docker ip)
PORT=`docker inspect -f '{{(index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' "$BRANCH"`

echo ""
echo ""
echo ""
echo "Success!"
echo "Open your website for $HTDOCS_HOST"
echo "                  at: http://$IP:$PORT/"
echo ""
