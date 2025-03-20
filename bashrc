# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#我自己的IC开发环境

export IC_HOME=/home/dy/IC
export VIP_HOME=$IC_HOME/vips/vip2018
export DISPLAY=:11.0

Install_Home=/home/dy/softwares/synopsys
export DVE_HOME=$Install_Home/vcs/O-2018.09-SP2
export VCS_HOME=$Install_Home/vcs/O-2018.09-SP2
export VCS_MX_HOME=$Install_Home/vcs-mx/O-2018.09-SP2
export LD_LIBRARY_PATH=$Install_Home/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/LINUX64
export VERDI_HOME=$Install_Home/verdi/Verdi_O-2018.09-SP2
export SCL_HOME=$Install_Home/scl/2018.06
#VIP的HOME路径
export DESIGNWARE_HOME=/home/dy/IC/vips/vip_installed/
export INCLUDE_HOME=$DESIGNWARE_HOME/vip/svt/amba_svt/latest/sverilog/include
export VSCODE_SETTING=/home/dy/.vscode-server/data/Machine/settings.json
#dve
PATH=$PATH:$VCS_HOME/gui/dve/bin
alias dve="dve"

#VCS
PATH=$PATH:$VCS_HOME/bin
alias vcs="vcs"
# alias cd='function _cd(){ builtin cd "$@" && ls; }; _cd'

# 自定义 cd 命令，支持 "cd last"
cd_func() {
    # 保存当前目录到临时变量
    local current_dir=$(pwd)
    
    if [ "$1" = "last" ]; then
        # 如果执行 cd last，切换到上次记录的目录
        if [ -n "$LAST_DIR" ]; then
            builtin cd "$LAST_DIR" && ls
            export LAST_DIR="$current_dir"
        else
            echo "No last directory to return to."
        fi
    else
        # 如果是普通的 cd，先保存当前目录到 LAST_DIR
        builtin cd "$@" && ls
        export LAST_DIR="$current_dir"
    fi
}

# 将 cd_func 替换为 cd 命令
alias cd=cd_func

# 启用自动补全功能（保证正常使用 tab 自动补全）
complete -F _cd cd



#VERDI
PATH=$PATH:$VERDI_HOME/bin
alias verdi="verdi"

#scl
PATH=$PATH:$SCL_HOME/linux64/bin
export VCS_ARCH_OVERRIDE=linux

#LICENCE--这@后面的是hostname，
export LM_LICENSE_FILE=27050@ubuntu
alias lmg_synopsys="lmgrd -c $Install_Home/scl/2018.06/admin/license/Synopsys.dat -l $Install_Home/scl/2018.06/admin/license/logs/debug.log"
eval "$(thefuck --alias fuck)"
# alias lmg_synopsys="lmgrd -c /home/dy/Softwares/synopsys/scl/2018.06/admin/license/Synopsys.dat"

# export UVM_HOME=/home/dy/Softwares/Envs/uvm-1.1a
export UVM_HOME=$VCS_HOME/etc/uvm-1.2
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dy/softwares/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dy/softwares/miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/dy/softwares/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/dy/softwares/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

