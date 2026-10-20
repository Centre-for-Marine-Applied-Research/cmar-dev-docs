# Git & GitHub Workflow Guide (Positron IDE)

Note: this document was made with assistance from an LLM, with the structure and content explicitly defined. It is undergoing human testing and review.

A beginner-friendly workflow using branches and pull requests (PRs). Every step uses Positron's buttons, menus and Command Palette. No terminal needed (a few exceptions are flagged).

**Core workflow:** `main` holds stable, release-ready work, and `dev` is where finished features come together. Do your work on a feature branch created from `dev`, merge it into `dev` through a PR, then merge `dev` into `main` through another PR when you're ready to release.

## Finding your way around Positron

Positron is built on the same foundation as VS Code, so Git works the same way.

- **Source Control view:** click the branch-shaped icon in the left Activity Bar (or press `Ctrl+Shift+G`, `Cmd+Shift+G` on Mac). It lists your changes, holds the commit message box, and has a **⋯ (More Actions)** menu with most Git actions (Pull, Push, Branch, Stash, and so on).
- **Status bar (bottom-left):** shows your current branch name. Click it to switch or create branches. The sync icon next to it pulls and pushes.
- **Command Palette:** press `Ctrl+Shift+P` (`Cmd+Shift+P` on Mac), then type `Git:` to see every Git action. Pick one and follow the prompts.
- **Menus can differ slightly** between Positron versions. If you can't find an item, search for it in the Command Palette.

## Key terms

- **Repository (repo):** a project folder tracked by Git.
- **Commit:** a saved snapshot of your changes.
- **Branch:** a separate line of work that doesn't affect other branches until merged.
- **`main`:** the stable branch holding released work.
- **`dev`:** the integration branch where completed feature branches are merged.
- **Feature branch:** a short-lived branch created from `dev` for one task.
- **Remote:** the copy of the repo on GitHub, usually named `origin`.
- **Pull request (PR):** a request to merge one branch into another, with review.
- **Staging:** choosing which changes go into the next commit.

## Quick lookup

Use this section when you know what you want to do but forgot where it lives.

### Set up a repository

| I want to | In Positron |
| --- | --- |
| Initialize a repo in the current folder | Source Control view → **Initialize Repository** |
| Copy a repo from GitHub | Command Palette → **Git: Clone** |
| Link my local repo to GitHub | Command Palette → **Git: Add Remote…** |
| Rename the current branch to `main` | Command Palette → **Git: Rename Branch…** |

### Check where you are

| I want to | In Positron |
| --- | --- |
| Check branch and changes | Status bar (branch name) and Source Control view (lists changes) |
| List local branches | Click the branch name in the status bar |
| See which remote branch mine tracks | Source Control view → **Graph** section shows local and remote branch labels side by side |
| See recent commits | Source Control view → **Graph** section, or **Timeline** in the Explorer |
| See unstaged changes | Source Control → **Changes** → click a file |
| See staged changes | Source Control → **Staged Changes** → click a file |
| See which GitHub repo I'm connected to | Command Palette → **Git: Fetch From…** lists your remotes |

### Work with branches

| I want to | In Positron |
| --- | --- |
| Create and switch to `dev` | Status bar branch name → **Create new branch…** |
| Switch to an existing branch | Status bar branch name → pick the branch |
| Create a feature branch from `dev` | Status bar branch name → **Create new branch from…** → type the name → pick `dev` |
| Merge `dev` or `main` into my current branch | Source Control **⋯** → **Branch** → **Merge…** → pick the branch |
| Delete a local branch after merging | Source Control **⋯** → **Branch** → **Delete Branch…** |

### Save changes

| I want to | In Positron |
| --- | --- |
| Stage all changes | Hover **Changes** → click **+** |
| Stage a specific file | Hover the file → click **+** |
| Unstage a specific file | **Staged Changes** → hover the file → click **−** |
| Unstage all changes | Hover **Staged Changes** → click **−** |
| Commit staged changes | Type a message in the box → click **Commit** |
| Amend the last commit | **⋯** → **Commit** → **Commit (Amend)** |

### Undo changes

| I want to | In Positron |
| --- | --- |
| Undo the last commit, keep changes | **⋯** → **Commit** → **Undo Last Commit** |
| Undo the last commit and discard the changes | Undo Last Commit, then **Changes** → **Discard All Changes** |
| Undo a pushed commit with a new commit | See "Undo a commit that's already pushed" in Part 2 |

### Sync with GitHub

| I want to | In Positron |
| --- | --- |
| Get the latest commits from the remote | **⋯** → **Pull** |
| Push my commits | **⋯** → **Push** |
| Publish a new branch to GitHub | Click **Publish Branch** in Source Control |

