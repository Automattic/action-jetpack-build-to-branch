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

echo "Push branch: " $INPUT_BRANCH_PUSH
echo "Pull branch: " $INPUT_BRANCH_PULL

# Will create branch if it does not exist
if [[ $( git branch -r | grep "$INPUT_BRANCH_PUSH" ) ]]; then
   git checkout "${INPUT_BRANCH_PUSH}"
else
   git checkout -b "${INPUT_BRANCH_PUSH}"
   git push --set-upstream origin "${INPUT_BRANCH_PUSH}"
fi

git reset --hard origin/"${INPUT_BRANCH_PULL}"
yarn build-production
bin/prepare-built-branch.sh
git add .
git commit -m "Update from ${INPUT_BRANCH_PULL}"
git push -f
