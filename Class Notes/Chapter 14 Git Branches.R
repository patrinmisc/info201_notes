### 14 GIT BRANCHES ###
# so git is very powerful because it provides you with version control 
# and collaboration.

#Every commit on a project has a message that goes with it, as well as an
#SHA-1 hash which is a series of random letters and numbers.  This functions
#kind of like an id

# branching lets you fuck with aspects of the project nonchronologically.
# the item with an asterisk (*) is the current branch you're in.  The most
# recent commit in that branch is called the HEAD
git branch # lets you view all currently existing branches
git branch [branch_name] # creates a new branch named branch_name and sets it
						 # to your current commit

git checkout [branch_name] # switches to a pre-existing branch.  HEAD (which is
						   # kinda like currentIndex) switches to the branch
git checkout -b [branch_name] # creates AND checks out branch_name

# DELETE a branch
git branch -d [branch_name] 

# merge a branch with THE CURRENT ONE
git merge [other_branch]


### 14.2 MERGE CONFLICTS ###
# if the same line of code is modified in both HEAD and the other branch
# that you're merging with, it'll create a merge conflict.  use git status
# to figure out which files have conflicts and go through them manually to
# figure out what needs to be fixed


### 14.3 UNDOING CHANGES ###
# you'll need to know your commit's SHA-1 hashes to be able to do this.
# this lets you see the commit's SHA-1 hashes
git log --oneline

# then use git checkout to replace your file
# commit_number is the SHA-1 of the version you want
# file_name is a single file. This code replaces your file with commit_number's
# version of that file--an older version.
git checkout [commit_number] [file_name]

# doing this refers to HEAD, which is the most recent commit.
git checkout -- [file_name]

git checkout -b [branch_name] [commit_number] # creates AND checks out branch_name

# if you have a long branch and only want to reverse a single commit
# from the branch, you can specify.  The edits made in commit_number
# will be undone, and nothing else will be touched
git revert [commit_number] --no-edit 

# if I'm working on a branch with github and I want to push the entire
# branch and keep it separate from master, then do this
git push origin [branch_name]
git push -u origin [branch_name] # do this the first time you push it so github
								 # can track the two as being the same thing


### 14.4.1 GITHUB PAGES ###
# in github, if you have a remote branch named gh-pages, the website will render
# it as a webpage for visitors to see
git checkout master 
git checkout -b gh-pages

git push -u origin gh-pages