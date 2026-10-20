# Git & GitHub Workflow Guide

Note: this document was made with assistance from an LLM, with the structure and content explicitly defined. It is undergoing human testing and review.

A beginner-friendly workflow using branches and pull requests (PRs). Each step names the action first, with the matching CLI command in code format. IDEs offer the same actions through menus or buttons.

**Core workflow:** `main` holds stable, release-ready work, and `dev` is where finished features come together. Do your work on a feature branch created from `dev`, merge it into `dev` through a PR, then merge `dev` into `main` through another PR when you're ready to release.

## Key terms

- **Repository (repo):** a project folder tracked by Git.
- **Commit:** a saved snapshot of your changes.
- **Branch:** a separate line of work that doesn't affect other branches until merged.
- **`main`:** the stable branch holding released work.
- **`dev`:** the integration branch where completed feature branches are merged.
- **Feature branch:** a short-lived branch created from `dev` for one task.
- **Remote:** the copy of the repo on GitHub, usually named `origin`.
- **Pull request (PR):** a request to merge one branch into another, with review.

## Quick command lookup

Use this section when you know what you want to do but have forgotten the command.

### Set up a repository

| I want to | Command |
| --- | --- |
| Initialize a repo in the current folder | `git init` |
| Copy a repo from GitHub | `git clone <url>` |
| Link my local repo to GitHub | `git remote add origin <url>` |
| Rename the current branch to `main` | `git branch -M main` |

### Check where you are

| I want to | Command |
| --- | --- |
| Check branch and changes | `git status` |
| List local branches | `git branch` |
| See which remote branch mine tracks | `git branch -vv` |
| See recent commits | `git log --oneline` |
| See unstaged changes | `git diff` |
| See staged changes | `git diff --staged` |
| See which GitHub repo I'm connected to | `git remote -v` |

### Work with branches

| I want to | Command |
| --- | --- |
| Create and switch to `dev` | `git switch -c dev` |
| Switch to an existing branch (e.g. `dev`) | `git switch dev` |
| Create a feature branch from the current branch | `git switch -c <branch-name>` |
| Switch to my feature branch | `git switch <branch-name>` |
| Merge `dev` into my current branch | `git merge dev` |
| Merge `main` into my current branch | `git merge main` |
| Delete a local branch after merging | `git branch -d <branch-name>` |

### Save changes

| I want to | Command |
| --- | --- |
| Stage all changes | `git add .` |
| Stage a specific file | `git add <file>` |
| Commit staged changes | `git commit -m "Describe the change"` |
| Commit with a message body explaining why | `git commit -m "Summary" -m "Why it changed"` |
| Amend the last commit (edit the message) | `git commit --amend` |
| Amend the last commit, keeping its message | `git commit --amend --no-edit` |

### Undo changes

| I want to | Command |
| --- | --- |
| Undo the last commit, keep changes staged | `git reset --soft HEAD~1` |
| Undo the last commit, keep changes unstaged | `git reset HEAD~1` |
| Undo the last commit and discard the changes | `git reset --hard HEAD~1` |
| Undo a pushed commit with a new commit | `git revert <commit-hash>` |

### Sync with GitHub

| I want to | Command |
| --- | --- |
| Get the latest commits from the remote | `git pull` |
| Push my commits | `git push` |
| Push `main` and set it to track the remote | `git push -u origin main` |
| Push `dev` and set it to track the remote | `git push -u origin dev` |
| Publish a new branch to GitHub | `git push -u origin <branch-name>` |

## Part 1: Setting up a repository

Do this once per project. Either start a new repo on your computer, or copy an existing one from GitHub.

### Option A: Initialize a repo locally and push it to GitHub

1. In your project folder, initialize Git: `git init`
2. Stage and commit your files: `git add .` then `git commit -m "Initial commit"`
3. On GitHub, create a new **empty** repository (no README, .gitignore or license). Copy its URL.
4. Link your local repo to GitHub: `git remote add origin <url>`
5. Name the branch `main` and push it: `git branch -M main` then `git push -u origin main`
6. Create the `dev` branch from `main` and push it: `git switch -c dev` then `git push -u origin dev`

### Option B: Clone a repository from GitHub

1. On the GitHub repo page, click **Code** and copy the URL.
2. Clone it: `git clone <url>`
3. Open the new folder in your editor.
4. Switch to the `dev` branch: `git switch dev`. If the repo has no `dev` branch yet, create and push it as in Option A, step 6.

### After either option: set `dev` as the default branch on GitHub