## Part 1: Setting up a repository

Do this once per project. Either start a new repo on your computer, or copy an existing one from GitHub.

### Option A: Initialize a repo locally and push it to GitHub

1. Open your project folder in Positron (**File** → **Open Folder…**).
2. Open the Source Control view and click **Initialize Repository**.
3. Stage all files (hover **Changes**, click **+**), type `Initial commit` in the message box, and click **Commit**.
4. On GitHub, create a new **empty** repository (no README, .gitignore or license). Copy its URL.
5. Link your local repo to GitHub: Command Palette → **Git: Add Remote…**. Enter the URL, then name it `origin`.
6. Name the branch `main`: Command Palette → **Git: Rename Branch…** → `main`. Then click **Publish Branch** in Source Control and choose `origin`.
7. Create `dev` from `main`: click the branch name in the status bar → **Create new branch…** → `dev`. Then click **Publish Branch**.

### Option B: Clone a repository from GitHub

1. On the GitHub repo page, click **Code** and copy the URL.
2. In Positron: Command Palette → **Git: Clone**, paste the URL, and choose a folder to save it in.
3. When prompted, click **Open** to open the cloned folder.
4. Switch to `dev`: click the branch name in the status bar and pick `dev` (it may appear as `origin/dev`). If the repo has no `dev` branch yet, create and publish it as in Option A, step 7.

### After either option: set `dev` as the default branch on GitHub

This part happens on GitHub's website. Do it once per repo, after `dev` exists on GitHub. New PRs will then target `dev` automatically. You need admin access to the repo.

1. On the GitHub repo page, go to **Settings**, then **Branches**.
2. Under **Default branch**, click the switch icon (⇄) next to the current default.
3. Select `dev` and click **Update**, then confirm.

## Part 2: Basic operations for day-to-day work

Work on a feature branch created from `dev`. Don't commit directly to `dev` or `main`. A typical day has three phases: get set up, work locally, then push.

### Start of the day: get set up

#### Check where you are

Do any of these when you're unsure what state your repo is in.

| I want to | In Positron |
| --- | --- |
| Know which branch I'm on | Look at the branch name in the status bar |
| See what's changed or staged | Source Control view: **Staged Changes** and **Changes** lists |
| View all local branches | Click the branch name in the status bar |
| See which remote branch mine tracks | Source Control **Graph** section shows local and remote branch labels side by side |
| View recent commits | Source Control **Graph** section, or **Timeline** (bottom of the Explorer) |
| View unstaged changes | Click a file under **Changes** to open a side-by-side diff |
| View staged changes | Click a file under **Staged Changes** |

#### Get the latest changes

Commit your work first, or set it aside with a stash (see "Stash unfinished work" in Part 4), before switching branches.

First update local `dev`: click the branch name in the status bar and pick `dev`, then Source Control **⋯** → **Pull**.

**Starting a new task?** Create a feature branch from the updated `dev`:

1. Click the branch name in the status bar → **Create new branch…**, type the branch name, and press `Enter`. It's created from your current branch (`dev`) and switched to automatically.
2. Use `type/short-description`, all lowercase, with hyphens instead of spaces:
   - `feature` for new functionality, e.g. `feature/add-login-page`
   - `fix` for bug fixes, e.g. `fix/readme-typo`
   - `docs` for documentation, e.g. `docs/update-install-steps`
   - `chore` for maintenance, e.g. `chore/update-dependencies`

**Continuing an existing branch?** Bring in the latest changes:

1. Switch to your branch: click the branch name in the status bar and pick it.
2. Get any commits teammates pushed to this branch: **⋯** → **Pull**.
3. Merge `dev` into your branch: **⋯** → **Branch** → **Merge…** → pick `dev`.
4. If Git reports conflicts, open the files listed under **Merge Changes**. Use the **Accept Current Change**, **Accept Incoming Change** or **Accept Both Changes** links above each conflict (or edit the code by hand). Then stage the file (**+**) and click **Commit** (or **Complete Merge**) to finish.

### During the day: work locally

#### Commit your work

Commit each time you finish a small, logical piece of work.

1. Stage your changes: hover **Changes** and click **+** for everything, or click **+** on individual files.
2. Type a message in the box at the top of Source Control and click **Commit**.

Writing good commit messages:

- Start with a short summary (about 50 characters) in the imperative, as if completing "This commit will…": e.g. `Add login page`, `Fix crash on empty file`.
- No period at the end of the summary.
- Make each commit one logical change.
- If the reason isn't obvious, add a blank line and a few sentences explaining *why*. In the message box, press `Enter` twice to add the blank line and a body.

#### Unstage changes

