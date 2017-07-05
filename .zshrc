# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='vim'

source ~/.zsh-secrets

alias ctags="`brew --prefix`/bin/ctags"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_THEME="agnoster"
# ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode thefuck)

# User configuration
source $ZSH/oh-my-zsh.sh

export SPARK_HOME=~/tubular/spark2/spark-2.1.0-bin-hadoop2.7
#
# fzf - kill
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
# fzf - cd into the directory of the selected file
fcd() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
# fzf history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" |
    fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fs() {
    local session
    session=$(tmux list-sessions -F "#{session_name}" | \
        fzf --query="$1" --select-1 --exit-0) &&
        tmux attach -t "$session"
}

alias vimf='vim $(fzf)'

ide() {
 tmux new-session -s $1 -d "vim"
 tmux select-pane -t $1.0
 tmux split-window -v -t $1 "zsh"
 tmux attach -t $1
}

cat_kafka() {

/Users/psk/confluent-2.0.1/bin/kafka-avro-console-consumer \
	--bootstrap-server "polaris.kafka.tubularlabs.net:9092" \
	--property schema.registry.url=http://sr.tubularlabs.net:8081/ \
	--topic "$1" \
	--new-consumer

}

cat_kafka_json() {

/Users/psk/confluent-2.0.1/bin/kafka-console-consumer \
	--bootstrap-server "polaris.kafka.tubularlabs.net:9092" \
	--topic "$1" \
	--new-consumer

}

jupie() {
    temr --name="$1" --core-instances=${2:-2:c3.2xlarge} --no-auto-terminate --boot-pypackage='matplotlib' --boot-pypackage='pandas' --boot-pypackage='tubular-pyspark' --boot-pypackage='sparkly==2.0.2' --boot-pypackage='tubular-avroplane==0.13.0.dev.1' --boot-pypackage=tubular-jupacca --boot-pypackage=matplotlib -- jupacca
}

djupie() {
    docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -p 8888:8888 -p 4040:4040 -it registry.tubularlabs.net/temr/emr-5-2-1-dev:0.0.4 jupacca
}

djupie_old() {
    docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -p 8888:8888 -p 4040:4040 -it registry.tubularlabs.net/temr/emr-4-3-0-dev:0.0.2 jupacca
}


ddev() {
    docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -p 8888:8888 -p 4040:4040 -it registry.tubularlabs.net/emr:4.3.0.dev /bin/bash
}

denv() {
    docker-machine start $*
    docker-machine env $*
    eval $(docker-machine env $* )
}

ddev() {
    docker-compose run dev /bin/bash
}

dkafka() {
   docker-compose -f ~/tubular/repos/tbcode/pkg-castor/docker-compose.yml run -e ZOO="zookeeper.service.tubular:2181/kafka-taurus" kafka.docker /bin/bash
}

dprod() {
    export DOCKER_HOST="tcp://docker.tubularlabs.net:2375"
}

dbash() {
    docker-compose run $* /bin/bash
}

gappend() {
    git config --global push.default current
    git add -u
    git commit --amend --no-edit
    git push origin --force
}

gff() {
    git fetch
    git merge --ff-only
}

alias gri="git rebase --interactive"

alias goinfra="cd ~/tubular/repos/infrastructure"
alias gotb="cd ~/tubular/repos/tbcode"
alias gomesos="cd ~/tubular/repos/mesos-jobs"

alias gb="git checkout -b"
alias gp="git push origin HEAD"

alias dc="docker-compose"
alias dcb="docker-compose build"
alias dcr="docker-compose run"
alias dbuild="docker-compose build"
alias drun="docker-compose run"
alias dbash="docker-compose run dev /bin/bash"
alias dup="docker-compose up -d"
alias ddown="docker-compose down -v"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# added by travis gem
[ -f /Users/psk/.travis/travis.sh ] && source /Users/psk/.travis/travis.sh
source /Users/psk/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tmuxinator
source ~/.tmuxinator.zsh

[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"