Do this once per repo, after `dev` exists on GitHub. New PRs will then target `dev` automatically. You need admin access to the repo.

1. On the GitHub repo page, go to **Settings**, then **Branches**.
2. Under **Default branch**, click the switch icon (⇄) next to the current default.
3. Select `dev` and click **Update**, then confirm.

## Part 2: Basic operations for day-to-day work

Work on a feature branch created from `dev`. Don't commit directly to `dev` or `main`. A typical day has three phases: get set up, work locally, then push.

### Start of the day: get set up

#### Check where you are

Run these any time you're unsure what state your repo is in.

| I want to | Command |
| --- | --- |
| Know which branch I'm on, and what's changed or staged | `git status` |
| View all local branches (current one marked `*`) | `git branch` |
| Know which remote branch mine tracks | `git branch -vv` |
| View recent commits | `git log --oneline` |
| View unstaged changes | `git diff` |
| View staged changes (what the next commit will include) | `git diff --staged` |
| Know which GitHub repo I'm connected to | `git remote -v` |

#### Get the latest changes

Commit your work first, or set it aside with `git stash` (see "Stash unfinished work" in Part 4), before switching branches.

First update local `dev` by running `git switch dev` then `git pull`

**Starting a new task?** Create a feature branch from the updated `dev`:

1. Create and switch to it: `git switch -c <branch-name>`
2. Use `type/short-description`, all lowercase, with hyphens instead of spaces:
   - `feature` for new functionality, e.g. `feature/add-login-page`
   - `fix` for bug fixes, e.g. `fix/readme-typo`
   - `docs` for documentation, e.g. `docs/update-install-steps`
   - `chore` for maintenance, e.g. `chore/update-dependencies`

**Continuing an existing branch?** Bring in the latest changes:

1. Switch to your branch: `git switch <branch-name>`
2. Get any commits teammates pushed to this branch: `git pull`
3. Merge `dev` into your branch: `git merge dev`
4. If Git reports conflicts, open the marked files, keep the correct code, then `git add <file>` and `git commit` to finish the merge.

### During the day: work locally

#### Commit your work

Commit each time you finish a small, logical piece of work.

1. Stage your changes: `git add .` (or `git add <file>` for specific files)
2. Commit: `git commit -m "Describe the change"`

Writing good commit messages:

- Start with a short summary (about 50 characters) in the imperative, as if completing "This commit will…": e.g. `Add login page`, `Fix crash on empty file`.
- No period at the end of the summary.
- Make each commit one logical change.
- If the reason isn't obvious, add a blank line and a few sentences explaining *why*. In the CLI, a second `-m` adds this body: `git commit -m "Summary" -m "Why it changed"`

#### Amend a commit (local only)

Use this to fix a typo in the last commit message or add a forgotten file, **before you push**.

1. Stage any extra changes: `git add <file>`
2. Amend the last commit: `git commit --amend` (edit the message), or `git commit --amend --no-edit` to keep it.

> Don't amend a commit that's already pushed. It rewrites history and conflicts with the remote copy. Make a new commit instead, or revert it (see "Undo a commit that's already pushed" in Part 2).

#### Undo a commit locally (not yet pushed)

Find the commit with `git log --oneline`. To undo the **last** commit, use `reset`, choosing one of two options:

- **Undo the commit, keep your changes:** `git reset --soft HEAD~1` (changes stay staged) or `git reset HEAD~1` (changes stay unstaged). Use this to edit and recommit.
- **Undo the commit and discard the changes:** `git reset --hard HEAD~1`

> `HEAD` is your current commit, the latest one on your branch. `~1` means "one commit back". So `HEAD~1` is the commit before your latest one, and resetting to it undoes the latest commit. Use `HEAD~2` to undo the last two commits.

> `--hard` permanently deletes the changes. Only use `reset` on commits that haven't been pushed.

### End of the day: push your work to the remote

#### Push your work

1. Check for anything uncommitted: `git status`
2. Push your commits: `git push`. On a new branch, the first push needs `git push -u origin <branch-name>` instead, which publishes the branch to GitHub.

After the first push, later pushes on this branch only need `git push`. When the work is ready for review, continue to "Sharing work through pull requests" in Part 3.

#### Undo a commit that's already pushed

Use `revert`. It adds a **new commit** that reverses the old one, so shared history stays intact.

1. Find the commit hash: `git log --oneline`
2. Revert it: `git revert <commit-hash>`
3. Save the commit message when prompted, then push: `git push`

> You could `reset` locally and run `git push --force` to erase the commit from the remote, but this rewrites shared history and can break teammates' copies. Don't do it on `main`, `dev` or any shared branch.

