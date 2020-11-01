# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
alias vi='vimx'
alias vim='vimx'
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export GOPATH=/home/ik/go
export GOROOT=/usr/local/go
export GOBIN=/usr/local/go/bin
PATH=$PATH:$GOBIN
alias ls='ls -lah --color=always'
alias work="cd $GOPATH/src/github.com"
alias git='hub'
alias pbcopy='xclip -selection clipboard'
export PATH
# FindFast
ff() {
	grep -nrw $1 -e "$2"
}
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source <(kubectl completion bash)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export CSCOPE_EDITOR=`which vimx`
