__current_git_branch() {
# WARNING: Does NOT work in a detached HEAD state, it will just return "HEAD"
# http://stackoverflow.com/questions/6245570/how-to-get-current-branch-name-in-git#comment20384518_12142066
git rev-parse --abbrev-ref HEAD
}

REPO=`git remote -v | grep '(fetch)' | sed 's=.*/==;s/\.[^.]*$//'`
BRANCH=$(__current_git_branch)
TAG="$REPO:$BRANCH"
CONTAINER="${REPO}_$BRANCH"

echo "Starting interactive shell on $CONTAINER..."
docker exec -it "$CONTAINER" /bin/bash