## Part 3: Sharing work through pull requests

Changes reach `main` in two steps: a PR from your feature branch into `dev`, then a PR from `dev` into `main` when you're ready to release.

### Feature branch into `dev`

#### Create a pull request

1. Make sure your branch is pushed (see "Push your work" in Part 2). On GitHub, click **Compare & pull request**.
2. Set the base to `dev` and the compare branch to your feature branch.
3. Add a clear title and short description of what changed and why.
4. Request reviewers, then click **Create pull request**.

#### Review a pull request

1. Open the PR and go to the **Files changed** tab.
2. Hover a line and click **+** to leave a comment.
3. Click **Review changes** and choose **Comment**, **Approve** or **Request changes**.
4. If changes are requested, the author commits and pushes more commits to the same branch. The PR updates automatically.

#### Merge a pull request

1. When the PR is approved and any checks pass, click **Merge pull request**, then **Confirm merge**.
2. Click **Delete branch** (it's no longer needed).
3. Update your local copy: `git switch dev`, `git pull`, then delete the local branch: `git branch -d <branch-name>`

### `dev` into `main`

#### Create a release pull request

1. Confirm `dev` has everything you want to release and any checks pass.
2. On GitHub, go to the **Pull requests** tab and click **New pull request**.
3. Set the base to `main` and the compare branch to `dev`.
4. Add a title (e.g. the release name or date) and a description summarizing what's included, such as the merged feature PRs.
5. Request reviewers, then click **Create pull request**.

#### Review a release pull request

Review it the same way as a feature PR (see "Review a pull request" in Part 3), checking that the changes are ready to release.

#### Merge a release pull request

1. When the PR is approved and any checks pass, click **Merge pull request**, then **Confirm merge**.
2. **Don't delete `dev`.** It's a permanent branch.
3. Update your local copy: `git switch main`, then `git pull`.
4. Bring the merge commit back into `dev` so the two branches match: `git switch dev`, `git merge main`, then `git push`.

## Part 4: Advanced operations

You won't need these every day, but they're useful to know.

### Undo and set aside work

#### Revert a merged pull request on GitHub

Use this to undo a whole merged PR without touching the command line.

1. Open the merged PR on GitHub.
2. Click **Revert** near the bottom of the page. GitHub creates a new branch and opens a new PR that undoes the changes.
3. Review and merge the new PR as you would any other (see "Merge a pull request" in Part 3).

The revert PR targets the same branch the original was merged into. If the original change was already released to `main`, revert it in `dev`, then release again with a `dev` into `main` PR.

#### Revert a merged pull request from the command line

Revert the merge commit and push: `git revert -m 1 <merge-commit-hash>` then `git push`. The `-m 1` flag is explained below.

> A merge commit has two parents: parent 1 is the branch the PR was merged into (e.g. `dev`), and parent 2 is the PR's feature branch. Git can't tell which side to keep, so you tell it. `-m 1` ("mainline 1") keeps parent 1, so the revert removes the changes the PR brought in.

#### Stash unfinished work

Use this to set aside uncommitted changes, for example to switch branches before you're ready to commit.

1. Stash your changes: `git stash` (add `-u` to include new, untracked files)
2. Switch branches and do what you need to do.
3. Switch back to your branch and restore the changes: `git stash pop`

Other useful commands: `git stash list` shows saved stashes, `git stash apply` restores a stash and keeps it saved, and `git stash drop` deletes one.

### Track work with GitHub issues

#### Create an issue

Use issues to track bugs, tasks and ideas.

1. On the GitHub repo page, go to the **Issues** tab and click **New issue**.
2. Add a short, clear title.
3. Describe the problem or task in the description box. For a bug, include the steps to reproduce it and what you expected to happen.
4. Optionally, add labels, assignees or a milestone from the sidebar.
5. Click **Create**.

GitHub assigns the issue a number (e.g. `#123`), which you use to link it to a PR.

#### Link a pull request to an issue

GitHub can close an issue automatically when a PR is merged.

In the PR description, add a keyword followed by the issue number, e.g. `Closes #123`. `Fixes` and `Resolves` also work. When the PR is merged, the issue closes automatically.

Issues only close automatically when the PR is merged into the repo's default branch. With `dev` as the default (see "After either option: set dev as the default branch on GitHub" in Part 1), this works for feature PRs into `dev`, but not for release PRs into `main`.

To link without closing, mention the issue (`#123`) in the description, or use the **Development** section in the PR sidebar.