#! /usr/bin/fish

function git_create_branch
    set branch_name $argv[1]
    set defaultBranch (git config --get init.defaultBranch)
    git checkout $defaultBranch && git pull && git checkout -b $branch_name \
		&& echo -e "\nBranch \"$branch_name\" is created successfully."
end

function git_delete_branch
    set branch_name $argv[1]
    set defaultBranch (git config --get init.defaultBranch)
   
    git checkout $defaultBranch && git branch -d $branch_name
end

function git_waiting_commits_to
    set branch_name $argv[1]
   
    # if the branch name is not set then set the branch name to "main" by default.
    if test -z "$branch_name"
        set branch_name "main"
    end

    git cherry -v $branch_name
end

function git_commit_fixup
    set hash_id $argv[1]

    if test -z "$branch_name"
        echo 'USAGE: git_commit_fixup ${HASH_ID}'
        return
    end

    git commit --fixup=$hash_id
end

function git_remove_merged_commits
    set master_branch_name $argv[1]

    # if the branch name is not set then set the branch name to "main" by default.
    if test -z "$branch_name"
        set master_branch_name "main"
    end

    git branch --merged $master_branch_name | grep -v '^\*' | xargs -n 1 git branch -d
end
