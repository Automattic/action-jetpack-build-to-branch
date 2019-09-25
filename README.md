# Commit and push to remote branch

Specifically designed for Jetpack. 

This Action will build a production version of a branch, and commit the result to another branch. 

## Inputs

### `pull_branch`

**Required** The branch name of the branch that you would like to build from.

**Default**: `master`

### `push_branch`

**Required** The branch name of the branch that you would like to commit and deploy to.

### `commit_message`

Custom commit message. **default** "Automated commit from action""

## Example usage
```
- name: Build production version of Master
  uses: Automattic/action-jetpack-build-to-branch@master
  with:
    pull_branch: 'master'
    push_branch: 'master-built'
    commit_message: 'Build master'
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} # Required
```
