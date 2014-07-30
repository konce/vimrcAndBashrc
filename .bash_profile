# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
# https://gist.github.com/hSATAC/5591270#file-gistfile1-sh
# Usage: pr (pull request current branch into develop)
# Usage 2: pr stable (pull request current branch into stable)
# Notice: replace "team" with your github team account.
 
function pr() {
    base=$1;
    if [ "$1" == "" ]; then
        base="develop"
    fi
    hub pull-request -b team:"$base" -h team:`git rev-parse --abbrev-ref HEAD`;
}


# User specific environment and startup programs

function git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo "("${ref#refs/heads/}") ";
}
 
function git_since_last_commit {
    now=`date +%s`;
    last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
    seconds_since_last_commit=$((now-last_commit));
    minutes_since_last_commit=$((seconds_since_last_commit/60));
    hours_since_last_commit=$((minutes_since_last_commit/60));
    minutes_since_last_commit=$((minutes_since_last_commit%60));
    
    echo "${hours_since_last_commit}h${minutes_since_last_commit}m ";
}
 
PS1="[\[\033[1;32m\]\w\[\033[0m\]] \[\033[0m\]\[\033[1;36m\]\$(git_branch)\[\033[0;33m\]\$(git_since_last_commit)\[\033[0m\]$ " 

PATH=$HOME/bin:$PATH
export PATH

source $HOME/.bash_prompt

umask 0002

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
