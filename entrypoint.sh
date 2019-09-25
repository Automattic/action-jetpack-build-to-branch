#!/bin/sh -l

git_setup() {
  cat <<- EOF > $HOME/.netrc
		machine github.com
		login $GITHUB_ACTOR
		password $GITHUB_TOKEN
		machine api.github.com
		login $GITHUB_ACTOR
		password $GITHUB_TOKEN
EOF
  chmod 600 $HOME/.netrc

  git config --global user.email "$GITHUB_ACTOR@users.noreply.github.com"
  git config --global user.name "$GITHUB_ACTOR"
}

git_setup
git remote update
git fetch --all

# Will create branch if it does not exist
if [[ $( git branch -r | grep "$INPUT_BRANCH" ) ]]; then
   git checkout "${INPUT_PUSH_BRANCH}"
else
   git checkout -b "${INPUT_PUSH_BRANCH}"
fi

git reset --hard "origin/${INPUT_PULL_BRANCH}"
yarn build-production
./bin/prepare-release-branch.sh
git commit -am "Update from ${INPUT_PULL_BRANCH}"
git push -f
