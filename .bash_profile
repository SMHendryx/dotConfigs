### UTILITIES

# fixlines: converts files with non-unix end-of-lines (\r = mac, \r\n = win) with unix (\n)
# usage: $ fixlines <filename> 
fixlines () { /usr/bin/perl -pi~ -e 's/\r\n?/\n/g' "$@" ; }

# The following aliases (save & show) are for saving frequently used directories
# You can save a directory using an abbreviation of your choosing. Eg. save ms
# You can subsequently move to one of the saved directories by using cd with
# the abbreviation you chose. Eg. cd ms  (Note that no '$' is necessary.)
alias sdirs='source ~/.bash_dirs' 
alias show='cat ~/.bash_dirs'
save () { /usr/bin/sed "/$@/d" ~/.bash_dirs > ~/.bash_dirs1; \mv ~/.bash_dirs1 ~/.bash_dirs; echo "$@"=\"`pwd`\" >> ~/.bash_dirs; source ~/.bash_dirs ; }
# Initialization for the above 'save' facility:
# source the .sdirs file:
sdirs
# set the bash option so that no '$' is required when using the above facility
shopt -s cdable_vars

# Print ~/.ssh/config host entry
# e.g. sph etana
#
function sph ()
{
  h=$1
  out="Host $h\n\tProxyCommand ssh -q -W %h:%p tunnel1\nHost ${h}2\n\tHostName ${h}.sista.arizona.edu\n\tProxyCommand ssh -q -W %h:%p tunnel2"
  echo -e $out
  # Put into clipboard
  if [ $OS == "Mac" ]; then
  echo -e $out | pbcopy
  fi
}

### ALIASES

alias l='ls -lF'
alias ll='ls -alF'
alias blast='rm -rfv *~ .*~ *.*~ \#*\# \#*.*\#'
alias p2lw1='lpr -Plw1 -o sides=two-sided-long-edge'

# clean: recursively find all "compiled files" for MCL lisp, java, python and move them to ~/graveyard
alias clean='find . \( -name "*.fasl" -o -name "*.class" -o -name "*.pyc" \) -exec mv "{}" ~/graveyard \; -print'

alias maked='rm make_dribble.txt; make >>make_dribble.txt 2>&1; subl -n make_dribble.txt'

# clean: recursively removes all "compiled files" for MCL lisp, java, python
# alias clean='find . \( -name "*.fasl" -o -name "*.class" -o -name "*.pyc" \) -exec rm -f "{}" \; -print'
# alias clean='find . \( -name "*.fasl" -o -name "*.class" \) -exec rm -f "{}" \; -print'


# bind port 9999 to tunnel1 -- approximates vpn


### EDITOR

export EDITOR='vim'


### PYTHON

export WORKON_HOME="/Users/seanmhendryx/.python_virtual_envs"

# virtualenvwrapper
# the following two exports are probably not strictly necessary
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python"
export VIRTUALENVWRAPPER_VIRTUALENV="/usr/local/bin/virtualenv"
# this is necessary to use virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=false
# cache pip-installed packages to avoid re-downloading
# the pip cache is now noted as deprecated -- pip manages its own cache
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# to allow pip installs when NOT in a virtualenv
# from: http://hackercodex.com/guide/python-development-environment-on-mac-osx/
# example: syspip install --upgrade --no-use-wheel pip setuptools virtualenv
syspip()
{
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

#export PATH="/usr/local/opt/scala@2.11/bin:$PATH"

mkcd () {
  case "$1" in /*) :;; *) set -- "./$1";; esac
  mkdir -p "$1" && cd "$1"
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source ~/.profile

eval "$(direnv hook bash)"