Use this if you staged a file by accident, for example by clicking **+** on **Changes**. Unstaging removes the file from your next commit but keeps your edits.

1. Check what's staged: look under **Staged Changes** in the Source Control view.
2. Unstage a single file: hover it and click **−**.
3. Or unstage everything: hover **Staged Changes** and click **−**.

The files stay changed on disk and move back under **Changes**, so you can stage them again when you're ready.

#### Amend a commit (local only)

Use this to fix a typo in the last commit message or add a forgotten file, **before you push**.

1. Stage any extra changes (**+** on the file).
2. Click **⋯** → **Commit** → **Commit (Amend)**. Edit the message in the box if you want to change it.

> Don't amend a commit that's already pushed. It rewrites history and conflicts with the remote copy. Make a new commit instead, or revert it (see "Undo a commit that's already pushed" below).

#### Undo a commit locally (not yet pushed)

You can only undo the **last** commit this way. Choose one of two options:

- **Undo the commit, keep your changes:** **⋯** → **Commit** → **Undo Last Commit**. The changes come back into the message box and file lists so you can edit and recommit. (Your changes come back staged. To unstage them, hover **Staged Changes** and click **−**.)
- **Undo the commit and discard the changes:** do **Undo Last Commit** as above, then hover **Changes** (or **Staged Changes**), click the **⋯** or right-click, and choose **Discard All Changes**.

> Discarding permanently deletes the changes. Only undo commits that haven't been pushed.

### End of the day: push your work to the remote

#### Push your work

1. Check for anything uncommitted in the Source Control view.
2. On a new branch, click **Publish Branch**, which publishes the branch to GitHub. On a branch that's already published, click **Sync Changes** or use **⋯** → **Push**.

After the first publish, later pushes on this branch only need **Push**. When the work is ready for review, continue to "Sharing work through pull requests" in Part 3.

#### Undo a commit that's already pushed

Use a revert. It adds a **new commit** that reverses the old one, so shared history stays intact.

1. Find the commit in the Source Control **Graph** section.
2. Right-click it and choose **Revert Commit**, if your Positron version offers it. If it's missing, use the integrated terminal (**View** → **Terminal**) and run `git revert <commit-hash>`.
3. Save the commit message when prompted, then push (**⋯** → **Push**).

> Erasing a pushed commit by force-pushing rewrites shared history and can break teammates' copies. Don't do it on `main`, `dev` or any shared branch.

## Part 3: Sharing work through pull requests

This part happens on GitHub's website. Changes reach `main` in two steps: a PR from your feature branch into `dev`, then a PR from `dev` into `main` when you're ready to release.

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
4. If changes are requested, the author commits and pushes more commits to the same branch in Positron. The PR updates automatically.

#### Merge a pull request

1. When the PR is approved and any checks pass, click **Merge pull request**, then **Confirm merge**.
2. Click **Delete branch** (it's no longer needed).
3. Update your local copy in Positron: switch to `dev` (status bar branch name), then **⋯** → **Pull**. Delete the local branch: **⋯** → **Branch** → **Delete Branch…** and pick your feature branch.

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
3. Update your local copy in Positron: switch to `main` (status bar branch name), then **⋯** → **Pull**.
4. Bring the merge commit back into `dev` so the two branches match: switch to `dev`, **⋯** → **Branch** → **Merge…** → pick `main`, then **⋯** → **Push**.

## Part 4: Advanced operations

You won't need these every day, but they're useful to know.

### Undo and set aside work

#### Revert a merged pull request on GitHub

Use this to undo a whole merged PR without touching Positron.

1. Open the merged PR on GitHub.
2. Click **Revert** near the bottom of the page. GitHub creates a new branch and opens a new PR that undoes the changes.
3. Review and merge the new PR as you would any other (see "Merge a pull request" in Part 3).

The revert PR targets the same branch the original was merged into. If the original change was already released to `main`, revert it in `dev`, then release again with a `dev` into `main` PR.

> Reverting a merged PR from inside Positron isn't a point-and-click action, because it needs a merge commit to be reverted with a chosen "parent". Use the GitHub **Revert** button above instead.

#### Stash unfinished work

Use this to set aside uncommitted changes, for example to switch branches before you're ready to commit.

1. Stash your changes: Source Control **⋯** → **Stash** → **Stash** (choose **Stash (Include Untracked)** to include new files).
2. Switch branches and do what you need to do.
3. Switch back to your branch and restore the changes: **⋯** → **Stash** → **Pop Latest Stash** (or **Pop Stash…** to pick one).

Other options in the same **Stash** menu: **Apply Stash…** restores a stash and keeps it saved, and **Drop Stash…** deletes one.

### Track work with GitHub issues

This part happens on GitHub's website.

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