__current_git_branch() {
# WARNING: Does NOT work in a detached HEAD state, it will just return "HEAD"
# http://stackoverflow.com/questions/6245570/how-to-get-current-branch-name-in-git#comment20384518_12142066
git rev-parse --abbrev-ref HEAD
}

BRANCH=$(__current_git_branch)

echo "Starting interactive shell on $BRANCH VM..."
docker run -t -i "$BRANCH" /bin/bash