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
